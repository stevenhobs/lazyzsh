#!/bin/zsh

# 当前脚本不支持 macOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo "[lazyzsh:x] install_cli.zsh does not support macOS."
    exit 1
fi

# 检测脚本依赖命令是否存在
required_cmds=(curl grep cut tar xz cp find rm mkdir)
missing_cmds=()
for cmd in "${required_cmds[@]}"; do
    command -v "$cmd" >/dev/null 2>&1 || missing_cmds+=("$cmd")
done

if [[ ${#missing_cmds[@]} -gt 0 ]]; then
    echo "[lazyzsh:x] missing required command(s): ${missing_cmds[*]}"
    exit 1
fi

# 1改为0或者注释掉行 -> 禁用安装
cli_7zip=1      # 7zip压缩 https://www.7-zip.org
cli_fastfetch=1 # 系统信息 https://github.com/fastfetch-cli/fastfetch
cli_zoxide=1    # 智能cd  https://github.com/ajeetdsouza/zoxide
cli_bottom=1    # 系统监测 https://github.com/ClementTsang/bottom
cli_fd=1        # 文件查找 https://github.com/sharkdp/fd

## 安装
LAZY_BIN=~/.lazyzsh/bin
LAZY_BIN_TMP=$LAZY_BIN/.tmp
LAZY_BIN_INIT=$LAZY_BIN/.lazy_bin_init.zsh
rm -rf $LAZY_BIN*
mkdir -p $LAZY_BIN_TMP
function gh_release() {
    gh_link=$(curl -s https://api.github.com/repos/$1/releases/latest | grep browser_download_url | cut -d'"' -f4 | grep -E $2)
    echo $gh_link
}

[[ $cli_7zip == 1 ]] && {
    echo "[lazyzsh:x] add cli-7zip"
    local CLI_7Z_DL_URL=https://www.7-zip.org/a/7z2600-linux-x64.tar.xz
    curl $CLI_7Z_DL_URL -o $LAZY_BIN_TMP/7z.tar.xz
    if [[ $? == 0 ]]; then
        tar -xf $LAZY_BIN_TMP/7z.tar.xz -C $LAZY_BIN_TMP
        cp $LAZY_BIN_TMP/7zz $LAZY_BIN
        echo 'alias 7z=7zz' >>$LAZY_BIN_INIT
    else
        echo "[lazyzsh:x] cli-7zip download fail!"
    fi
}

[[ $cli_fastfetch == 1 ]] && {
    echo "[lazyzsh:x] add cli-fastfetch"
    curl $(gh_release fastfetch-cli/fastfetch "fastfetch-linux-amd64.tar.gz") -Lo $LAZY_BIN_TMP/fastfetch.tar.gz
    if [[ $? == 0 ]]; then
        tar -zxf $LAZY_BIN_TMP/fastfetch.tar.gz -C $LAZY_BIN_TMP
        cp $LAZY_BIN_TMP/fastfetch-linux-amd64/usr/bin/fastfetch $LAZY_BIN
    else
        echo "[lazyzsh:x] cli-fastfetch download fail!"
    fi
}

[[ $cli_zoxide == 1 ]] && {
    echo "[lazyzsh:x] add cli-zoxide"
    curl $(gh_release ajeetdsouza/zoxide "x86_64-unknown-linux-musl.tar.gz$") -Lo $LAZY_BIN_TMP/zoxide.tar.gz
    if [[ $? == 0 ]]; then
        tar -zxf $LAZY_BIN_TMP/zoxide.tar.gz -C $LAZY_BIN_TMP
        cp $LAZY_BIN_TMP/zoxide $LAZY_BIN
        echo 'eval "$(zoxide init zsh)"' >>$LAZY_BIN_INIT
    else
        echo "[lazyzsh:x] cli-zoxide download fail!"
    fi
}

[[ $cli_bottom == 1 ]] && {
    echo "[lazyzsh:x] add cli-bottom"
    curl $(gh_release ClementTsang/bottom bottom_x86_64-unknown-linux-gnu.tar.gz) -Lo $LAZY_BIN_TMP/bottom.tar.gz
    if [[ $? == 0 ]]; then
        tar -zxf $LAZY_BIN_TMP/bottom.tar.gz -C $LAZY_BIN_TMP
        cp $LAZY_BIN_TMP/btm $LAZY_BIN
    else
        echo "[lazyzsh:x] cli-bottom download fail!"
    fi
}

[[ $cli_fd == 1 ]] && {
    echo "[lazyzsh:x] add cli-fd"
    curl $(gh_release sharkdp/fd x86_64-unknown-linux-gnu.tar.gz) -Lo $LAZY_BIN_TMP/fd.tar.gz
    if [[ $? == 0 ]]; then
        tar -zxf $LAZY_BIN_TMP/fd.tar.gz -C $LAZY_BIN_TMP
        cp $(find $LAZY_BIN_TMP -name fd) $LAZY_BIN
    else
        echo "[lazyzsh:x] cli-fd download fail!"
    fi
}

rm -r $LAZY_BIN_TMP

echo ""
echo "🚀 LazyZSH cli group has been over!"
