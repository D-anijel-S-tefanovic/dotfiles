# ==============================================================================
# INTERACTIVE TOOL INITIALIZATIONS (~/.zsh/tools.zsh)
# ==============================================================================

# 1. MISE ENGINE ACTIVATION
# Manages active toolchain runtimes (Node, Python, Java, etc.)
if [[ -x /opt/homebrew/bin/mise ]]; then
    eval "$(/opt/homebrew/bin/mise activate zsh)"
fi

# 2. ZOXIDE DIRECTORY INITIALIZATION
# High-speed directory hopping replacing standard 'cd'
if [[ -x /opt/homebrew/bin/zoxide ]]; then
    eval "$(/opt/homebrew/bin/zoxide init zsh --cmd cd)"
fi

# 3. FZF FUZZY FINDER INTEGRATION
# Instant command-line search and fuzzy history indexing
if [[ -x /opt/homebrew/bin/fzf ]]; then
    eval "$(/opt/homebrew/bin/fzf --zsh)"
fi