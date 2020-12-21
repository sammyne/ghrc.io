#!/bin/bash

workingDir=${PWD}

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

namespace="ghcr.io/sammyne"

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
