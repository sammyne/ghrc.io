# gramine-sgx-get-token

## Quickstart

```bash
repo_tag=gramine-sgx-get-token:alpha

docker build -t $repo_tag .

# these paths are within the running docker container
workdir=/gramine
sig=$workdir/hello.sig
output=$workdir/hello.token

docker run -it --rm \
  -v $PWD:$workdir  \
  -w $workdir       \
  $repo_tag         \
  gramine-sgx-get-token --sig $sig --output $output

# The final token has been written to $output
```
