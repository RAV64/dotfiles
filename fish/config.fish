if status is-interactive
  fzf_configure_bindings --directory=\cf
  export EDITOR="nvim"
  export VISUAL="nvim"
  set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

  set fzf_fd_opts --ignore-file $HOME/dotfiles/zsh/.fdignore -a -H
  set fzf_preview_dir_cmd exa -lag --icons
  set DOTNET_CLI_TELEMETRY_OPTOUT true

  alias la "exa -lag --icons"
  alias lt "exa -lag --icons --tree --level=3"
  alias v "nvim"
  alias s "kitty +kitten ssh"

  set PATH $PATH ~/.cargo/bin
  set PATH $PATH ~/.dotnet/tools
end

launchctl remove com.valvesoftware.steam.ipctool

starship init fish | source
zoxide init fish | source
