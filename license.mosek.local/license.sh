#!/bin/bash

# 检查MOSEKLM_LICENSE_FILE是否存在
if [ -n "$MOSEKLM_LICENSE_FILE" ]; then
    echo "当前MOSEK许可证路径: $MOSEKLM_LICENSE_FILE"
else
    # 提示用户输入路径
    DEFAULT_PATH="/workspaces/symdpoly-python/license.mosek.local/mosek.lic"
    echo "未找到MOSEK许可证文件！"
    read -p "请输入许可证路径（默认：$DEFAULT_PATH）: " USER_PATH

    # 处理输入（空值则用默认路径）
    LICENSE_PATH="${USER_PATH:-$DEFAULT_PATH}"

    # 验证路径是否存在
    if [ -f "$LICENSE_PATH" ]; then
        export MOSEKLM_LICENSE_FILE="$LICENSE_PATH"
        echo "已临时设置 MOSEKLM_LICENSE_FILE=$LICENSE_PATH"

        # 询问是否永久保存配置
        read -p "是否将此路径永久添加到shell配置文件？(y/n) " SAVE_CHOICE
        if [[ $SAVE_CHOICE =~ ^[Yy]$ ]]; then
            CURRENT_SHELL=$(basename "$SHELL")
            CONFIG_FILE="$HOME/.${CURRENT_SHELL}rc"
            # CONFIG_FILE="$HOME/.bashrc"  # 默认使用bash，可根据需要调整
            cp "$CONFIG_FILE" "${CONFIG_FILE}.mosekLicense.bak"  # 修改前备份
            if grep -q "MOSEKLM_LICENSE_FILE" "$CONFIG_FILE"; then
                echo "警告：配置文件中已存在MOSEK许可证设置，请手动检查 '$CONFIG_FILE'。"
            else
                echo "export MOSEKLM_LICENSE_FILE=\"$LICENSE_PATH\"" >> "$CONFIG_FILE"
                echo "已永久添加到 $CONFIG_FILE，请重新登录或运行"
                echo "      source $CONFIG_FILE "
                echo "生效。"
            fi
        fi
    else
        echo "错误：文件 $LICENSE_PATH 不存在！" >&2
        exit 1
    fi
fi