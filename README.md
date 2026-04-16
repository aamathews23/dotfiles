# dotfiles

This repo installs my dev environment. It includes VS Code and Extensions, various CLI tools, and Homebrew for both MacOS and Linux.

## install

My dotfiles can be installed on WSL, Linux, or MacOS.

### WSL / Linux

The two supported Linux distros are Debian and Ubuntu.

1. Update `apt`.
```bash
sudo apt update
```
2. Install `curl`.
```bash
sudo apt install -y curl
```
3. Run the bootstrap script.
```bash
sudo curl -fsSL https://raw.githubusercontent.com/aamathews23/dotfiles/main/bootstrap.sh | bash
```

### MacOS

WIP

## update

1. Run the update script.
```bash
sudo curl -fsSL https://raw.githubusercontent.com/aamathews23/dotfiles/main/update.sh | bash
```
2. Check the [nvm release page](https://github.com/nvm-sh/nvm/releases) for a new version and run their install script.
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh | bash
```