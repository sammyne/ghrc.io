# optee

## Quickstart

### 1. Build the image
```bash
docker build -t sammyne/optee:alpha .
```

### 2. Run the image in a linux with GUI

```bash
if [ -z "$DISPLAY" ]; then echo "required GUI"; exit 1; fi

docker run -it --rm 				        \
	-e DISPLAY=$DISPLAY 			        \
	--pull always 				            \
	-v /tmp/.X11-unix:/tmp/.X11-unix 	\
  sammyne/optee:alpha bash
```

### 3. Run the examples within container

```bash
make run -j `nproc`
```

On success, logs at the end should be like

```bash
make[1]: Entering directory '/optee/build'
ln -sf /optee/build/../out-br/images/rootfs.cpio.gz /optee/build/../out/bin/

* QEMU is now waiting to start the execution
* Start execution with either a 'c' followed by <enter> in the QEMU console or
* attach a debugger and continue from there.
*
* To run OP-TEE tests, use the xtest command in the 'Normal World' terminal
* Enter 'xtest -h' for help.

cd /optee/build/../out/bin && /optee/build/../qemu/build/aarch64-softmmu/qemu-system-aarch64 \
	-nographic \
	-serial tcp:localhost:54320 -serial tcp:localhost:54321 \
	-smp 2 \
	-s -S -machine virt,secure=on,mte=off,gic-version=3,virtualization=false \
	-cpu max,pauth-impdef=on \
	-d unimp -semihosting-config enable=on,target=native \
	-m 1057 \
	-bios bl1.bin		\
	-initrd rootfs.cpio.gz \
	-kernel Image -no-acpi \
	-append 'console=ttyAMA0,38400 keep_bootcon root=/dev/vda2 ' \
	 \
	-object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0,max-bytes=1024,period=1000 -netdev user,id=vmnic -device virtio-net-device,netdev=vmnic
QEMU 7.2.0 monitor - type 'help' for more information
(qemu)
```

where `(qemu)` is the prompt waiting for instructions. Type `c` to continue.

We would see another two new terminals opened with **TITLE PREFIX** as `Normal World` and `Secure World`.

In the `Normal World` terminal, we should see sample logs as 

```bash
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: OK
Set permissions on /dev/tee*: OK
Create/set permissions on /data/tee: OK
Starting tee-supplicant: Using device /dev/teepriv0.
OK
Starting network: OK
Starting network (udhcpc): OK

Welcome to Buildroot, type root or test to login
buildroot login:
```

Type `root` to login, and then run the hello-world app as

```bash
/usr/bin/optee_example_hello_world
```

Finally, standard output goes as

```bash
Invoking TA to increment 42
TA incremented value to 43
```
