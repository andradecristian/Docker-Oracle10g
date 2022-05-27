#!/bin/bash
cat > /etc/sysctl.conf <<'EOF'
kernel.shmall = 2097152
kernel.shmmax = 2147483648
kernel.shmmni = 4096
## semaphores: semmsl, semmns, semopm, semmni
kernel.sem = 250 32000 100 128
fs.file-max = 327679
net.ipv4.ip_local_port_range = 1024 65000
net.core.rmem_default=262144
net.core.rmem_max=262144
net.core.wmem_default=262144
net.core.wmem_max=262144
EOF

cat > /etc/security/limits.conf <<'EOF'
oracle   soft   nofile    1024
oracle   hard   nofile    65536
oracle   soft   nproc    2047
oracle   hard   nproc    16384
oracle   soft   stack    10240
oracle   hard   stack    32768
oracle   hard   memlock    134217728
oracle   soft   memlock    134217728
EOF
