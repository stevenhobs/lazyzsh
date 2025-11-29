#!/bin/zsh
[[ -o interactive ]] || return

# Options
ZSH_PLUGIN_syntax_highlighting=ON
ZSH_PLUGIN_autosuggestions=ON
ZSH_PLUGIN_powerlevel10k=ON

# LazyZSH Config
LAZY_ZSH="$HOME/.lazyzsh"

# Plugins
[[ ! -d "$LAZY_ZSH/plugins" ]] && . "$LAZY_ZSH/init_plugins.zsh"
[ "$ZSH_PLUGIN_syntax_highlighting" = ON ] && source "$LAZY_ZSH/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh"
[ "$ZSH_PLUGIN_autosuggestions" = ON ] && source "$LAZY_ZSH/plugins/autosuggestions/zsh-autosuggestions.zsh"
[ "$ZSH_PLUGIN_powerlevel10k" = ON ] && {
    source "$LAZY_ZSH/plugins/powerlevel10k/powerlevel10k.zsh-theme"
    source "$LAZY_ZSH/p10k_theme.zsh"
}

# Binaries
[[ -d "$LAZY_ZSH/bin" ]] && ! echo ":$PATH:" | grep -q "lazyzsh/bin" && {
    PATH="$LAZY_ZSH/bin:$PATH"
    source $LAZY_ZSH/bin/.lazy_bin_init.zsh
}

# ~/.zsh_history
setopt histignorealldups sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$HOME/.zsh_history"

# alias wsl2
source "$LAZY_ZSH/alias.zsh"                             # inner custom alias
[[ -n $WSL_DISTRO_NAME ]] && source "$LAZY_ZSH/wsl2.zsh" # wsl custom

# Proxy Switcher
function setproxy() {
    local host=${1:-127.0.0.1} # 更改IP为您的代理软件监听IP, 默认127.0.0.1
    local port=${2:-7890}      # 更改端口为您的代理软件监听端口, 默认7890
    export http_proxy=http://$host:$port && export https_proxy=$http_proxy
    export no_proxy=localhost,127.0.0.1,::1,.localdomain
    echo "- You've set the network proxy! Info: $http_proxy"
}
function unsetproxy() {
    unset http_proxy && unset https_proxy && unset no_proxy
    echo "- You've unset the network proxy!"
}
