# This zsh is for the wsl distro
alias open="/mnt/c/Windows/explorer.exe"
alias notepad="/mnt/c/Windows/notepad.exe"

export NET_GATE="$(ip -c=never r | head -n1 | cut -d' ' -f3)"

# WSLG
if [[ -z $DISPLAY ]]; then
export DISPLAY="$NET_GATE:0.0"
export LIBGL_ALWAYS_INDIRECT=true
export LIBGL_ALWAYS_SOFTWARE=true
fi
