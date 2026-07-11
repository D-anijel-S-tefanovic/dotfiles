# ==============================================================================
# ADVANCED INTERACTIVE SHELL FUNCTIONS (~/.zsh/functions.zsh)
# ==============================================================================

# 1. DEEP MANUAL SYSTEM CLEANUP MAINTENANCE PIPELINE
# Run this once a month to aggressively prune development caches
sweep() {
    echo '🧹 Starting Deep System Sweep...'

    # --- BREW LAYER ---
    if [[ -x /opt/homebrew/bin/brew ]]; then
        echo '📦 Cleaning Homebrew caches...'
        # Run cleanup, but filter out the specific libssh2 warning
        /opt/homebrew/bin/brew cleanup --prune=all 2>&1 | grep -v "Warning: Skipping libssh2"
    fi

    # --- NODE.JS LAYER ---
    echo '🟢 Sweeping Node.js ecosystem caches...'
    if [[ -x /opt/homebrew/bin/pnpm ]]; then
        /opt/homebrew/bin/pnpm store prune
    fi
    if [[ -x /opt/homebrew/bin/npm ]]; then
        /opt/homebrew/bin/npm cache verify
    fi
    if [[ -d "$HOME/.bun/install/cache" ]]; then
        rm -rf "$HOME/.bun/install/cache"
    fi

    # --- PYTHON LAYER ---
    echo '🟡 Sweeping Python ecosystem caches...'
    if [[ -d "$HOME/Library/Caches/pip" ]]; then
        rm -rf "$HOME/Library/Caches/pip"
    fi
    if [[ -d "$HOME/Library/Caches/pypoetry" ]]; then
        rm -rf "$HOME/Library/Caches/pypoetry"
    fi

    # --- JAVA LAYER ---
    echo '🟤 Sweeping Java ecosystem caches...'
    if [[ -d "$HOME/.gradle/caches" ]]; then
        rm -rf "$HOME/.gradle/caches"
    fi
    if [[ -d "$HOME/.m2/repository" ]]; then
        rm -rf "$HOME/.m2/repository"
    fi

    echo '✅ System Sweep Complete!'
}

# 2. SYSTEM DIAGNOSTIC DASHBOARD
sysdiag() {
    echo "=== 1. MISE RUNTIMES ==="
    mise ls

    echo "\n=== 2. HOMEBREW FORMULAE & CASKS ==="
    brew list

    echo "\n=== 3. USER BINARY PATHS (~/.local/bin) ==="
    if [[ -d "$HOME/.local/bin" && "$(ls -A "$HOME/.local/bin" 2>/dev/null)" ]]; then
        ls -A "$HOME/.local/bin"
    else
        echo "Empty or missing"
    fi

    echo "\n=== 4. SYSTEM AND TOOL CACHE SIZES ==="
    # Use array for cleaner iteration
    local caches=("$HOME/Library/Caches/Homebrew" "$HOME/.cache/mise" "$HOME/.npm" "$HOME/.cache/pip" "$HOME/.gradle" "$HOME/.m2")
    for dir in "${caches[@]}"; do
        if [[ -d "$dir" ]]; then
            du -sh "$dir" 2>/dev/null
        else
            printf "0B\t%s (Missing)\n" "$dir"
        fi
    done

    echo "\n=== 5. APPLICATION SUPPORT METRICS (Top 10 Storage Consumers) ==="
    du -sh ~/Library/Application\ Support/* 2>/dev/null | sort -hr | head -n 10
}