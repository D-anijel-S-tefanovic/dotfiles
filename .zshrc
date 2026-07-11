# ==============================================================================
# MAIN CORE .ZSHRC PROFILE (HIGH PERFORMANCE)
# ==============================================================================

# 1. CORE SHELL OPTIONS
setopt EXTENDED_HISTORY       # Save timestamps in your history file
setopt SHARE_HISTORY          # Share command history instantly across all windows
setopt HIST_EXPIRE_DUPS_FIRST # Purge old duplicate logs first when history fills up
setopt HIST_IGNORE_DUPS       # Do not record consecutive duplicate entries
setopt HIST_IGNORE_SPACE      # Skip logging commands that start with a space
setopt NO_BG_NICE             # Do not throttle background tasks down to low-priority
setopt NO_CHECK_JOBS          # Do not warn about running background jobs when closing window

# 2. TAB-COMPLETION ENGINE CONFIGURATION
# ~/.zsh/completions: Drop-zone for manual/custom CLI tool completion definition scripts.
# ~/.zsh/.zcompdump  : Automated index/cache file of all CLI flags to speed up shell startup.
# To force-rebuild broken/missing tab completions, run: rm -f ~/.zsh/.zcompdump* && reload

fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit -d ~/.zsh/.zcompdump

# Zsh styling for tab selection menus
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# 3. EXPLICIT SEQUENTIAL MODULE LOADING
ZSH_CONFIG_DIR="$HOME/.zsh"

[[ -f "$ZSH_CONFIG_DIR/env.zsh" ]]       && source "$ZSH_CONFIG_DIR/env.zsh"
[[ -f "$ZSH_CONFIG_DIR/tools.zsh" ]]     && source "$ZSH_CONFIG_DIR/tools.zsh"
[[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ]]   && source "$ZSH_CONFIG_DIR/aliases.zsh"
[[ -f "$ZSH_CONFIG_DIR/functions.zsh" ]] && source "$ZSH_CONFIG_DIR/functions.zsh"

unset ZSH_CONFIG_DIR
