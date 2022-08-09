#!/bin/sh

# set rand password for root
passphrase=$(cat /proc/sys/kernel/random/uuid | sed 's/[-]//g')

echo "passphrase = $passphrase"

echo "$passphrase" > passphrase.txt

echo "root:$passphrase" | chpasswd

# see https://linux.die.net/man/8/sshd
/usr/sbin/sshd -D           \
  -o ListenAddress=0.0.0.0  \
  -o PermitRootLogin=yes
