# My .files :)

![image](https://github.com/user-attachments/assets/92cdf7e5-3a09-4480-b678-1e276a1205c3)

## Nix

### Install

https://nix.dev/install-nix.html

``` fish
curl -L https://nixos.org/nix/install | sh
```

### nix-darwin

https://github.com/LnL7/nix-darwin

``` fish
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake ~/dotfiles/nix-config#mac
```

### Update

``` fish
darwin-rebuild switch --flake ~/dotfiles/nix-config#mac
```
