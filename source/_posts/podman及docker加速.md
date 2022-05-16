---
title: podman及docker加速
---

centos8（podman配置）<br />镜像加速配置文件
```
 vim /etc/containers/registries.conf
```
```
unqualified-search-registries = ["docker.io"]
[[registry]]
prefix = "docker.io"
location = "mirror.iscas.ac.cn"
```

centos7(docker配置)<br />可选镜像源，任选其中一个

网易加速 7ms
```bash
https://hub-mirror.c.163.com
```
阿里加速 7ms，不过在centos8下做加速比较慢<br />这里直接在阿里搜索镜像加速就会出现你对应的一个加速地址。这里不做介绍
```bash
bhqsp9z7.mirror.aliyuncs.com这个是我自己阿里云的加速，每个阿里用户都有一个
```

镜像加速配置文件mirror.iscas.ac.cn这个镜像加速很快
```
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://mirror.iscas.ac.cn"]
}
EOF
或
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://hub-mirror.c.163.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
```
```bash
docker info //查看有没有设置成功
time docker pull mysql 查看下载时间
```




