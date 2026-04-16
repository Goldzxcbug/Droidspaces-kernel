#!/usr/bin/env bash

byd="Arch" #这个写你的容器名称


if ! su -c "id -u" 2>/dev/null | grep -q "^0$"; then
    echo "❌ 需要 root 权限才能运行此脚本，请确保设备已 root 并授予 Termux root 权限。"
    exit 1
fi

# 检测依赖 
required_commands=("pulseaudio" "pacmd" "pactl" "termux-x11" "sshpass" "ssh" "grep" "awk" "sleep" "id")
missing=()
for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        missing+=("$cmd")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    echo "❌ 缺少以下依赖，请安装后重试："
    printf "   %s\n" "${missing[@]}"
    exit 1
fi


if pgrep -x "pulseaudio" > /dev/null; then
    echo "ℹ️ PulseAudio 已经在运行，跳过启动。"
else
    echo "🚀 正在启动 PulseAudio..."
    pulseaudio -k 2>/dev/null
    sleep 0.2
    pulseaudio --start --exit-idle-time=-1 --disallow-exit
    sleep 0.2
    pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
    pacmd load-module module-aaudio-sink
    sleep 0.3
fi

AAUDIO_SINK=$(pactl list sinks short | grep "aaudio" | awk '{print $2}')
if [ -n "$AAUDIO_SINK" ]; then
    pactl set-default-sink "$AAUDIO_SINK"
    echo "✅ 默认音频设备设置为: $AAUDIO_SINK"
else
    echo "⚠️ 未找到 AAudio 设备，请检查模块是否加载成功"
fi

if ps -ef | grep -v grep | grep -q "com.termux.x11.Loader :1"; then
    echo "ℹ️ termux-x11 (:1) 已经在运行，跳过启动。"
else
    echo "🖥️ 正在启动 termux-x11..."
    termux-x11 :1 -dpi 315 &
    sleep 1
fi


if su -c /data/local/Droidspaces/bin/droidspaces --name="$byd" status | grep -q "Running"; then
    echo "容器 $byd 正在运行，执行相关命令..."
    sshpass -p '1234' ssh -o StrictHostKeyChecking=no Gold@127.0.0.1 "export DISPLAY=:1; startplasma-x11" &
    echo "✅ 桌面已经开启，快去看看吧"
else
    echo "该容器没开机，请检查是否开机"
fi
