if status is-interactive
  set -gx TERM "xterm-256color"
  source $HOME/dotfiles/fish/themes/mocha.theme

  set -g FZF_FD_OPTS --ignore-file $HOME/dotfiles/zsh/.fdignore -a -H
  set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
  set -g FZF_PREVIEW_DIR_CMD "eza -lag --icons"

  set -g DOTNET_CLI_TELEMETRY_OPTOUT true
  set -g ZELLIJ_AUTO_ATTACH true
  set -g ZELLIJ_AUTO_EXIT true

  fzf_configure_bindings --directory=\cf
  set -gx EDITOR nvim
  set -gx VISUAL nvim

  source $HOME/dotfiles/work/work.fish

  alias la "eza -lag --icons"
  alias lt "eza -lg --icons --tree --level=3"
  alias g "lazygit"
  alias v "nvim"

  alias cr "cargo run"
  alias ct "cargo test"
  alias cw "cargo watch -x"

  set -gx PATH $PATH /opt/homebrew/bin
  set -gx PATH $PATH ~/.dotnet/tools
  set -gx PATH $PATH ~/.cargo/bin
  set -gx PATH $PATH ~/Developer/flutter/bin
  set -gx PATH $PATH ~/dotfiles/scripts/bin
  set -gx PATH $PATH ~/.local/bin

  if test (uname) = "Darwin"
    launchctl remove com.valvesoftware.steam.ipctool
    launchctl remove (launchctl list | awk -F" " '{print $3}' | grep com.microsoft.autoupdate) &> /dev/null
  end

  starship init fish | source
  zoxide init fish | source
end

# bun
set -gx BUN_INSTALL "$HOME/.bun"
set -gx PATH $BUN_INSTALL/bin $PATH
