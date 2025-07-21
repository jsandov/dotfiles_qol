# =============================================================================
# Advanced Zsh Configuration
# =============================================================================
# Optimized for performance, modern tools, and team sharing
# Compatible with macOS (Intel/Apple Silicon)
# =============================================================================

# =============================================================================
# INSTANT PROMPT & INITIALIZATION
# =============================================================================

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# ENVIRONMENT SETUP
# =============================================================================

# Homebrew initialization (Apple Silicon/Intel compatible)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# =============================================================================
# ZINIT PLUGIN MANAGER
# =============================================================================

# Set Zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Auto-install Zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Ensure required directories exist
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zinit/completions"

# =============================================================================
# PROMPT THEME
# =============================================================================

# Powerlevel10k prompt (with turbo mode)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# =============================================================================
# CORE PLUGINS (High Priority)
# =============================================================================

# Fast syntax highlighting (replaces zsh-syntax-highlighting)
zinit light zdharma-continuum/fast-syntax-highlighting

# Advanced autocompletion
zinit light zsh-users/zsh-completions

# Intelligent suggestions
zinit light zsh-users/zsh-autosuggestions

# Enhanced tab completion with fzf
zinit light Aloxaf/fzf-tab

# =============================================================================
# PRODUCTIVITY PLUGINS (Deferred Loading)
# =============================================================================

# Load these plugins after prompt to improve startup time
zinit wait lucid for \
    zdharma-continuum/history-search-multi-word \
    MichaelAquilina/zsh-you-should-use \
    hlissner/zsh-autopair \
    agkozak/zsh-z

# Advanced history search
zinit wait lucid light-mode for zsh-users/zsh-history-substring-search

# =============================================================================
# OH-MY-ZSH SNIPPETS (Deferred)
# =============================================================================

# Load useful OMZ plugins with wait
zinit wait lucid for \
    OMZL::git.zsh \
    OMZP::git \
    OMZP::sudo \
    OMZP::docker \
    OMZP::aws \
    OMZP::kubectl \
    OMZP::kubectx \
    OMZP::ansible \
    OMZP::golang \
    OMZP::rust \
    OMZP::python \
    OMZP::tmux \
    OMZP::fzf \
    OMZP::httpie \
    OMZP::command-not-found

# =============================================================================
# COMPLETION SYSTEM
# =============================================================================

# Load completions (only once)
autoload -Uz compinit

# Smart completion loading based on cache age
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Zinit completion replay
zinit cdreplay -q

# =============================================================================
# HISTORY CONFIGURATION
# =============================================================================

HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# History options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_verify
setopt inc_append_history

# =============================================================================
# ZSH OPTIONS
# =============================================================================

# General options
setopt auto_cd              # Auto cd when typing directory name
setopt auto_pushd           # Push directories to stack
setopt pushd_ignore_dups    # Don't push duplicates
setopt glob_dots            # Include dotfiles in globbing
setopt extended_glob        # Extended globbing
setopt no_beep              # No beeping
setopt correct              # Spell correction for commands
setopt interactive_comments # Allow comments in interactive mode

# =============================================================================
# KEY BINDINGS
# =============================================================================

# Emacs-style key bindings
bindkey -e

# Enhanced history navigation
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History substring search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =============================================================================
# COMPLETION STYLING
# =============================================================================

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colorful completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Disable default menu
zstyle ':completion:*' menu no

# FZF-tab previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always $realpath | head -50'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --tree --color=always $realpath | head -50'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza --tree --color=always $realpath | head -50'
zstyle ':fzf-tab:complete:cat:*' fzf-preview 'bat --color=always $realpath 2>/dev/null || eza --tree --color=always $realpath'

# =============================================================================
# MODERN CLI TOOLS CONFIGURATION
# =============================================================================

# Eza (better ls)
alias ls="eza --icons=always --group-directories-first"
alias ll="eza --long --icons=always --group-directories-first"
alias la="eza --long --all --icons=always --group-directories-first"
alias lt="eza --tree --icons=always --group-directories-first"

# Better cat with syntax highlighting
alias cat="bat"

# Enhanced grep
alias grep="rg"

# Modern find
alias find="fd"

# Better man pages
alias man="tldr"

# =============================================================================
# FZF CONFIGURATION
# =============================================================================

# Advanced FZF styling
export FZF_DEFAULT_OPTS="
    --height=60%
    --layout=reverse
    --border=rounded
    --margin=1
    --padding=1
    --info=inline
    --prompt='▶ '
    --pointer='→'
    --marker='✓'
    --color=fg:#d0d0d0,bg:#121212,hl:#5f87af
    --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
    --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
    --color=marker:#87ff00,spinner:#af5fff,header:#87afaf
    --preview-window=right:50%:wrap
    --bind='ctrl-u:preview-page-up,ctrl-d:preview-page-down'
    --bind='ctrl-/:toggle-preview'
"

# FZF command options
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} 2>/dev/null || eza --tree --color=always {} 2>/dev/null'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -50'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind '?:toggle-preview'"

# =============================================================================
# ALIASES
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# Core System & Editor Aliases
# ─────────────────────────────────────────────────────────────────────────────
alias c='clear'
alias h='history'
alias j='jobs'
alias reload='exec zsh'

# ─────────────────────────────────────────────────────────────────────────────
# Git Workflow Aliases
# ─────────────────────────────────────────────────────────────────────────────
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias lg='lazygit'              # Interactive git UI

# ─────────────────────────────────────────────────────────────────────────────
# Container & Orchestration Aliases
# ─────────────────────────────────────────────────────────────────────────────
# Docker
alias d='docker'
alias dps='docker ps'
alias di='docker images'

# Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'

# ─────────────────────────────────────────────────────────────────────────────
# Infrastructure & Automation Aliases
# ─────────────────────────────────────────────────────────────────────────────
# Ansible
alias ap='ansible-playbook'
alias ai='ansible-inventory'
alias av='ansible-vault'
alias ag='ansible-galaxy'
alias ac='ansible-config'
alias apl='ansible-playbook --list-tasks'
alias apc='ansible-playbook --check'
alias apd='ansible-playbook --diff'
alias aps='ansible-playbook --syntax-check'
alias al='ansible-lint'

# AWS
alias awsp='aws --profile'
alias awsl='aws configure list-profiles'

# ─────────────────────────────────────────────────────────────────────────────
# Data Processing & API Aliases
# ─────────────────────────────────────────────────────────────────────────────
# YAML/JSON processing
alias yaml='yq'
alias json='jq'

# HTTP/API testing
alias http='http --print=HhBb'
alias https='http --default-scheme=https'

# ─────────────────────────────────────────────────────────────────────────────
# System Monitoring & Network Aliases
# ─────────────────────────────────────────────────────────────────────────────
# Modern replacements
alias top='btm'
alias htop='btm'

# Network utilities
alias ping='ping -c 5'
alias ports='netstat -tuln'

# ─────────────────────────────────────────────────────────────────────────────
# Terminal Multiplexer Aliases
# ─────────────────────────────────────────────────────────────────────────────
alias t='tmux'
alias ta='tmux attach'
alias tls='tmux list-sessions'
alias tnew='tmux new-session'

# =============================================================================
# ENHANCED FUNCTIONS
# =============================================================================

# ─────────────────────────────────────────────────────────────────────────────
# File & Directory Navigation Functions
# ─────────────────────────────────────────────────────────────────────────────

# Interactive file editing with fzf and bat preview
function fzf-edit() {
    local file=$(fzf --preview 'bat --color=always --style=numbers {}')
    [[ -n $file ]] && $EDITOR $file
}

# Interactive directory navigation with fzf and eza preview
function fzf-cd() {
    local dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --color=always {}')
    [[ -n $dir ]] && cd $dir
}

# Quick file search and edit (alias for fzf-edit)
function fe() {
    local file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --color=always --style=numbers {}')
    [[ -n $file ]] && $EDITOR $file
}

# Enhanced directory creation and navigation
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# ─────────────────────────────────────────────────────────────────────────────
# Git Workflow Functions
# ─────────────────────────────────────────────────────────────────────────────

# Interactive branch switching with fzf
function fzf-git-branch() {
    local branch=$(git branch -a | grep -v HEAD | sed 's/^[* ] //' | sed 's/^remotes\///' | sort -u | fzf --preview 'git log --oneline --graph --color=always {}')
    [[ -n $branch ]] && git checkout $branch
}

# Conventional commits with fzf
function gcom() {
    local type=$(echo "feat\nfix\ndocs\nstyle\nrefactor\ntest\nchore" | fzf --prompt="Select commit type: ")
    [[ -z $type ]] && return 1
    
    local scope
    echo -n "Enter scope (optional): "
    read scope
    
    local message
    echo -n "Enter commit message: "
    read message
    
    local commit_msg="$type"
    [[ -n $scope ]] && commit_msg="$commit_msg($scope)"
    commit_msg="$commit_msg: $message"
    
    git commit -m "$commit_msg"
}

# ─────────────────────────────────────────────────────────────────────────────
# Ansible Automation Functions
# ─────────────────────────────────────────────────────────────────────────────

# Interactive playbook runner with fzf
function ansible-run() {
    local playbook=$(fd -e yml -e yaml | grep -E "(playbook|site|main)" | fzf --preview 'bat --color=always {}')
    [[ -n "$playbook" ]] && ansible-playbook "$playbook" "$@"
}

# Ansible vault editor with fzf
function ansible-vault-edit() {
    local file=$(fd -e yml -e yaml | grep -i vault | fzf --preview 'echo "Encrypted vault file"')
    [[ -n "$file" ]] && ansible-vault edit "$file"
}

# Inventory explorer with JSON output
function ansible-inventory-explore() {
    local inventory=$(fd -e ini -e yml -e yaml | grep -E "(inventory|hosts)" | fzf --preview 'bat --color=always {}')
    [[ -n "$inventory" ]] && ansible-inventory -i "$inventory" --list | jq .
}

# Bulk syntax checking for playbooks
function ansible-check-all() {
    fd -e yml -e yaml | grep -E "(playbook|site|main)" | while read file; do
        echo "Checking $file..."
        ansible-playbook --syntax-check "$file"
    done
}

# ─────────────────────────────────────────────────────────────────────────────
# Cloud & Infrastructure Functions
# ─────────────────────────────────────────────────────────────────────────────

# Interactive AWS profile switcher
function aws-profile() {
    local profile=$(aws configure list-profiles | fzf --prompt="Select AWS profile: ")
    [[ -n "$profile" ]] && export AWS_PROFILE="$profile" && echo "AWS_PROFILE set to: $profile"
}

# ─────────────────────────────────────────────────────────────────────────────
# Data Processing & API Functions
# ─────────────────────────────────────────────────────────────────────────────

# YAML/JSON converter with fzf
function yaml-json-convert() {
    local file=$(fd -e yml -e yaml -e json | fzf --preview 'bat --color=always {}')
    [[ -z "$file" ]] && return 1
    
    if [[ "$file" =~ \.(yml|yaml)$ ]]; then
        yq eval -o=json "$file"
    elif [[ "$file" =~ \.json$ ]]; then
        yq eval -P "$file"
    fi
}

# Interactive HTTP request builder
function http-test() {
    local method=$(echo "GET\nPOST\nPUT\nDELETE\nPATCH" | fzf --prompt="Select HTTP method: ")
    [[ -z "$method" ]] && return 1
    
    local url
    echo -n "Enter URL: "
    read url
    [[ -z "$url" ]] && return 1
    
    case "$method" in
        "GET") http GET "$url" ;;
        "POST") http POST "$url" ;;
        "PUT") http PUT "$url" ;;
        "DELETE") http DELETE "$url" ;;
        "PATCH") http PATCH "$url" ;;
    esac
}

# ─────────────────────────────────────────────────────────────────────────────
# Terminal Multiplexer Functions
# ─────────────────────────────────────────────────────────────────────────────

# Interactive tmux session manager
function tmux-session() {
    if ! command -v tmux >/dev/null 2>&1; then
        echo "tmux is not installed"
        return 1
    fi
    
    local session
    if [[ -n "$TMUX" ]]; then
        # Inside tmux - switch sessions
        session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Switch to session: ")
        [[ -n "$session" ]] && tmux switch-client -t "$session"
    else
        # Outside tmux - attach or create
        if tmux list-sessions >/dev/null 2>&1; then
            session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Attach to session: ")
            [[ -n "$session" ]] && tmux attach-session -t "$session"
        else
            echo "No tmux sessions found. Creating new session..."
            tmux new-session
        fi
    fi
}

# Quick project-based tmux session
function tmux-project() {
    local project_name="${PWD##*/}"
    local session_name="${1:-$project_name}"
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Session '$session_name' already exists. Attaching..."
        tmux attach-session -t "$session_name"
    else
        echo "Creating new session: $session_name"
        tmux new-session -d -s "$session_name" -c "$PWD"
        tmux attach-session -t "$session_name"
    fi
}

# ─────────────────────────────────────────────────────────────────────────────
# System Utility Functions
# ─────────────────────────────────────────────────────────────────────────────

# Process killer with fzf
function fzf-kill() {
    local pid=$(ps -ef | sed 1d | fzf -m --header='[kill:process]' | awk '{print $2}')
    [[ -n $pid ]] && kill -${1:-9} $pid
}

# Universal archive extraction
function extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *.xz)        unxz $1        ;;
            *.lzma)      unlzma $1      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Zsh startup performance profiler
function zsh-profiler() {
    echo "Profiling zsh startup time..."
    for i in {1..5}; do
        time (zsh -i -c exit)
    done
}

# =============================================================================
# LAZY LOADING FOR PERFORMANCE
# =============================================================================

# Lazy load function
function lazy_load() {
    local cmd="$1"
    local init_cmd="$2"
    eval "$cmd() { unfunction $cmd; $init_cmd; $cmd \$@; }"
}

# Lazy load heavy tools
lazy_load nvm 'source ~/.nvm/nvm.sh'
lazy_load conda 'source ~/miniconda3/etc/profile.d/conda.sh'

# =============================================================================
# TOOL INTEGRATIONS (Deferred)
# =============================================================================

# Zoxide integration (better cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# FZF key bindings (load after all other FZF config)
if command -v fzf >/dev/null 2>&1; then
    # Create fzf config directory if it doesn't exist
    mkdir -p ~/.fzf
    
    # Use fzf's built-in zsh integration
    eval "$(fzf --zsh)"
fi

# Docker completions
if [[ -d "$HOME/.docker/completions" ]]; then
    FPATH="$HOME/.docker/completions:$FPATH"
fi

# =============================================================================
# POWERLEVEL10K CONFIGURATION
# =============================================================================

# Load P10k config if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# LOCAL CUSTOMIZATIONS
# =============================================================================

# Load local customizations if they exist
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# =============================================================================
# STARTUP OPTIMIZATION
# =============================================================================

# Compile .zshrc for faster loading
if [[ ! -f ~/.zshrc.zwc ]] || [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi