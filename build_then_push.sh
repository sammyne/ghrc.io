#!/bin/bash

set -e

workingDir=${PWD}

if [ -z "$1" ]; then
  echo "missing namespace of form 'hub/user'"
  exit -1
fi
namespace=$1

builtPkgs=""
## -- functions     --
buildThenPush() {
  pkg=$1
  if [ -z "$pkg" ]; then
    echo "missing package"
    exit -1
  fi

  if [[ $builtPkgs =~ "|$pkg|" ]]; then
    echo "[-] skipping $pkg to avoid duplicate builds"
    return 0
  fi
  builtPkgs="$builtPkg|$pkg|"

  pkgDir=$workingDir/$pkg
  cd $pkgDir

  if [ ! -f "$pkgDir/Dockerfile" ]; then
    echo ""
    echo "[-] skipping $pkg due to no Dockerfile"
    continue
  fi

  vv="${pkg/\//:}" # replace 1st '/' as ':'
  repoTag="${namespace}/${vv//\//-}" # replace all '/' as '-'
  echo ""
  echo "[+] building $pkg as $repoTag"
  docker build -t $repoTag .
  echo "[+] building $pkg as $repoTag done"
  echo "[+] pushing $pkg as $repoTag"
  docker push $repoTag
  echo "[+] pushing $pkg as $repoTag done"

  # DFS to rebuild dependents
  dependents=$(findDependents "$repoTag")
  if [ -z "$dependents" ]; then
    return 0
  fi

  for v in ${dependents[@]}; do
    buildThenPush ${v%%/Dockerfile}
  done
}

findDependents() {
  if [ -z "$1" ]; then
    echo "missing package path"
    exit -1
  fi

  cd $workingDir
  grep -r "FROM $1" * | grep "Dockerfile" | awk -F":" '{print $1}'
}
## -- functions END --

# sees https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
echo "GITHUB_SHA = $GITHUB_SHA"
echo "GITHUB_BASE_REF = $GITHUB_BASE_REF"

# filter out files in folder like 'libfaketime/0.9.8/alpine3.12/'
# @dev '/' needs no escaping
# options '--diff-filter' sees https://git-scm.com/docs/git-diff#git-diff---diff-filterACDMRTUXB82308203
# 'origin' is required, other error 'unknown revision or path not in the working tree.'
packages=$(git diff origin/$GITHUB_BASE_REF $GITHUB_SHA --name-only --diff-filter=d | \
  grep -E '^[^/]+/[^/]+/[^/]+/[^/]+' | \
  xargs -I {} dirname {} | \
  awk -F"/" '{print $1"/"$2"/"$3}' | \
  uniq)

# for debug
#echo "packages to build"
#echo "$packages"

# GITHUB_ACTOR is env var defined by Github Actions
#user=${GITHUB_ACTOR}

for v in ${packages[@]}; do
  buildThenPush $v
done

echo ""
