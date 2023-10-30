COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX=true
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export YABAI_CERT=yabai-cert
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export SECRETS_PINENTRY=ask
export BETTER_EXCEPTIONS=1
export JAVA_HOME=$(/usr/libexec/java_home)
export JDTLS_HOME="/opt/homebrew/bin/jdtls"
export LDFLAGS="-L/opt/homebrew/opt/python@3.10/lib"
export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.10/lib/pkgconfig"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export NVM_LAZY=1
export BAT_THEME="Catppuccin-mocha"
export EDITOR="nvim"
export HISTCONTROL=erasedups

export PATH="bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/Library/Apple/usr/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/flutter/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:/Users/miki/.dotnet/tools"

bindkey -s '^f' 'cd $(fd --type directory --ignore-file $HOME/dotfiles/zsh/.fdignore --base-directory $HOME/ -a -H | fzf)^M'


alias lghub="/Applications/lghub.app/Contents/Frameworks/lghub_updater.app/Contents/MacOS/lghub_updater"
alias ll="exa -l -g --icons"
alias la="ll -a"
alias lt="ll --tree --level=2"
alias lta="lt -a"
alias ..="cd .."
alias v="nvim"
alias vi="nvim"
alias python="python3"
alias :q="exit"
alias zshconf="v $HOME/dotfiles/zsh/.zshrc"
alias nvimconf="v $HOME/dotfiles/nvim/"

alias restart="brew services restart"
alias start="brew services start"
alias stop="brew services stop"
alias bu="brew upgrade"
alias bi="brew info "
alias bl="brew list"

alias ga="git add"
alias gc="git commit -m"
alias gp="git push"

alias bnpm="/opt/homebrew/bin/npm"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
