#!/bin/bash

set -e

cd $(dirname $(which protoc))

for v in $(ls grpc_*_plugin); do
  lang=$(echo $v | sed -E 's|^grpc_(.+)_plugin$|\1|')
  if [ $lang == "cpp" ]; then
    ln -sf $v protoc-gen-grpc
    continue
  fi
  ln -sf $v protoc-gen-grpc_$lang
done
