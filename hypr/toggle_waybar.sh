#!/bin/bash

# 获取 Waybar 的窗口 ID
waybar_id=$(hyprctl clients | grep Waybar | awk '{print $1}')

# 检查是否获取到 Waybar 的窗口 ID
if [ -z "$waybar_id" ]; then
    echo "Waybar window not found."
    exit 1
fi

# 获取当前 Waybar 是否可见
waybar_visible=$(hyprctl clients | grep "$waybar_id" | grep -o 'visible')

if [ "$waybar_visible" = "visible" ]; then
    # 如果 Waybar 可见，则隐藏它
    hyprctl dispatch hide "$waybar_id"
else
    # 如果 Waybar 隐藏，则显示它
    hyprctl dispatch show "$waybar_id"
fi

