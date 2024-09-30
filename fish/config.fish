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

set -gx PATH $PATH /opt/homebrew/bin
set -gx PATH $PATH /opt/homebrew/sbin
set -gx PATH $PATH /run/current-system/sw/bin
set -gx PATH $PATH ~/.dotnet/tools
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH ~/.local/share/bob/nvim-bin
set -gx PATH $PATH ~/dotfiles/scripts/bin
set -gx PATH $PATH $BUN_INSTALL/bin

if test (uname) = Darwin
    launchctl remove com.valvesoftware.steam.ipctool
    launchctl remove (launchctl list | awk -F" " '{print $3}' | grep com.microsoft.autoupdate) &>/dev/null
end

zoxide init fish | source
starship init fish | source

fzf --fish | source
fzf_configure_bindings --directory=\cf
