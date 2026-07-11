# ==============================================================================
# ENVIRONMENT & PATH CONFIGURATION (~/.zsh/env.zsh)
# ==============================================================================

# 1. CUSTOM BINARIES
if [[ -d "$HOME/.local/bin" ]]; then
    path=("$HOME/.local/bin" $path)
fi

# 2. TOOL RUNTIMES
# Using 'mise activate zsh' dynamically manages your PATH for Java, Node, etc.
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# 3. BULLETPROOF PATH MATRIX
# Ensures no duplicates if you source your config multiple times
typeset -U path
export PATH

# 4. GLOBAL DEVELOPER DEFAULTS
export EDITOR='nano'
export VISUAL='nano'

# Opt out of tracking metrics for modern CLI packages
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1