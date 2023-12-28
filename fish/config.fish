if not status is-interactive
    return 0
end

set -gx TERM "xterm-256color"
source $HOME/dotfiles/fish/themes/mocha.theme

set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_PREVIEW_DIR_CMD "eza -lag --icons"
fzf_configure_bindings --directory=\cf

set -g BAT_THEME "Catppuccin-mocha"

set -g DOTNET_CLI_TELEMETRY_OPTOUT true
set -g ZELLIJ_AUTO_ATTACH true
set -g ZELLIJ_AUTO_EXIT true

set -gx EDITOR nvim
set -gx VISUAL nvim

source $HOME/dotfiles/work/work.fish

alias v "nvim"

alias la "eza -lag --icons"
alias lt "eza -lg --icons --tree --level=3"

alias cr "cargo run"
alias ct "cargo test"
alias cw "cargo watch -x"

alias watch "watchexec"

alias g "lazygit"
alias ga "git add"
alias gc "git commit -a"
alias gd "git diff HEAD"

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH $PATH ~/.dotnet/tools
set -gx PATH $PATH ~/.cargo/bin
set -gx PATH $PATH ~/dotfiles/scripts/bin/nvim-macos/bin

if test (uname) = "Darwin"
    launchctl remove com.valvesoftware.steam.ipctool
    launchctl remove (launchctl list | awk -F" " '{print $3}' | grep com.microsoft.autoupdate) &> /dev/null
end

starship init fish | source
zoxide init fish | source

set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH
