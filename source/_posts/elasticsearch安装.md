
---
title: elasticsearch安装
---

<a name="UHFk0"></a>
## 一、centos7安装elasticsearch6.8.9

我这边使用的是华为开源镜像站的elasticsearch,官网也可以<br />[https://repo.huaweicloud.com/elasticsearch/](https://repo.huaweicloud.com/elasticsearch/)
<a name="oi5Fd"></a>
### 1.安装elasticsearch-6.8.9
```
cd /opt/
wget  https://repo.huaweicloud.com/elasticsearch/6.8.9/elasticsearch-6.8.9.tar.gz
tar -zxvf elasticsearch-6.8.9.tar.gz
```

<a name="bVhyU"></a>
### 2.elasticsearch需要安装java环境
```
sudo yum install java-openjdk-devel java-openjdk

cat > /etc/profile.d/java8.sh <<EOF 
export JAVA_HOME=$(dirname $(dirname $(readlink $(readlink $(which javac)))))
export PATH=\$PATH:\$JAVA_HOME/bin
export CLASSPATH=.:\$JAVA_HOME/jre/lib:\$JAVA_HOME/lib:\$JAVA_HOME/lib/tools.jar
EOF
```
<a name="aKyDH"></a>
### 3.然后看下vm的内存配置够不够6.8.9也是起码需要 262144虚拟内存区域
```
vi /etc/sysctl.conf 
配置好的，填写大一些
vm.max_map_count=655360

vm.max_map_count=262144
```
执行命令，生效配置
```
sysctl -p
```
<a name="bgyao"></a>
### 4.配置es用户来启动elasticsearch（root用户不允许启动）
```
# 创建用户名为 es 的用户
useradd es
# 设置 es 用户的密码
passwd es
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/304354/1625048177757-54c04a96-cbb3-4805-ac19-948171a3ef15.png#crop=0&crop=0&crop=1&crop=1&height=110&id=u69069bbb&margin=%5Bobject%20Object%5D&name=image.png&originHeight=110&originWidth=632&originalType=binary&ratio=1&rotation=0&showTitle=false&size=14308&status=done&style=none&title=&width=632)
```
# 将 /opt/elasticsearch-6.8.9 的拥有者设置为 es
chown -R es:es /opt/elasticsearch-6.8.9
```
<a name="nszis"></a>
### 5.修改配置文件，默认9200，最后一行不写也可
```
ifconfig查看下内网地址
vim config/elasticsearch.yml


network.host: 你服务器的内网ip
http.port: 9200 
```
<a name="tLMrW"></a>
### 6.切换用户运行elasticsearch
```
su es
./bin/elasticsearch
```

<a name="HpXrO"></a>
### 7.打开浏览器访问：
```
你的公网ip加端口
http://119.3.125.166:9200/ 
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/304354/1625047463619-59ba2191-c0e2-4699-a898-293146ccf0d6.png#crop=0&crop=0&crop=1&crop=1&height=524&id=ue1f04885&margin=%5Bobject%20Object%5D&name=image.png&originHeight=524&originWidth=485&originalType=binary&ratio=1&rotation=0&showTitle=false&size=29724&status=done&style=none&title=&width=485)<br />最后别忘了去云服务器控制台把安全组端口9200开放

到这里算是启动好了，但是是前台方式启动，会话一关闭服务就停止了，所以需要后台运行
```
./bin/elasticsearch -d
```


<a name="cgliR"></a>
## 二、基于docker （任选一个即可）
<a name="jj8y7"></a>
### 1.elasticsearch:6.8.16 + elastichd(可视化)
```
$ docker run -p 9200:9200 -d --name elasticsearch elasticsearch:6.8.16
$ docker run -p 9800:9800 -d --link elasticsearch:demo containerize/elastichd
```
<a name="Y8HT6"></a>
### 2.elasticsearch:6.8.16 + dejavu（可视化）
```
docker run -p 9200:9200 -d --name elasticsearch elasticsearch:6.8.16
docker run -p 1358:1358 -d appbaseio/dejavu
```


