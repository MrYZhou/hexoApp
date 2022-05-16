---
title: docker和docker-compose
---
## 基本的安装
### docker安装
```
yum install docker-ce
```
### docker-compose安装通过源码
```
curl -L https://github.com/docker/compose/releases/download/1.29.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```
1.29.1这个是版本，具体得看官方新版tag,对应的换。<br />[https://github.com/docker/compose/tags](https://github.com/docker/compose/tags)<br />可执行权限
```
chmod +x /usr/local/bin/docker-compose
```
检测是否成功
```
docker-compose --version
```
### docker-compose安装通过pip
先安装pip
```
yum -y install python-pip
yum -y install epel-release // 如果你的源执行pip安装失败可用
```
```
pip3 install docker-compose
```
## docker版本升级

移除旧版相关软件包,下载新版本，更新版本会有点慢。
```bash
第一种配置docker华为源

rpm -qa | grep docker | xargs yum remove -y;
wget -O /etc/yum.repos.d/docker-ce.repo https://repo.huaweicloud.com/docker-ce/linux/centos/docker-ce.repo \
&& sudo sed -i 's+download.docker.com+repo.huaweicloud.com/docker-ce+' /etc/yum.repos.d/docker-ce.repo \
&& yum makecache fast && yum install docker-ce -y

第二种。这是官网但是有时候不稳定
rpm -qa | grep docker | xargs yum remove -y;
curl -fsSL https://get.docker.com/ | sh


第三种
curl -fsSL https://www.larryane.xyz/docker-config.sh | sh




```
```
systemctl restart docker
systemctl enable docker
docker -v
```

## docker-compose文件编写
1.示例<br />新建文件compose.yml<br />nginx
```bash
version: "3"
services:
  nginx:
    image: nginx:latest
    container_name: nginx_lar
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /etc/nginx/conf.d/:/etc/nginx/conf.d/
      - /etc/nginx/cert/:/etc/nginx/cert/ 
      - /home/vite/dist/:/home/vite/dist/ 

```
mysql
```bash
version: "3"
services:
  mysql:
    image: mysql:8.0
    container_name: mysql_lar
    environment:
      MYSQL_ROOT_PASSWORD: root
    ports:
      - "3306:3306"
    volumes:
      - /var/mysql:/var/mysql
```
