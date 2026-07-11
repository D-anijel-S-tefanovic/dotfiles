# ==============================================================================
# ENVIRONMENT & PATH CONFIGURATION (~/.zsh/env.zsh)
# ==============================================================================

# 1. INITIALIZE HOMEBREW ARCHITECTURE
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. BULLETPROOF PATH MATRIX
# Force the path array to automatically drop duplicate entries
typeset -U path PATH

# Prepend custom binary directories cleanly in lookup priority order
path=(
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    $path
)

# 3. GLOBAL DEVELOPER DEFAULTS
export EDITOR='nano'
export VISUAL='nano'

# Opt out of tracking metrics for modern CLI packages
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1