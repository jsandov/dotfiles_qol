#!/bin/bash

# =============================================================================
# Essential Development Tools Installation Module
# =============================================================================
# Core tools required for the development environment
# =============================================================================

# Essential tools list
declare -a ESSENTIAL_TOOLS=(
    "git"           # Version control
    "curl"          # Data transfer tool
    "wget"          # File download utility
    "tree"          # Directory structure display
    "unzip"         # Archive extraction
    "zip"           # Archive creation
    "gnu-sed"       # GNU sed for compatibility
    "gnu-tar"       # GNU tar for compatibility
    "coreutils"     # GNU core utilities
)

# Install essential tools
install_essential_tools() {
    log_info "Installing essential development tools..."
    
    for tool in "${ESSENTIAL_TOOLS[@]}"; do
        if brew list "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            log_info "Installing $tool..."
            if brew install "$tool"; then
                log_success "$tool installed successfully"
            else
                log_error "Failed to install $tool"
            fi
        fi
    done
}

# Install Command Line Tools for Xcode
install_xcode_tools() {
    if xcode-select --print-path >/dev/null 2>&1; then
        log_info "Xcode Command Line Tools already installed"
        return 0
    fi
    
    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install
    
    # Wait for installation to complete
    log_info "Please complete the Xcode Command Line Tools installation in the popup window"
    log_info "Press any key when installation is complete..."
    read -n 1 -s
}

# Main function
main() {
    install_xcode_tools
    install_essential_tools
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi