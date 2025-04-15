if not status is-interactive
    return 0
end

set -gx TERM xterm-256color
source $HOME/dotfiles/fish/themes/neocraft.theme

set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_PREVIEW_DIR_CMD "eza -lag --icons"
set -g DOCKER_CLI_HINTS false

set -g DOTNET_CLI_TELEMETRY_OPTOUT true
set -g ZELLIJ_AUTO_ATTACH true
set -g ZELLIJ_AUTO_EXIT true

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx BUN_INSTALL "$HOME/.bun"

if test -d $HOME/dotfiles/work/work.fish
    source $HOME/dotfiles/work/work.fish
end

alias v nvim
alias g lazygit

alias la "eza -lag --icons"
alias lt "eza -lg --icons --tree --level=3"

alias cr "cargo run"
alias ct "cargo nextest run --no-fail-fast"
alias cw "cargo watch -x"

alias ga "git add"
alias gc "git commit -m"
alias gst "git status"
alias gac "git add . && git commit -m"
alias gd "git diff HEAD"
alias gl "git log --oneline --graph --decorate"

# git stash && git pull && git stash pop
alias gspp "git pull --rebase --autostash" 

set -gx PATH $BUN_INSTALL/bin $PATH
set -gx PATH ~/dotfiles/scripts/bin $PATH
set -gx PATH ~/.local/share/bob/nvim-bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH /run/current-system/sw/bin $PATH

if test (uname) = Darwin
    set -gx PATH /opt/homebrew/sbin $PATH
    set -gx PATH /opt/homebrew/bin $PATH
    launchctl remove com.valvesoftware.steam.ipctool
    ps aux | grep -i 'siri' | grep -v 'grep' | awk '{print $2}' | xargs -r kill -9
end

zoxide init fish | source
starship init fish | source

fzf --fish | source
bind \cf fzf-file-widget
