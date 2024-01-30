# dotfiles

Used for storing configuration files on the workstation. These directories/files are written back to git to have settings persist over a re-install of the workstation.

```shell
git clone https://github.com/levivannoort/dotfiles ~/.dotfiles
```

```shell
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b .bin
```

```shell
./bin/task bootstrap
```