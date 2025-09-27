# dotfiles

Used for storing configuration files on the workstation. These directories/files are written back to git to have settings persist over a re-install of the workstation. This configuration in managed in Nix

## requirements

`xcode`
```bash
xcode-select --install
```

`determinate systems: nix`
```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

`nix-darwin`
```bash
nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch
```
