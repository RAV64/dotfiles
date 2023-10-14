if status is-interactive
  set TERM "xterm-256color"

  fzf_configure_bindings --directory=\cf
  export EDITOR="nvim"
  export VISUAL="nvim"

  set fzf_fd_opts --ignore-file $HOME/dotfiles/zsh/.fdignore -a -H
  set fzf_preview_dir_cmd exa -lag --icons
  set DOTNET_CLI_TELEMETRY_OPTOUT true
  set ZELLIJ_AUTO_ATTACH true
  set ZELLIJ_AUTO_EXIT true

  source $HOME/dotfiles/work/work.fish

  alias la "eza -lag --icons"
  alias lt "eza -lg --icons --tree --level=3"
  alias g "lazygit"
  alias v "nvim"

  alias cr "cargo run"
  alias ct "cargo test"
  alias cw "cargo watch -x"

  set PATH $PATH ~/.dotnet/tools
  set PATH $PATH ~/.cargo/bin
  set PATH $PATH ~/Developer/flutter/bin
  set PATH $PATH ~/dotfiles/scripts/path
  set PATH $PATH ~/.local/bin

  if test (uname) = "Darwin"
    launchctl remove com.valvesoftware.steam.ipctool
    launchctl remove (launchctl list | awk -F" " '{print $3}' | grep com.microsoft.autoupdate) &> /dev/null
  end

  starship init fish | source
  zoxide init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
