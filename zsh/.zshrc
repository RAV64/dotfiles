if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

COMPLETION_WAITING_DOTS="true"

ZSH_DISABLE_COMPFIX=true
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export SECRETS_PINENTRY=ask
export BETTER_EXCEPTIONS=1
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/Applications/Little Snitch.app/Contents/Components:/Library/Apple/usr/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/code/flutter/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
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

bindkey -s '^f' 'cd $(fd --type directory --ignore-file $HOME/.dotfiles/zsh/.fdignore --base-directory $HOME/ -a -H | fzf)^M'

plugins=(git
zsh-syntax-highlighting
fzf-tab
)

export ZSH="$HOME/.dotfiles/zsh/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

[[ ! -f $HOME/.dotfiles/zsh/.themes/.p10k.zsh ]] || source ~/.dotfiles/zsh/.themes/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
