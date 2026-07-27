# 📱 界面使用说明
本网站都已最新版 Droidspaces 的稳定版为准
- 当前版本：v6.4.5
## [>_ ] On脚本-仅限x11
❤️提供四个启动脚本,每个脚本都具有打开rootfs的KDE桌面能力，使用脚本前请确保ssh可以连通,在Termux执行命令`bash on`即可
* **on_aaudio.sh** : 以`aaudio`加载音频,并通过127.0.0.1转发
* **on_aaudio_socket.sh** : 以`aaudio`加载音频,并通过本地转发
* **termux-依赖.sh** : Droidspaces 官方依赖脚本，适用于v6.3以上,自动x11转发与音频转发
> **💡 注意**: 默认先使用aaudio(音质更好),如果你要使用`socket`版,由于前期打包Rootfs,你需要更改/etc/zsh/zshenv把`export PULSE_SERVER=tcp:127.0.0.1:4713`改为`export PULSE_SERVER=unix:/tmp/.pulse-socket`

> **💡 注意**: 一定要点开脚本,将第二行的`arch`改成你的容器名字

**⚠️ 重要提示**: 如果你设备启动桌面时，遇到类似dri3报错,swap报错可以用
```bash
/data/adb/ksud sepolicy patch "allow untrusted_app_27 droidspacesd fd use"
#以kernelsu为例
```
但是这样只能解决一部分问题，有些设备的Vunlkan还是残血的
```bash
/data/adb/ksud sepolicy patch "permissive untrusted_app_27"
#这条命令可以解决所有问题,但是够危险,建议配合下面,查找untrusted_app_27域的app,再确认是否执行上面命令
/system/bin/dumpsys package packages | /system/bin/awk '/^ *Package \[/ {pkg=$2} /targetSdk=(26|27|28)$/ {print "App: " pkg " -> " $1}'
```

## 📁 OKI 文件夹
本文件夹内存放的均为支持 **Droidspaces** 的定制内核。
- NTsync 代表内核支持NTsync
- UserNS 代表内核打上CVE-2026-43499 补丁,拒绝漏洞提权
- UFW 内核开启UFW防火墙所需配置
> **⚠️ 重要提示**：请务必确保您的手机内核版本与本站提供的内核版本**完全一致**，以获得最佳兼容性。
> 
 * **6.12 版本**：
   * **已通过测试设备**：一加 15、一加 Ace 6T、一加15T、一加平板3Pro。
 * **6.6 版本**
   * **已通过测试设备**：一加平板 2 Pro、一加 13、一加 Ace 6、一加 Ace 5 Pro、一加 13T、一加 Ace 5 至尊版(使用天玑专用)、华硕rog9pro。
 * **6.1 版本**：
   * **已通过测试设备**：一加 Ace 3 Pro、一加 12、一加 Ace 5、一加平板 Pro、真我GT 5Pro。
 * **5.15 版本**：
   * **已通过测试设备**：一加 Ace 3。
* **5.10 版本**：
   * **已通过测试设备**：一加 Ace 竞速版。
## 🌐 GKI 文件夹
本文件夹存放支持 **Droidspaces** 的通用内核（GKI）。
> **💡 注意**：为了保障稳定性，请尽量选择与您当前内核**小版本号**一致的文件。
> 
 * **6.12 内核**：
   * **已通过测试设备**：红米 K90 Pro Max、小米 17 Pro Max、红魔 11 Pro、荣耀magicPad3Pro。
 * **6.6 内核**：
   * **已通过测试设备**：小米Pad8Pro、小米15
 * **6.1 内核**：
   * **已通过测试设备**：小米14、红魔9SPro+、 红魔9Pro、小米Pad7、小米 mix Flip
 * **5.15 内核**：
   * **已通过测试设备**：小米Pad6SPro、红米K70
 * **5.10 内核**：
   * **已通过测试设备**：小米平板 6 Max、小米平板 6 Pro、红米K60、红米K50Ultra
 * **4.14 内核**
   * **已通过测试设备**：红米Note 10 Pro
   
**⚠️ 重要提示**: 文件可能不全，找不到可以去[Gold_bug的alist](https://cdn.goldzxcbug.top/)

## 📖 具体使用教程
如果您是初学者或需要详细步骤，请参考 **酷安 @Gold_bug** 的深度教程：
 * [👤 查看作者主页](https://www.coolapk.com/u/33484640)
 * [🔗 Droidspaces 详细教学(有点过时)](https://www.coolapk.com/feed/70899541?s=NGIxYjhiNTExZmVlZjYwZzY5ZGEzZDBjega1612b2)
 * [👀 Droidspaces 项目](https://github.com/ravindu644/Droidspaces-OSS)
 * [🤓 Github 内核教程](https://github.com/Goldzxcbug/Droidspaces_Kernel_patch)
## 🤝 内核分享与贡献
如果您自行编译了支持 Droidspaces 的内核，欢迎通过 **酷安私信** 或 **邮件** 投递分享，您的每一份贡献都将帮助到更多用户！❤️❤️❤️

**📧 投稿要求：**
 1. **明确分类**：请注明是 GKI 内核、OKI 内核或兼容版。
 2. **版本信息**：
   * **OKI**：需注明完整的小版本号（如 5.15.180）。
   * **GKI**：需注明大版本号（如 5.15.???）。
 3. **设备列表**：请尽量列出已实际测试并通过的设备型号。
