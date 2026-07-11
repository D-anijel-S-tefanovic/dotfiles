# ==============================================================================
# SHORTCUT ALIAS MATRIX (~/.zsh/aliases.zsh)
# ==============================================================================

# 1. WORKSPACE & ENVIRONMENT MANAGEMENT
alias zshconfig="pycharm ~/Projects/dotfiles" # Direct link to your Git repository folder
alias reload="source ~/.zshrc && echo '⚡️ Zsh configuration reloaded successfully.'"

# 2. MODERN SYSTEM REPLACEMENTS
# Enhanced file tree layouts using eza and syntax-highlighted printing via bat
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first"
alias cat="bat"

# 3. CONTAINER VIRTUALIZATION ENGINE (NATIVE ARM64 VZ LAYERS)
# Balanced performance configuration without emulation overhead
alias dstart="colima start --cpu 4 --memory 8 --disk 60 --vm-type vz --mount-type virtiofs --arch arm64"
alias dstop="colima stop"
alias dstat="colima status"
alias dclean="docker system prune -af --volumes"

# 4. RUNTIME DEVELOPMENT ENGINE (MISE CHANNELS)
alias m="mise"
alias mg="mise use --global"

# 5. CORE SYSTEM MAINTENANCE PIPELINE
# Updates packet streams, prunes broken targets, and upgrades language runtimes
alias upgrade-all="brew update && brew upgrade && brew cleanup -s && mise upgrade"