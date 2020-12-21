#!/bin/bash

set -e

workingDir=${PWD}

if [ -z "$1" ]; then
  echo "missing namespace of form 'hub/user'"
fi
namespace=$1

# filter out files in folder like 'libfaketime/0.9.8/alpine3.12/'
# @dev '/' needs no escaping
#git diff HEAD~ HEAD --name-status | grep -E '^[^/]+/[^/]+/[^/]+/[^/]+'
packages=$(git diff HEAD~ HEAD --name-only | \
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
  pkgDir=${workingDir}/$v
  cd ${pkgDir}

  if [ ! -f "${pkgDir}/Dockerfile" ]; then
    echo ""
    echo "[-] skipping $v due to no Dockerfile"
    continue
  fi

  vv="${v/\//:}" # replace 1st '/' as ':'
  repoTag="${namespace}/${vv//\//-}" # replace all '/' as '-'
  echo ""
  echo "[+] building $v as $repoTag"
  docker build -t ${repoTag} .
  echo "[+] done building $v as $repoTag"
  echo "[+] pushing $v as $repoTag"
  docker push ${repoTag}
  echo "[+] done pushing $v as $repoTag"
done

echo ""
