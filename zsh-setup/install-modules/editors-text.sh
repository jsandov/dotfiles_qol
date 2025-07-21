#!/bin/bash

# =============================================================================
# Editors & Text Processing Tools Installation Module
# =============================================================================
# tmux, jq, yq, and other text processing tools
# =============================================================================

# Text processing tools list
declare -a TEXT_TOOLS=(
    "tmux"              # Terminal multiplexer
    "jq"                # JSON processor
    "yq"                # YAML/XML processor
    "bat"               # Better cat with syntax highlighting
    "less"              # Better pager
)


# Install tmux
install_tmux() {
    log_info "Installing tmux..."
    
    if brew list tmux >/dev/null 2>&1; then
        log_info "tmux already installed"
        tmux -V
        return 0
    fi
    
    brew install tmux
    
    # Basic tmux configuration
    if [[ ! -f ~/.tmux.conf ]]; then
        cat > ~/.tmux.conf << 'EOF'
# Basic tmux configuration
# Prefix key
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Reload config
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# Split panes
bind | split-window -h
bind - split-window -v

# Move between panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Enable mouse mode
set -g mouse on

# Status bar
set -g status-bg black
set -g status-fg white
set -g status-left '[#S] '
set -g status-right '%H:%M %d-%b-%y'

# Window numbering
set -g base-index 1
setw -g pane-base-index 1

# Colors
set -g default-terminal "screen-256color"
EOF
        log_info "Basic tmux configuration created at ~/.tmux.conf"
    fi
    
    # Verify installation
    if command -v tmux >/dev/null 2>&1; then
        log_success "tmux installed successfully"
        tmux -V
    else
        log_error "tmux installation failed"
        return 1
    fi
}

# Install JSON/YAML processors
install_processors() {
    log_info "Installing text processors (jq, yq)..."
    
    # Install jq
    if brew list jq >/dev/null 2>&1; then
        log_info "jq already installed"
    else
        brew install jq
    fi
    
    # Install yq
    if brew list yq >/dev/null 2>&1; then
        log_info "yq already installed"
    else
        brew install yq
    fi
    
    # Verify installations
    if command -v jq >/dev/null 2>&1; then
        log_success "jq installed successfully"
        jq --version
    fi
    
    if command -v yq >/dev/null 2>&1; then
        log_success "yq installed successfully"
        yq --version
    fi
}

# Install enhanced text tools
install_enhanced_text_tools() {
    log_info "Installing enhanced text tools..."
    
    # Install bat (better cat)
    if brew list bat >/dev/null 2>&1; then
        log_info "bat already installed"
    else
        brew install bat
    fi
    
    # Install better less
    if brew list less >/dev/null 2>&1; then
        log_info "less already installed"
    else
        brew install less
    fi
    
    # Verify installations
    if command -v bat >/dev/null 2>&1; then
        log_success "bat installed successfully"
        bat --version
    fi
}

# Install additional development tools
install_dev_tools() {
    log_info "Installing additional development tools..."
    
    declare -a dev_tools=(
        "ripgrep"       # Fast text search
        "fd"            # Better find
        "htop"          # System monitor
        "bottom"        # Modern system monitor
        "dust"          # Better du
        "procs"         # Better ps
    )
    
    for tool in "${dev_tools[@]}"; do
        if brew list "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            brew install "$tool"
        fi
    done
}

# Main function
main() {
    install_tmux
    install_processors
    install_enhanced_text_tools
    install_dev_tools
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi