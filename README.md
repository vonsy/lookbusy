# lookbusy
提高服务器资源利用率,资源就是预算,不用就没了.

## 原版
```
lookbusy -- a synthetic load generator http://www.devin.com/lookbusy/
lookbusy -c 50 #占用所有CPU核心各50%
lookbusy -c 50 -n 2 #占用两个CPU核心各50%
lookbusy -c 50-80 -r curve #占用所有CPU核心在50%-80%左右浮动
lookbusy -c 0 -m 128MB -M 1000 #每1000毫秒,循环释放并分配 128MB 内存
lookbusy -c 0 -d 1GB -b 1MB -D 10 #每10毫秒,循环进行1MB磁盘写入,临时文件不超过1GB
# 后台运行
nohup lookbusy -c 15-50 -r curve -m 8GB -M 2000 > /dev/null 2>&1 &
```
## 容器化
```
# 构建
docker build -t nostr:1.0 .
# 构建,不使用缓存
docker build --no-cache  -t nostr:1.0 .
# 构建指定阶段镜像
docker build --target builder -t nostr:1.0 .
# 导出tar
docker save -o ~/Desktop/nostr.tar nostr:1.0
# 运行
# MIN,CPU最小占用
# MAX,CPU最大占用
# MEM,内存占用(e.g. 500MB, 5GB)
docker run -d --name nostr -e MIN=15 -e MAX=25 -e MEM=4GB vonsy/nostr:latest
```
