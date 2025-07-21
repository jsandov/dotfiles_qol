#!/bin/bash

# =============================================================================
# Infrastructure & DevOps Tools Installation Module
# =============================================================================
# Docker, Ansible, AWS CLI, kubectl, k9s
# =============================================================================

# Infrastructure tools list
declare -a INFRA_TOOLS=(
    "docker"            # Container runtime
    "ansible"           # Infrastructure automation
    "ansible-lint"      # Ansible linting
    "awscli"           # AWS command line interface
    "kubectl"          # Kubernetes CLI
    "k9s"              # Kubernetes TUI
    "helm"             # Kubernetes package manager
)

# Install Docker
install_docker() {
    log_info "Installing Docker..."
    
    if brew list --cask docker >/dev/null 2>&1; then
        log_info "Docker already installed"
        return 0
    fi
    
    # Install Docker Desktop via Homebrew Cask
    brew install --cask docker
    
    log_info "Docker Desktop installed. Please start Docker Desktop from Applications."
    log_warning "You may need to restart your terminal after Docker Desktop is running."
}

# Install Ansible and related tools
install_ansible() {
    log_info "Installing Ansible and related tools..."
    
    # Install via Homebrew
    for tool in ansible ansible-lint; do
        if brew list "$tool" >/dev/null 2>&1; then
            log_info "$tool already installed"
        else
            brew install "$tool"
        fi
    done
    
    # Install additional Ansible collections via pip
    log_info "Installing Ansible collections..."
    python3 -m pip install --user ansible-core ansible-navigator
    
    # Install popular Ansible collections
    ansible-galaxy collection install community.general || true
    ansible-galaxy collection install ansible.posix || true
    ansible-galaxy collection install community.docker || true
    
    log_success "Ansible tools installed successfully"
}

# Install AWS CLI
install_aws_cli() {
    log_info "Installing AWS CLI..."
    
    if brew list awscli >/dev/null 2>&1; then
        log_info "AWS CLI already installed"
        aws --version
        return 0
    fi
    
    brew install awscli
    
    # Verify installation
    if command -v aws >/dev/null 2>&1; then
        log_success "AWS CLI installed successfully"
        aws --version
    else
        log_error "AWS CLI installation failed"
        return 1
    fi
}

# Install Kubernetes tools
install_kubernetes_tools() {
    log_info "Installing Kubernetes tools..."
    
    # Install kubectl
    if brew list kubectl >/dev/null 2>&1; then
        log_info "kubectl already installed"
    else
        brew install kubectl
    fi
    
    # Install k9s
    if brew list k9s >/dev/null 2>&1; then
        log_info "k9s already installed"
    else
        brew install k9s
    fi
    
    # Install kubectx and kubens
    if brew list kubectx >/dev/null 2>&1; then
        log_info "kubectx already installed"
    else
        brew install kubectx
    fi
    
    log_success "Kubernetes tools installed successfully"
}


# Install Helm
install_helm() {
    log_info "Installing Helm..."
    
    if brew list helm >/dev/null 2>&1; then
        log_info "Helm already installed"
        helm version
        return 0
    fi
    
    brew install helm
    
    # Verify installation
    if command -v helm >/dev/null 2>&1; then
        log_success "Helm installed successfully"
        helm version
    else
        log_error "Helm installation failed"
        return 1
    fi
}

# Main function
main() {
    install_docker
    install_ansible
    install_aws_cli
    install_kubernetes_tools
    install_helm
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi