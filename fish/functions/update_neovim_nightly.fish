function update_neovim_nightly
   # Step 1: Download the file
   curl -L -o ~/Downloads/nvim-macos.tar.gz https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz

   # Step 2: Change attributes to avoid "unknown developer" warning
   xattr -c ~/Downloads/nvim-macos.tar.gz

   # Step 3: Extract the file
   tar xzvf ~/Downloads/nvim-macos.tar.gz -C ~/dotfiles/scripts/bin

end
