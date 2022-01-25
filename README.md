# Dwm
## 克隆存储库
```shell
$ git clone https://github.com/AvavaAvaOrange/Dwm.git 

```
## 修改配置
打开配置文件 我使用的是neovim
```shell
$ cd Dwm

# nvim config
```

把路径中的YourUserName改为你的用户名
```shell
  static const char *trayerstart[] = { "/home/YourUserName/Dwm/Script/trayerstart.sh", NULL };
  static const char *trayeroff[]   = { "/home/YourUserName/Dwm/Script/trayeroff.sh", NULL };
  static const char *backlightUp[] = { "/home/YourUserName/Dwm/Script/backlightUp.sh", NULL};
  static const char *backlightDown[] = { "/home/YourUserName/Dwm/Script/backlightDown.sh", NULL};
  static const char *soundUp[] = { "/home/YourUserName/Dwm/Script/soundUp.sh", NULL};
  static const char *soundDown[] = { "/home/YourUserName/Dwm/Script/soundDown.sh", NULL};
```

## 构建&安装
```shell

# make clean install

```

## 安装脚本依赖
### 使用aur安装
```shell 
# pacman -S xorg xorg-xinit backlight_control typora-free
```

### 拷贝.xinitrc配置文件

```shell
# mv .xinitrc $HOME/.xinitrc

```
## 安装ly显示管理器

项目主页：https://github.com/nullgemm/ly

### 克隆&编译Ly
克隆Ly存储库
```shell
$ git clone --recurse-submodules https://github.com/nullgemm/ly.git
```

编译Ly
```shell
$ make
```

测试运行 默认运行在tty2
```shell
# make run
```

安装Ly
```shell
# make install
```

开机启动
```shell
# systemctl enable ly.service
```

如果您需要在 Ly 启动后在 tty 之间切换，您还必须在 Ly 的 tty 上禁用 getty 以防止“登录”在其上产生
```shell
# systemctl disable getty@tty2.service
```

## 重启设备

```shell
$ reboot
```

--------



