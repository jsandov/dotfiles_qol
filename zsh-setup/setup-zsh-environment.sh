#!/bin/bash

# =============================================================================
# Advanced Zsh Environment Setup - Main Installation Script
# =============================================================================
# Professional-grade Zsh configuration for macOS development environments
# Compatible with macOS (Intel/Apple Silicon)
# =============================================================================

set -euo pipefail

# Script directory for sourcing modules
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/install-modules"

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This script is designed for macOS only."
        exit 1
    fi
}

# Create backup of existing zshrc
backup_zshrc() {
    if [[ -f ~/.zshrc ]]; then
        local backup_file="$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        cp ~/.zshrc "$backup_file"
        log_info "Backed up existing .zshrc to $backup_file"
    fi
}

# Source installation module
source_module() {
    local module="$1"
    local module_path="$INSTALL_DIR/${module}.sh"
    
    if [[ -f "$module_path" ]]; then
        log_info "Installing $module..."
        # shellcheck source=/dev/null
        source "$module_path"
        
        # Call the module's main function if it exists
        if declare -f main >/dev/null 2>&1; then
            if main; then
                log_success "$module installation completed successfully"
                return 0
            else
                log_error "$module installation failed"
                return 1
            fi
        else
            log_warning "$module has no main function"
            return 1
        fi
    else
        log_error "Module not found: $module_path"
        return 1
    fi
}

# Main installation function
main() {
    log_info "Starting Advanced Zsh Environment Setup"
    log_info "========================================"
    
    # Pre-flight checks
    check_macos
    backup_zshrc
    
    # Create install-modules directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Installation order matters - dependencies first
    local modules=(
        "homebrew"           # Package manager (must be first)
        "essential-tools"    # Core development tools
        "programming-langs"  # Python, Rust, Go
        "infrastructure"     # Docker, Ansible, AWS CLI, kubectl
        "editors-text"       # tmux, jq, yq
        "network-api"        # HTTPie, wget, curl
        "modern-cli"         # fzf, bat, eza, zoxide, ripgrep, etc.
        "zsh-config"         # Zinit, themes, plugins, config
    )
    
    # Install each module
    for module in "${modules[@]}"; do
        if source_module "$module"; then
            log_success "✓ $module"
        else
            log_error "✗ $module failed"
            log_warning "Continuing with next module..."
        fi
        echo
    done
    
    # Final steps
    log_info "Installation Summary"
    log_info "==================="
    log_success "✓ Zsh environment setup completed!"
    log_info "Next steps:"
    echo "  1. Restart your terminal: exec zsh"
    echo "  2. Configure prompt: p10k configure"
    echo "  3. Test installation: ls, cat README.md, fzf-edit"
    echo
    log_warning "If you encounter any issues, check the troubleshooting section in README-zsh-setup.md"
}

# Allow running specific modules
if [[ $# -gt 0 ]]; then
    case "$1" in
        --module)
            if [[ -n "${2:-}" ]]; then
                source_module "$2"
            else
                log_error "Please specify a module name"
                exit 1
            fi
            ;;
        --list-modules)
            log_info "Available modules:"
            ls -1 "$INSTALL_DIR"/*.sh 2>/dev/null | sed 's|.*/||; s|\.sh$||' || log_warning "No modules found in $INSTALL_DIR"
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --module <name>    Install specific module"
            echo "  --list-modules     List available modules"
            echo "  --help, -h         Show this help"
            ;;
        *)
            log_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
else
    main
fi