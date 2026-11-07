#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

echo "🛠️ Starting System Provisioning..."

# 1. DEFINE PATHS
# Resolve the repo location from the script itself, so it works no matter
# where the repo was cloned (~/GitHub, ~/Projects, ...).
DOTFILES="${0:A:h}"

# Helper: symlink $1 -> $2. If $2 is a real file/dir (not a symlink),
# move it aside as a timestamped backup instead of destroying it.
link() {
    local src="$1" dest="$2"
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        local backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
        echo "📦 Backing up existing $dest -> $backup"
        mv "$dest" "$backup"
    fi
    ln -sfn "$src" "$dest"
}

# 2. INSTALL HOMEBREW (If not installed)
# The brew shellenv line lives in the repo's .zprofile (linked below),
# so we only need to activate it for this session.
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. PREPARE ~/.zsh
# ~/.zsh must be a REAL directory: it holds machine-local data
# (completions/, .zcompdump) that should not land inside the git repo.
# The tracked module files are symlinked into it individually.

# Clean up leftovers from the old (buggy) install:
#  - ~/.zsh as a symlink to the repo's .zsh directory
#  - a stray ~/.zsh/.zsh link created by `ln -sfn` into an existing directory
if [[ -L "$HOME/.zsh" ]]; then
    rm "$HOME/.zsh"
fi
if [[ -L "$HOME/.zsh/.zsh" ]]; then
    rm "$HOME/.zsh/.zsh"
fi

mkdir -p "$HOME/.zsh/completions"

# 4. SYMLINK DOTFILES
echo "🔗 Symlinking dotfiles..."
link "$DOTFILES/.zshrc"   "$HOME/.zshrc"
link "$DOTFILES/.zprofile" "$HOME/.zprofile"

# Link every module (env.zsh, tools.zsh, aliases.zsh, functions.zsh, ...)
for f in "$DOTFILES"/.zsh/*.zsh(N); do
    link "$f" "$HOME/.zsh/${f:t}"
done

# Create mise directory first, then symlink cleanly
mkdir -p "$HOME/.config/mise"
link "$DOTFILES/.mise.toml" "$HOME/.config/mise/config.toml"

# Sanity check: fail loudly if the modules did not end up where .zshrc expects them
for m in env tools aliases functions; do
    if [[ ! -f "$HOME/.zsh/$m.zsh" ]]; then
        echo "❌ Missing $HOME/.zsh/$m.zsh after linking. Aborting." >&2
        exit 1
    fi
done

# 5. SYNC BREW PACKAGES
echo "📦 Installing tools from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"
brew autoremove

# Grant Wireshark access to packet capture interfaces (bpf)
if dscl . -read /Groups/access_bpf &>/dev/null; then
    echo "🔐 Adding $USER to access_bpf group for Wireshark..."
    sudo dscl . -append /Groups/access_bpf GroupMembership "$USER"
fi

# 6. INITIALIZE MISE & RUNTIMES
if command -v mise &> /dev/null; then
    echo "🚀 Initializing Mise Runtimes..."
    # Trust using full path expansion
    mise trust "$HOME/.config/mise/config.toml"
    # Install all versions defined in .mise.toml
    mise install
fi

echo "✅ Environment Bootstrapped Successfully!"
echo "🔄 Reloading current shell to activate all tools/functions..."

# This replaces the script process with a fresh Zsh shell
# which will source your ~/.zshrc and activate all aliases/tools/functions.
exec zsh
