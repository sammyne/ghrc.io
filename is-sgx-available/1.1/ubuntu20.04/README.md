# is-sgx-available

## 快速开始

### 1. 环境
- Tencent OS 3.2

### 2. 容器化
```bash
docker build -t sammyne/is-sgx-available:1.1-ubuntu20.04 .
```

### 3. 运行
```bash
docker run -it --rm                               \
  --device /dev/kmsg:/dev/kmsg                    \
  --device /dev/sgx_enclave:/dev/sgx/enclave      \
  --device /dev/sgx_provision:/dev/sgx/provision
  sammyne/is-sgx-available:1.1-ubuntu20.04
```

其中显示 EPC 大小的关键行样例如下
```bash
EPC size: 0x1fc0000000
```

表示 EPC 大小为 `0x1fc0000000` **字节**。
