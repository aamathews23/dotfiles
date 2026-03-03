#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/YOUR_USERNAME/dotfiles.git"
TARGET_DIR="$HOME/.dotfiles"

echo "==> Bootstrap script starting..."

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