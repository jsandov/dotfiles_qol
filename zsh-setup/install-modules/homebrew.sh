#!/bin/bash

# =============================================================================
# Homebrew Installation Module
# =============================================================================
# Package manager for macOS - must be installed first
# =============================================================================

# Install Homebrew if not present
install_homebrew() {
    if command -v brew >/dev/null 2>&1; then
        log_info "Homebrew already installed"
        brew --version
        return 0
    fi
    
    log_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    
    # Verify installation
    if command -v brew >/dev/null 2>&1; then
        log_success "Homebrew installed successfully"
        brew --version
    else
        log_error "Homebrew installation failed"
        return 1
    fi
}

# Update Homebrew
update_homebrew() {
    log_info "Updating Homebrew..."
    brew update
    brew upgrade
}

# Main function
main() {
    install_homebrew
    update_homebrew
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi