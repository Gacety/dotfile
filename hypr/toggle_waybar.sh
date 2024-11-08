#!/bin/bash

# 打印所有窗口信息以便调试
echo "Fetching all window IDs..."
hyprctl clients

# 获取 Waybar 的窗口 ID（假设 Waybar 类为 org.wezfurlong.wezterm）
waybar_id=$(hyprctl clients | awk '/class: org.wezfurlong.wezterm/ {getline; print $2}')

# 打印获取到的窗口 ID
echo "Waybar ID: $waybar_id"

# 检查是否获取到 Waybar 的窗口 ID
if [ -z "$waybar_id" ]; then
    echo "Waybar window not found."
    exit 1
fi

# 获取当前 Waybar 是否可见
waybar_visible=$(hyprctl clients | awk -v id="$waybar_id" '$1 == id {getline; print $2}')

# 打印获取到的状态
echo "Waybar visibility: $waybar_visible"

if [ "$waybar_visible" = "0" ]; then
    # 如果 Waybar 隐藏，则显示它
    hyprctl dispatch show "$waybar_id"
else
    # 如果 Waybar 可见，则隐藏它
    hyprctl dispatch hide "$waybar_id"
fi

