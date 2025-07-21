#!/bin/bash

# =============================================================================
# Network & API Tools Installation Module
# =============================================================================
# HTTPie, wget, curl, 1Password CLI, and other network tools
# =============================================================================

# Install HTTPie
install_httpie() {
    log_info "Installing HTTPie..."
    
    if brew list httpie >/dev/null 2>&1; then
        log_info "HTTPie already installed"
        http --version
        return 0
    fi
    
    brew install httpie
    
    # Verify installation
    if command -v http >/dev/null 2>&1; then
        log_success "HTTPie installed successfully"
        http --version
    else
        log_error "HTTPie installation failed"
        return 1
    fi
}

# Install enhanced wget
install_wget() {
    log_info "Installing wget..."
    
    if brew list wget >/dev/null 2>&1; then
        log_info "wget already installed"
        wget --version | head -1
        return 0
    fi
    
    brew install wget
    
    # Verify installation
    if command -v wget >/dev/null 2>&1; then
        log_success "wget installed successfully"
        wget --version | head -1
    else
        log_error "wget installation failed"
        return 1
    fi
}

# Install enhanced curl
install_curl() {
    log_info "Installing curl..."
    
    if brew list curl >/dev/null 2>&1; then
        log_info "curl already installed"
        curl --version | head -1
        return 0
    fi
    
    # Install newer curl via Homebrew
    brew install curl
    
    # Add to PATH if not already there
    if ! grep -q "/opt/homebrew/opt/curl/bin" ~/.zshrc.local 2>/dev/null; then
        echo 'export PATH="/opt/homebrew/opt/curl/bin:$PATH"' >> ~/.zshrc.local
    fi
    
    log_success "curl installed successfully"
}


# Install network diagnostic tools
install_network_tools() {
    log_info "Installing network diagnostic tools..."
    
    declare -a net_tools=(
        "nmap"          # Network scanner
        "netcat"        # Network utility
        "tcpdump"       # Packet analyzer
        "wireshark"     # Network protocol analyzer (GUI)
        "mtr"           # Network diagnostic tool
        "iperf3"        # Network performance measurement
    )
    
    for tool in "${net_tools[@]}"; do
        if [[ "$tool" == "wireshark" ]]; then
            # Wireshark is a cask application
            if brew list --cask wireshark >/dev/null 2>&1; then
                log_info "$tool already installed"
            else
                brew install --cask wireshark
            fi
        else
            if brew list "$tool" >/dev/null 2>&1; then
                log_info "$tool already installed"
            else
                brew install "$tool"
            fi
        fi
    done
}

# Install API development tools
install_api_tools() {
    log_info "Installing API development tools..."
    
    declare -a api_tools=(
        "postman"       # API development platform
        "insomnia"      # REST client
    )
    
    for tool in "${api_tools[@]}"; do
        if brew list --cask "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            log_info "Installing $tool..."
            brew install --cask "$tool" || log_warning "Failed to install $tool (optional)"
        fi
    done
}

# Install security tools
install_security_tools() {
    log_info "Installing security tools..."
    
    declare -a security_tools=(
        "openssh"       # OpenSSH client/server
        "openssl"       # SSL/TLS toolkit
    )
    
    for tool in "${security_tools[@]}"; do
        if brew list "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            brew install "$tool"
        fi
    done
}

# Main function
main() {
    # Create local zshrc file if it doesn't exist
    touch ~/.zshrc.local
    
    install_httpie
    install_wget
    install_curl
    install_network_tools
    install_api_tools
    install_security_tools
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi