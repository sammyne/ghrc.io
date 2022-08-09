# pck-id-retrieval-tool

## 1. 快速开始

### 1.1. 构建镜像

```bash
docker build -t sammyne/pck-id-retrieval-tool:alpha .
```

### 1.2. 提取 sgx 机器的硬件信息

```bash
docker run -it --rm                              \
  --device /dev/sgx/enclave:/dev/sgx/enclave     \
  --device /dev/sgx/provision:/dev/sgx/provision \
  sammyne/pck-id-retrieval-tool:alpha
```
