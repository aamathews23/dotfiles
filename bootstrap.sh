#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/aamathews23/dotfiles.git"
CODE_DIR="$HOME/code"
TARGET_DIR="$HOME/code/dotfiles"
OS="$(uname -s)"

echo "==> Bootstrap script starting..."

#######################################
# Linux Prerequisites
#######################################

if [[ "$OS" == "Linux" ]]; then
  echo "==> Installing Linux prerequisites..."
  sudo apt update
  sudo apt install -y curl git build-essential procps file
fi

#######################################
# Install Homebrew
#######################################

if ! command -v brew &> /dev/null; then
  echo "==> Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /home/linuxbrew/.linuxbrew/bin/brew shellenv 2>/dev/null || true)"

#######################################
# Install Git
#######################################

if ! command -v git &> /dev/null; then
  echo "==> Installing git..."
  brew install git
fi

#######################################
# Clone dotfiles repository
#######################################

if [ ! -d "$CODE_DIR" ]; then
  echo "==> Creating code directory..."
  mkdir -p "$CODE_DIR"
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "==> Cloning dotfiles repository..."
  git clone "$REPO_URL" "$TARGET_DIR"
else
  echo "==> Dotfiles repo already exists at $TARGET_DIR"
fi

#######################################
# Run install script
#######################################

echo "==> Running main install script..."
cd "$TARGET_DIR"
bash install.sh

echo "✅ Bootstrap complete!"