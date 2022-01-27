if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$DOTFILES/zsh/.oh-my-zsh"
ZSH_DISABLE_COMPFIX=true
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export SECRETS_PINENTRY=ask
export BETTER_EXCEPTIONS=1

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"

plugins=(git
zsh-syntax-highlighting
fzf-tab
)


source $ZSH/oh-my-zsh.sh


export PATH="bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Little Snitch.app/Contents/Components:/Library/Apple/usr/bin:/$HOME/code/flutter/bin:/$HOME/.cargo/bin"

if [ "$(arch)" = "arm64" ]
then
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
    export PATH="/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:$PATH"

    export NVM_DIR="$HOME/.nvm"
    export PATH="/opt/homebrew/sbin:$PATH"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    alias lghub="/Applications/lghub.app/Contents/Frameworks/lghub_updater.app/Contents/MacOS/lghub_updater"

    alias ll="exa -l -g --icons"
    alias la="ll -a"
    alias lt="ll --tree --level=2"
    alias lta="lt -a"
    

    alias ..="cd .."
    alias v="nvim"
    alias vi="nvim"  
    alias vim="nvim" 
    export JAVA_HOME=$(/usr/libexec/java_home)
else
fi

bindkey -s '^f' 'cd $(fd --type directory --ignore-file $HOME/.fdignore --base-directory $HOME -a -H | fzf)^M'

LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"

[[ ! -f ~/.dotfiles/zsh/.themes/.p10k.zsh ]] || source ~/.dotfiles/zsh/.themes/.p10k.zsh
