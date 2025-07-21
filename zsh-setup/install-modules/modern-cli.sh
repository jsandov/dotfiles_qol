#!/bin/bash

# =============================================================================
# Modern CLI Tools Installation Module
# =============================================================================
# fzf, bat, eza, zoxide, ripgrep, fd, and other modern CLI replacements
# =============================================================================

# Modern CLI tools list
declare -a MODERN_TOOLS=(
    "fzf"               # Interactive fuzzy finder
    "bat"               # Better cat with syntax highlighting
    "eza"               # Better ls with icons and colors
    "zoxide"            # Smart directory jumping
    "ripgrep"           # Ultra-fast text search
    "fd"                # Simple, fast file finder
    "bottom"            # Cross-platform system monitor
    "lazygit"           # Terminal UI for git
    "tldr"              # Simplified man pages
    "delta"             # Enhanced git diff viewer
    "hyperfine"         # Command-line benchmarking
    "procs"             # Modern ps replacement
    "dust"              # Better du
    "tokei"             # Code statistics
)

# Install FZF and configure
install_fzf() {
    log_info "Installing FZF..."
    
    if brew list fzf >/dev/null 2>&1; then
        log_info "FZF already installed"
    else
        brew install fzf
    fi
    
    # Install FZF key bindings and fuzzy completion
    if [[ -d "/opt/homebrew/opt/fzf" ]]; then
        /opt/homebrew/opt/fzf/install --key-bindings --completion --no-update-rc
    elif [[ -d "/usr/local/opt/fzf" ]]; then
        /usr/local/opt/fzf/install --key-bindings --completion --no-update-rc
    fi
    
    # Verify installation
    if command -v fzf >/dev/null 2>&1; then
        log_success "FZF installed successfully"
        fzf --version
    else
        log_error "FZF installation failed"
        return 1
    fi
}

# Install Eza (better ls)
install_eza() {
    log_info "Installing eza..."
    
    if brew list eza >/dev/null 2>&1; then
        log_info "eza already installed"
        eza --version
        return 0
    fi
    
    brew install eza
    
    # Verify installation
    if command -v eza >/dev/null 2>&1; then
        log_success "eza installed successfully"
        eza --version
    else
        log_error "eza installation failed"
        return 1
    fi
}

# Install Zoxide (smart cd)
install_zoxide() {
    log_info "Installing zoxide..."
    
    if brew list zoxide >/dev/null 2>&1; then
        log_info "zoxide already installed"
        zoxide --version
        return 0
    fi
    
    brew install zoxide
    
    # Verify installation
    if command -v zoxide >/dev/null 2>&1; then
        log_success "zoxide installed successfully"
        zoxide --version
    else
        log_error "zoxide installation failed"
        return 1
    fi
}

# Install Ripgrep (better grep)
install_ripgrep() {
    log_info "Installing ripgrep..."
    
    if brew list ripgrep >/dev/null 2>&1; then
        log_info "ripgrep already installed"
        rg --version
        return 0
    fi
    
    brew install ripgrep
    
    # Verify installation
    if command -v rg >/dev/null 2>&1; then
        log_success "ripgrep installed successfully"
        rg --version
    else
        log_error "ripgrep installation failed"
        return 1
    fi
}

# Install fd (better find)
install_fd() {
    log_info "Installing fd..."
    
    if brew list fd >/dev/null 2>&1; then
        log_info "fd already installed"
        fd --version
        return 0
    fi
    
    brew install fd
    
    # Verify installation
    if command -v fd >/dev/null 2>&1; then
        log_success "fd installed successfully"
        fd --version
    else
        log_error "fd installation failed"
        return 1
    fi
}

# Install Lazygit
install_lazygit() {
    log_info "Installing lazygit..."
    
    if brew list lazygit >/dev/null 2>&1; then
        log_info "lazygit already installed"
        lazygit --version
        return 0
    fi
    
    brew install lazygit
    
    # Create config directory
    mkdir -p ~/.config/lazygit
    
    # Basic lazygit configuration
    if [[ ! -f ~/.config/lazygit/config.yml ]]; then
        cat > ~/.config/lazygit/config.yml << 'EOF'
gui:
  theme:
    lightTheme: false
    activeBorderColor:
      - green
      - bold
    inactiveBorderColor:
      - default
  commitLength:
    show: true
  mouseEvents: true
  skipDiscardChangeWarning: false
  skipStashWarning: false
  showFileTree: true
  showRandomTip: true
  showCommandLog: true
git:
  paging:
    colorArg: always
    pager: delta --dark --paging=never
  merging:
    manualCommit: false
    args: ''
  log:
    order: 'topo-order'
    showGraph: 'always'
  skipHookPrefix: WIP
  autoFetch: true
  branchLogCmd: 'git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --'
  allBranchesLogCmd: 'git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium'
  overrideGpg: false
  disableForcePushing: false
  parseEmoji: false
update:
  method: prompt
  days: 14
reporting: 'undetermined'
confirmOnQuit: false
quitOnTopLevelReturn: false
keybinding:
  universal:
    quit: 'q'
    quit-alt1: '<c-c>'
    return: '<esc>'
    quitWithoutChangingDirectory: 'Q'
    togglePanel: '<tab>'
    prevItem: '<up>'
    nextItem: '<down>'
    prevItem-alt: 'k'
    nextItem-alt: 'j'
    prevPage: ','
    nextPage: '.'
    gotoTop: '<'
    gotoBottom: '>'
    scrollLeft: 'H'
    scrollRight: 'L'
    prevBlock: '<left>'
    nextBlock: '<right>'
    prevBlock-alt: 'h'
    nextBlock-alt: 'l'
    jumpToBlock: ['1', '2', '3', '4', '5']
    nextMatch: 'n'
    prevMatch: 'N'
    optionMenu: 'x'
    optionMenu-alt1: '?'
    select: '<space>'
    goInto: '<enter>'
    openRecentRepos: '<c-r>'
    confirm: '<enter>'
    confirm-alt1: 'y'
    remove: 'd'
    new: 'n'
    edit: 'e'
    openFile: 'o'
    scrollUpMain: '<pgup>'
    scrollDownMain: '<pgdown>'
    scrollUpMain-alt1: 'K'
    scrollDownMain-alt1: 'J'
    scrollUpMain-alt2: '<c-u>'
    scrollDownMain-alt2: '<c-d>'
    executeCustomCommand: ':'
    createRebaseOptionsMenu: 'm'
    pushFiles: 'P'
    pullFiles: 'p'
    refresh: 'R'
    createPatchOptionsMenu: '<c-p>'
    nextTab: ']'
    prevTab: '['
    nextScreenMode: '+'
    prevScreenMode: '_'
    undo: 'z'
    redo: '<c-z>'
    filteringMenu: '<c-s>'
    diffingMenu: 'W'
    diffingMenu-alt: '<c-e>'
    copyToClipboard: '<c-o>'
    submitEditorText: '<enter>'
    appendNewline: '<a-enter>'
EOF
        log_info "Basic lazygit configuration created"
    fi
    
    # Verify installation
    if command -v lazygit >/dev/null 2>&1; then
        log_success "lazygit installed successfully"
        lazygit --version
    else
        log_error "lazygit installation failed"
        return 1
    fi
}

# Install remaining modern tools
install_remaining_tools() {
    log_info "Installing remaining modern CLI tools..."
    
    declare -a remaining_tools=(
        "bottom"        # System monitor
        "tldr"          # Simplified man pages
        "delta"         # Git diff viewer
        "hyperfine"     # Benchmarking
        "procs"         # Better ps
        "dust"          # Better du
        "tokei"         # Code statistics
    )
    
    for tool in "${remaining_tools[@]}"; do
        if brew list "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            log_info "Installing $tool..."
            if brew install "$tool"; then
                log_success "$tool installed successfully"
            else
                log_warning "Failed to install $tool (optional)"
            fi
        fi
    done
}

# Install Nerd Fonts for icon support
install_nerd_fonts() {
    log_info "Installing Nerd Fonts..."
    
    # Check if font is already installed
    if brew list --cask font-meslo-lg-nerd-font >/dev/null 2>&1; then
        log_info "MesloLGS Nerd Font already installed"
        return 0
    fi
    
    # Tap nerd-fonts if not already tapped
    brew tap homebrew/cask-fonts || true
    
    # Install MesloLGS Nerd Font (recommended for Powerlevel10k)
    brew install --cask font-meslo-lg-nerd-font
    
    log_success "Nerd Font installed successfully"
    log_info "Please set your terminal font to 'MesloLGS NF' for best experience"
}

# Main function
main() {
    install_fzf
    install_eza
    install_zoxide
    install_ripgrep
    install_fd
    install_lazygit
    install_remaining_tools
    install_nerd_fonts
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi