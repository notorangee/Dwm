# MyDwm
## 克隆存储库
```shell
$ git clone https://github.com/AvavaAvaOrange/MyDwm.git 

```
## 构建&安装
```shell

$ cd MyDwm

# make clean install

```

## 配置X11
### 安装xorg-xinit
```shell 
# pacman -S xorg xorg-xinit
```

### 拷贝配置文件

```shell
# mv .xinitrc $HOME/.xinitrc

```
## 安装ly显示管理器

项目主页：https://github.com/nullgemm/ly

## 克隆&编译Ly
克隆Ly存储库
```
$ git clone --recurse-submodules https://github.com/nullgemm/ly.git
```

编译Ly
```
$ make
```

测试运行 默认运行在tty2
```
$ sudo make run
```

安装Ly
```
$ sudo make install
```

开机启动
```
$ sudo systemctl enable ly.service
```

如果您需要在 Ly 启动后在 tty 之间切换，您还必须在 Ly 的 tty 上禁用 getty 以防止“登录”在其上产生
```
$ sudo systemctl disable getty@tty2.service
```

## 重启设备

```shell
$ reboot
```

--------



