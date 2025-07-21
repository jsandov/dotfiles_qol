#!/bin/bash

# =============================================================================
# Programming Languages & Runtimes Installation Module
# =============================================================================
# Python, Rust, and Go
# =============================================================================

# Install Python 3.12+
install_python() {
    log_info "Installing Python 3.12..."
    
    if brew list python@3.12 >/dev/null 2>&1; then
        log_info "Python 3.12 already installed"
    else
        brew install python@3.12
    fi
    
    # Install pip packages
    log_info "Installing essential Python packages..."
    python3 -m pip install --upgrade pip
    python3 -m pip install --user pipx
    
    # Ensure pipx is in PATH
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc.local
    fi
}

# Install Rust
install_rust() {
    log_info "Installing Rust..."
    
    if command -v rustc >/dev/null 2>&1; then
        log_info "Rust already installed"
        rustc --version
        return 0
    fi
    
    # Install Rust via rustup
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    
    # Source cargo environment
    source "$HOME/.cargo/env"
    
    # Verify installation
    if command -v rustc >/dev/null 2>&1; then
        log_success "Rust installed successfully"
        rustc --version
    else
        log_error "Rust installation failed"
        return 1
    fi
}

# Install Go
install_go() {
    log_info "Installing Go..."
    
    if brew list go >/dev/null 2>&1; then
        log_info "Go already installed"
        go version
        return 0
    fi
    
    brew install go
    
    # Set up Go environment
    if ! grep -q "GOPATH" ~/.zshrc.local 2>/dev/null; then
        echo 'export GOPATH="$HOME/go"' >> ~/.zshrc.local
        echo 'export PATH="$GOPATH/bin:$PATH"' >> ~/.zshrc.local
    fi
    
    # Verify installation
    if command -v go >/dev/null 2>&1; then
        log_success "Go installed successfully"
        go version
    else
        log_error "Go installation failed"
        return 1
    fi
}


# Main function
main() {
    # Create local zshrc file if it doesn't exist
    touch ~/.zshrc.local
    
    install_python
    install_rust
    install_go
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi