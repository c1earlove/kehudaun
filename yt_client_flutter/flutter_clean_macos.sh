#!/bin/bash
# Flutter macOS 项目 CocoaPods 一键清理脚本
# 解决 macOS 端 Pod 依赖冲突、版本不一致、编译报错等问题

# 脚本颜色提示
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 恢复默认颜色

# 日志函数
log_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE} $1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# 检查命令是否存在
check_command() {
    if ! command -v $1 &> /dev/null; then
        log_error "未找到 $1 命令，请先安装"
        exit 1
    fi
}

# 安全删除函数
safe_remove() {
    if [ -e "$1" ] || [ -d "$1" ]; then
        log_info "正在删除: $1"
        rm -rf "$1"
        if [ $? -eq 0 ]; then
            log_success "删除成功: $1"
        else
            log_warning "删除失败或文件不存在: $1"
        fi
    else
        log_warning "文件不存在，跳过: $1"
    fi
}

# 确认函数
confirm_operation() {
    echo -e "${YELLOW}⚠️  注意：此操作将清理 Pod 缓存，可能需要重新下载依赖${NC}"
    read -p "是否继续? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "用户取消操作"
        exit 0
    fi
}

# 主函数
main() {
    log_step "Flutter macOS Pod 清理脚本启动"
    log_info "当前时间: $(date)"
    log_info "当前用户: $(whoami)"
    log_info "工作目录: $(pwd)"
    
    # 检查必要命令
    check_command "flutter"
    check_command "pod"
    
    # 用户确认
    confirm_operation
    
    # 1. 进入 macOS 项目目录
    log_step "步骤 1: 进入 Flutter 项目 macOS 目录"
    if [ ! -d "macos" ]; then
        log_error "未找到 macos 目录，请确保脚本在 Flutter 项目根目录执行！"
        log_info "当前目录内容:"
        ls -la
        exit 1
    fi
    
    cd macos
    log_success "已进入 macOS 目录: $(pwd)"
    
    # 2. 删除 macOS 项目内 Pod 相关缓存
    log_step "步骤 2: 清理 macOS 项目内 Pod 缓存"
    
    log_info "备份 Podfile.lock (如果存在)"
    if [ -f "Podfile.lock" ]; then
        cp Podfile.lock Podfile.lock.backup
        log_success "已备份 Podfile.lock"
    fi
    
    # 清理项目缓存
    safe_remove "Pods"
    safe_remove "Podfile.lock"
    safe_remove "Flutter/Flutter.podspec"
    safe_remove "build"
    
    # 清理 xcworkspace 文件
    log_info "清理 Xcode 工作空间文件"
    find . -name "*.xcworkspace" -type d -exec rm -rf {} + 2>/dev/null
    log_success "Xcode 工作空间已清理"
    
    # 3. 清理 CocoaPods 全局缓存（可选，询问用户）
    log_step "步骤 3: 清理 CocoaPods 缓存"
    
    echo -e "${YELLOW}是否清理 CocoaPods 全局缓存? (可能需要重新下载所有依赖)${NC}"
    read -p "清理全局缓存? (y/n): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "正在清理 CocoaPods 全局缓存..."
        
        # 清理缓存目录
        safe_remove "$HOME/.cocoapods/cache"
        safe_remove "$HOME/Library/Caches/CocoaPods"
        
        # 询问是否清理 repos
        echo -e "${YELLOW}是否清理 CocoaPods 本地仓库? (这将删除所有已下载的 Pod 仓库，重新下载会较慢)${NC}"
        read -p "清理本地仓库? (y/n): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            safe_remove "$HOME/.cocoapods/repos"
        else
            log_info "跳过清理本地仓库"
        fi
        
        log_success "CocoaPods 全局缓存清理完成"
    else
        log_info "跳过 CocoaPods 全局缓存清理"
    fi
    
    # 4. Flutter 全局缓存清理
    log_step "步骤 4: 执行 Flutter 清理"
    
    cd .. || {
        log_error "返回 Flutter 项目根目录失败！"
        exit 1
    }
    
    log_info "执行 flutter clean..."
    flutter clean
    
    if [ $? -eq 0 ]; then
        log_success "flutter clean 执行成功"
    else
        log_warning "flutter clean 执行可能有问题，继续执行..."
    fi
    
    log_info "执行 flutter pub get..."
    flutter pub get
    
    if [ $? -eq 0 ]; then
        log_success "flutter pub get 执行成功"
    else
        log_error "flutter pub get 执行失败"
        exit 1
    fi
    
    # 5. 重新安装 Pod 依赖
    log_step "步骤 5: 重新安装 Pod 依赖"
    
    cd macos || {
        log_error "再次进入 macos 目录失败！"
        exit 1
    }
    
    log_info "执行 pod install --repo-update..."
    echo -e "${YELLOW}此过程可能需要几分钟，请耐心等待...${NC}"
    
    # 执行 pod install 并显示进度
    pod install --repo-update
    
    if [ $? -eq 0 ]; then
        log_success "Pod 依赖安装成功"
    else
        log_error "Pod 依赖安装失败"
        log_info "尝试使用 --verbose 模式查看详细错误:"
        pod install --repo-update --verbose || true
        
        # 如果失败，尝试恢复备份
        if [ -f "Podfile.lock.backup" ]; then
            log_warning "尝试恢复 Podfile.lock 备份"
            cp Podfile.lock.backup Podfile.lock
        fi
        
        exit 1
    fi
    
    # 6. 清理完成
    log_step "步骤 6: 清理完成"
    
    # 删除备份文件
    safe_remove "Podfile.lock.backup"
    
    echo ""
    echo -e "${GREEN}🎉 ========================================${NC}"
    echo -e "${GREEN}🎉 Flutter macOS Pod 清理并重新安装完成！${NC}"
    echo -e "${GREEN}🎉 ========================================${NC}"
    echo ""
    log_info "建议执行以下操作:"
    log_info "1. 在 Xcode 中: Product → Clean Build Folder (⇧⌘K)"
    log_info "2. 重新构建项目: flutter build macos"
    log_info "3. 如果仍有问题，尝试重启 Xcode"
    
    exit 0
}

# 异常处理
trap 'log_error "脚本执行被中断"; exit 1' INT TERM

# 执行主函数
main "$@"