#!/usr/bin/env bash
set -e

OS="$(uname -s)"

echo "==> Update script starting..."

if [[ "$OS" == "Linux" ]]; then
  echo "==> Updating Linux packages..."
  sudo apt update
  sudo apt upgrade -y
fi

echo "==> Updating Homebrew..."
brew update

echo "==> Upgrading Homebrew packages..."
brew upgrade

echo "==> Cleanup Homebrew..."
brew cleanup

if command -v pnpm &> /dev/null; then
  echo "==> Updating pnpm..."
  pnpm self-update
fi

if command -v rustup &> /dev/null; then
  echo "==> Updating rustup..."
  rustup self update
fi

echo "==> Update script completed!"