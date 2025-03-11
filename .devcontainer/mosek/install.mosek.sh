#!/bin/bash
set -e  # 遇到错误自动退出

# 配置区（可根据需要修改）
DEFAULT_VERSION=${MOSEKVERSION:-"9.3.22"}
workspaces="/workspaces/symdpoly-python"
TARGET_ROOT="$workspaces/modules/mosek"
DEPENDENCIES_DIR="$workspaces/dependencies/mosek"

# 交互式输入版本
# read -p "请输入MOSEK版本号 [默认：$DEFAULT_VERSION]：" version
version=${version:-$DEFAULT_VERSION}

# 解析版本号
IFS='.' read -ra VER <<< "$version"
major="${VER[0]}"
minor="${VER[1]}"
build="${VER[2]}"
version_short="$major.$minor"

# 平台检测
detect_platform() {
  case $(uname -m) in
    x86_64)  echo "linux64x86" ;;
    aarch64) echo "linuxaarch64" ;;
    *)       echo "未知架构: $(uname -m)" >&2; exit 1 ;;
  esac
}
platform=$(detect_platform)

# 下载并解压
download_url="https://download.mosek.com/stable/$version/mosektools${platform}.tar.bz2"
echo "正在下载：$download_url"
wget -q --show-progress "$download_url" -O "mosek-${version}.tar.bz2"

echo "解压文件中..."
mkdir -p "$DEPENDENCIES_DIR"
tar -xjf "mosek-${version}.tar.bz2" -C "$DEPENDENCIES_DIR"

# 构建路径
source_jar="$DEPENDENCIES_DIR/mosek/$version_short/tools/platform/$platform/bin/mosek.jar"
target_dir="$TARGET_ROOT/lib"

# 验证文件存在性
[ -f "$source_jar" ] || { echo "错误：找不到JAR文件 $source_jar" >&2; exit 1; }

# 部署文件
echo "部署MOSEK库到：$target_dir"
mkdir -p "$target_dir" && cp "$source_jar" "$target_dir/"

# 清理临时文件
echo "清理安装包..."
rm "mosek-${version}.tar.bz2"

echo "安装完成！JAR路径：$target_dir/mosek.jar"