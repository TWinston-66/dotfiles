#!/usr/bin/env bash

set -euo pipefail

#### NSGlobal ###
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

### FINDER ###
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

### SCREENSHOTS ###
mkdir -p "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"

killall Finder >/dev/null 2>&1 || true
killall Dock >/dev/null 2>&1 || true
