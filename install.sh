#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

echo "🛠️ Starting System Provisioning..."

# 1. DEFINE PATHS
DOTFILES="$HOME/GitHub/dotfiles"

# 2. INSTALL HOMEBREW (If not installed)
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH for the current session (for Apple Silicon)
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. CREATE DIRECTORY STRUCTURE
# Ensure the .zsh folder exists for completion caching
mkdir -p "$HOME/.zsh/completions"

# 4. SYMLINK DOTFILES
# Using -sfn to ensure we update links properly
echo "🔗 Symlinking dotfiles..."
ln -sfn "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES/.zsh" "$HOME/.zsh"
ln -sfn "$DOTFILES/mise.toml" "$HOME/.config/mise/config.toml" 2>/dev/null || mkdir -p "$HOME/.config/mise" && ln -sfn "$DOTFILES/mise.toml" "$HOME/.config/mise/config.toml"

# 5. SYNC BREW PACKAGES
echo "📦 Installing tools from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"
brew autoremove

# 6. INITIALIZE MISE & RUNTIMES
if command -v mise &> /dev/null; then
    echo "🚀 Initializing Mise Runtimes..."
    # Trust the global config file explicitly
    mise trust ~/.config/mise/config.toml
    # Install all versions defined in mise.toml
    mise install
fi

echo "✅ Environment Bootstrapped Successfully!"
echo "🔄 Reloading current shell to activate all tools/functions..."

# This replaces the script process with a fresh Zsh shell
# which will source your ~/.zshrc and activate all aliases/tools/functions.
exec zsh