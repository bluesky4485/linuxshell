#!/bin/bash

###################
# 默认版本
###################
DEFAULT_GO_VERSION="1.22.10"
DEFAULT_NODE_VERSION="18"

###################
# 参数解析
###################
print_usage() {
    echo "用法: $0 [选项]"
    echo "选项:"
    echo "  --go     Go 版本 (默认: ${DEFAULT_GO_VERSION})"
    echo "  --node   Node.js 版本 (默认: ${DEFAULT_NODE_VERSION})"
    echo "  -h, --help   显示此帮助信息"
}

# 设置默认值
GO_VERSION="${DEFAULT_GO_VERSION}"
NODE_VERSION="${DEFAULT_NODE_VERSION}"

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        --go)
            GO_VERSION="$2"
            shift 2
            ;;
        --node)
            NODE_VERSION="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "错误: 未知参数 $1"
            print_usage
            exit 1
            ;;
    esac
done

# 显示将要使用的版本
log_message "将安装以下版本:"
log_message "Go 版本: ${GO_VERSION}"
log_message "Node.js 版本: ${NODE_VERSION}"

###################
# 工具函数
###################
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

setup_directories() {
    mkdir -p $HOME/.nvm
    mkdir -p $HOME/go
}

###################
# NVM 安装函数
###################
install_nvm() {
    log_message "开始安装 NVM..."
    
    # 使用 gitee 镜像安装 nvm
    bash -c "$(curl -fsSL https://gitee.com/RubyMetric/nvm-cn/raw/main/install.sh)"
    
    # 设置 NVM 环境变量
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # 验证安装
    if command -v nvm &> /dev/null; then
        log_message "NVM 安装成功"
        
        # 安装最新的 LTS 版本 Node.js
        log_message "正在安装 Node.js 18 版本..."
        nvm install $NODE_VERSION
        nvm use $NODE_VERSION
        
        log_message "正在设置npm镜像..."

        bash -c "$(curl -fsSL https://chsrc.run/posix)"
        chsrc set npm
        # 配置 npm 使用淘宝镜像
        #npm config set registry https://registry.npmmirror.com
        log_message "Node.js 安装完成，当前版本: $(node -v)"
        log_message "NPM 当前版本: $(npm -v)"
    else
        log_message "错误: NVM 安装失败"
        return 1
    fi
}

###################
# Go 安装函数
###################
install_go() {
    log_message "开始安装 Go..."
    
    # 设置 Go 版本
    GO_VERSION="1.22.10"  # 可以根据需要修改版本
    
    # 下载 Go（使用国内镜像）
    wget https://mirrors.aliyun.com/golang/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
    
    # 如果已存在则删除旧版本
    if [ -d "/usr/local/go" ]; then
        sudo rm -rf /usr/local/go
    fi
    
    # 解压安装
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    
    # 设置 Go 环境变量
    {
        echo 'export PATH=$PATH:/usr/local/go/bin'
        echo 'export GOPATH=$HOME/go'
        echo 'export GOPROXY=https://goproxy.cn,direct'
    } >> "$HOME/.bashrc"
    
    # 使环境变量生效
    # shellcheck source=/dev/null
    source "$HOME/.bashrc"
    
    # 验证安装
    if command -v go &> /dev/null; then
        log_message "Go 安装成功，版本: $(go version)"
    else
        log_message "错误: Go 安装失败"
        return 1
    fi
}

###################
# Docker 安装函数
###################
install_docker() {
    log_message "开始安装 Docker..."

    # 卸载旧版本
    sudo yum remove buildah podman containers-common || true
    sudo yum module reset -y container-tools
    sudo yum install -y yum-utils
    yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
    # 安装 Docker
    sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # 配置 Docker 镜像加速
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "insecure-registries": [
        "reg.net.dstyun.com:8380"
    ],
    "registry-mirrors": [
        "https://hub.tusky.eu.org"
    ]
}
EOF
    sudo systemctl daemon-reload
    sudo systemctl start docker
    sudo systemctl enable docker

    # 验证安装
    if command -v docker &> /dev/null; then
        log_message "Docker 安装成功，版本: $(docker --version)"
        log_message "请注意：需要重新登录终端才能使用非 root 用户运行 docker 命令"
    else
        log_message "错误: Docker 安装失败"
        return 1
    fi
}

###################
# 主函数
###################
main() {
    log_message "开始安装开发工具..."
    
    # 创建必要的目录
    setup_directories
    
    # 安装 NVM 和 Node.js
    install_nvm
    if [ $? -ne 0 ]; then
        log_message "NVM 安装过程中出现错误"
    fi
    
    # 安装 Go
    install_go
    if [ $? -ne 0 ]; then
        log_message "Go 安装过程中出现错误"
    fi
    
    # 安装 Docker
    install_docker
    if [ $? -ne 0 ]; then
        log_message "Docker 安装过程中出现错误"
    fi
    
    log_message "安装完成！"
    log_message "请运行 'source ~/.bashrc' 使环境变量生效"
}

# 执行主函数
main 
