# 🚀 Advanced Zsh Environment Setup

> **Professional-grade Zsh configuration for macOS development environments**

This repository provides a comprehensive, production-ready Zsh configuration with modern CLI tools, optimized for developers working with containers, cloud infrastructure, and automation. The modular setup script automatically installs and configures everything you need for a modern development environment.

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [What Gets Installed](#-what-gets-installed)
- [Installation Modules](#-installation-modules)
- [Modern CLI Tools](#-modern-cli-tools)
- [Aliases & Commands](#-aliases--commands)
- [Enhanced Functions](#-enhanced-functions)
- [Post-Installation Steps](#-post-installation-steps)
- [Troubleshooting](#-troubleshooting)

## 🚀 Quick Start

### Prerequisites
- **macOS** (Intel or Apple Silicon)
- **Terminal** application (Terminal.app, iTerm2, etc.)

### Installation
```bash
# Navigate to the zsh-setup directory
cd zsh-setup

# Make script executable
chmod +x setup-zsh-environment.sh

# Run the complete setup
./setup-zsh-environment.sh
```

### Selective Installation
```bash
# Install specific module only
./setup-zsh-environment.sh --module homebrew

# List available modules
./setup-zsh-environment.sh --list-modules

# Get help
./setup-zsh-environment.sh --help
```

### Next Steps (Required)
```bash
# Restart your terminal or reload shell
exec zsh

# Configure the prompt appearance
p10k configure
```

> **Note:** The script automatically backs up your existing `.zshrc` with timestamps before making changes.

## 📦 What Gets Installed

### 🔧 Essential Development Tools
| Tool | Purpose |
|------|---------|
| **Homebrew** | Package manager for macOS |
| **Zinit** | Fast Zsh plugin manager |
| **Powerlevel10k** | Beautiful, customizable prompt theme |
| **Nerd Fonts** | Icon fonts for terminal symbols |
| **Xcode Command Line Tools** | Essential development tools |

### 🏗️ Programming Languages & Runtimes
| Language | Purpose |
|----------|---------|
| **Python 3.12+** | Modern Python with pip package manager |
| **Rust** | Systems programming language with cargo |
| **Go** | Google's programming language |

### 🛠️ Infrastructure & DevOps Tools
| Tool | Purpose |
|------|---------|
| **Docker** | Container runtime |
| **Ansible & Ansible Lint** | Infrastructure automation and validation |
| **AWS CLI** | Amazon Web Services command line interface |
| **kubectl & k9s** | Kubernetes management tools |
| **Helm** | Kubernetes package manager |

### 📝 Text Processing & Editing Tools
| Tool | Purpose |
|------|---------|
| **tmux** | Terminal multiplexer for session management |
| **jq** | Command-line JSON processor |
| **yq** | Command-line YAML/XML processor |
| **bat** | Syntax-highlighted file viewer with line numbers |

### 🌐 Network & API Tools
| Tool | Purpose |
|------|---------|
| **HTTPie** | Human-friendly HTTP client |
| **wget** | File download utility |
| **curl** | Data transfer tool |
| **Network diagnostic tools** | nmap, netcat, mtr, etc. |


## 🚀 Modern CLI Tools

These tools replace traditional Unix commands with modern, feature-rich alternatives:

| Modern Tool | Replaces | Purpose |
|-------------|----------|---------|
| **fzf** | - | Interactive fuzzy finder for files, commands, and everything |
| **bat** | `cat` | Syntax-highlighted file viewer with line numbers |
| **eza** | `ls` | Modern directory listing with icons and colors |
| **zoxide** | `cd` | Smart directory jumping with frecency algorithm |
| **ripgrep (rg)** | `grep` | Ultra-fast text search with smart case sensitivity |
| **fd** | `find` | Simple, fast, and user-friendly file finder |
| **bottom (btm)** | `top/htop` | Cross-platform system monitor with customizable interface |
| **lazygit** | - | Terminal UI for git commands with visual interface |
| **tldr** | `man` | Simplified and community-driven man pages |
| **delta** | - | Enhanced git diff viewer with syntax highlighting |
| **hyperfine** | `time` | Command-line benchmarking tool |
| **procs** | `ps` | Modern replacement for ps with colored output |

## 🎯 Enhanced Tab Completions

The configuration includes Oh-My-Zsh plugins that provide intelligent tab completions for all major tools:

### 🛠️ **Development Tools Completions:**
- **Docker**: Complete subcommands, container names, image names
- **Kubernetes**: Complete kubectl commands, pod names, namespaces, contexts
- **Git**: Enhanced git command completions and branch suggestions
- **Ansible**: Playbook completions, inventory files, vault operations
- **AWS CLI**: Complete services, subcommands, and resource names

### 💻 **Programming Languages:**
- **Go**: Complete go commands, modules, and build targets
- **Rust**: Complete cargo commands, crates, and features
- **Python**: Smart pip completions and virtual environment detection

### 🔧 **System & Security Tools:**
- **Tmux**: Session management and window completions
- **HTTPie**: HTTP methods, headers, and API endpoints
- **FZF**: Enhanced fuzzy finding with preview windows

### 📋 **How Tab Completion Works:**
```bash
# Examples of enhanced completions
docker <TAB>              # Shows: run, build, pull, push, ps, etc.
kubectl get <TAB>         # Shows: pods, services, deployments, etc.
ansible-playbook <TAB>    # Shows: your actual playbook files
aws s3 <TAB>             # Shows: cp, ls, sync, mb, etc.
cargo <TAB>              # Shows: build, run, test, add, etc.
```

## 📝 Aliases & Commands

### 🗂️ File & Directory Operations
| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `eza --icons=always --group-directories-first` | Modern directory listing with icons |
| `ll` | `eza --long --icons=always --group-directories-first` | Detailed directory listing |
| `la` | `eza --long --all --icons=always --group-directories-first` | Show all files including hidden |
| `lt` | `eza --tree --icons=always --group-directories-first` | Tree view of directories |
| `cat` | `bat` | Syntax-highlighted file viewer |
| `grep` | `rg` | Fast text search with ripgrep |
| `find` | `fd` | User-friendly file finder |
| `man` | `tldr` | Simplified help pages |

### 🛠️ System & Core Commands
| Alias | Command | Description |
|-------|---------|-------------|
| `c` | `clear` | Clear terminal screen |
| `h` | `history` | Show command history |
| `reload` | `exec zsh` | Restart current shell |
| `top` | `btm` | Modern system monitor |
| `htop` | `btm` | Modern system monitor |

### 🔄 Git Workflow
| Alias | Command | Description |
|-------|---------|-------------|
| `g` | `git` | Quick git access |
| `gs` | `git status` | Show repository status |
| `ga` | `git add` | Add files to staging |
| `gc` | `git commit` | Commit changes |
| `gp` | `git push` | Push to remote |
| `gl` | `git pull` | Pull from remote |
| `gd` | `git diff` | Show differences |
| `gb` | `git branch` | List/manage branches |
| `gco` | `git checkout` | Switch branches |
| `lg` | `lazygit` | Terminal UI for Git |

### 🐳 Container & Orchestration
| Alias | Command | Description |
|-------|---------|-------------|
| `d` | `docker` | Docker command shortcut |
| `dps` | `docker ps` | List running containers |
| `di` | `docker images` | List Docker images |
| `k` | `kubectl` | Kubernetes CLI shortcut |
| `kgp` | `kubectl get pods` | List Kubernetes pods |
| `kgs` | `kubectl get svc` | List Kubernetes services |
| `kgd` | `kubectl get deployments` | List Kubernetes deployments |

### 🤖 Ansible Automation
| Alias | Command | Description |
|-------|---------|-------------|
| `ap` | `ansible-playbook` | Run Ansible playbooks |
| `ai` | `ansible-inventory` | Manage inventory |
| `av` | `ansible-vault` | Encrypt/decrypt files |
| `ag` | `ansible-galaxy` | Manage Ansible roles |
| `ac` | `ansible-config` | View configuration |
| `al` | `ansible-lint` | Lint playbooks |
| `apl` | `ansible-playbook --list-tasks` | List playbook tasks |
| `apc` | `ansible-playbook --check` | Dry-run playbooks |
| `apd` | `ansible-playbook --diff` | Show changes |
| `aps` | `ansible-playbook --syntax-check` | Check syntax |

### ☁️ Cloud & Data Processing
| Alias | Command | Description |
|-------|---------|-------------|
| `awsp` | `aws --profile` | Use specific AWS profile |
| `awsl` | `aws configure list-profiles` | List AWS profiles |
| `yaml` | `yq` | Process YAML files |
| `json` | `jq` | Process JSON files |
| `http` | `http --print=HhBb` | HTTPie with full output |
| `https` | `http --default-scheme=https` | HTTPie with HTTPS |


### 🖥️ Terminal & Network
| Alias | Command | Description |
|-------|---------|-------------|
| `t` | `tmux` | Terminal multiplexer |
| `ta` | `tmux attach` | Attach to tmux session |
| `tls` | `tmux list-sessions` | List tmux sessions |
| `tnew` | `tmux new-session` | Create new tmux session |
| `ping` | `ping -c 5` | Ping with 5 packets |
| `ports` | `netstat -tuln` | Show listening ports |

## 🎯 Enhanced Functions

The configuration includes powerful interactive functions that leverage fzf for enhanced productivity:

### 📁 File & Directory Navigation
| Function | Description | Usage |
|----------|-------------|-------|
| `fzf-edit` | Interactively select and edit files with preview | `fzf-edit` |
| `fzf-cd` | Fuzzy search and navigate to directories | `fzf-cd` |
| `fe` | Quick file search and edit (alias for fzf-edit) | `fe` |
| `mkcd` | Create directory and navigate to it | `mkcd new-directory` |

### 🔄 Git Workflow
| Function | Description | Usage |
|----------|-------------|-------|
| `fzf-git-branch` | Interactive branch switching with preview | `fzf-git-branch` |
| `gcom` | Conventional commits with type selection | `gcom` |

### 🤖 Ansible Automation
| Function | Description | Usage |
|----------|-------------|-------|
| `ansible-run` | Interactive playbook selection and execution | `ansible-run` |
| `ansible-vault-edit` | Select and edit vault files interactively | `ansible-vault-edit` |
| `ansible-inventory-explore` | Browse inventory in JSON format | `ansible-inventory-explore` |
| `ansible-check-all` | Bulk syntax checking for all playbooks | `ansible-check-all` |

### ☁️ Cloud & Data Tools
| Function | Description | Usage |
|----------|-------------|-------|
| `aws-profile` | Interactive AWS profile switcher | `aws-profile` |
| `yaml-json-convert` | Convert files between YAML and JSON | `yaml-json-convert` |
| `http-test` | Interactive HTTP request builder | `http-test` |


### 🖥️ Terminal Management
| Function | Description | Usage |
|----------|-------------|-------|
| `tmux-session` | Interactive tmux session manager | `tmux-session` |
| `tmux-project` | Create/attach to project-based sessions | `tmux-project [name]` |

### 🔧 System Utilities
| Function | Description | Usage |
|----------|-------------|-------|
| `fzf-kill` | Interactive process selection and termination | `fzf-kill [signal]` |
| `extract` | Universal archive extraction (supports all formats) | `extract filename` |
| `zsh-profiler` | Measure and analyze shell startup performance | `zsh-profiler` |

## 📦 Installation Modules

The setup is organized into modular components for easy maintenance:

### Module Structure
```
zsh-setup/
├── setup-zsh-environment.sh    # Main orchestration script
├── .zshrc                       # Complete zsh configuration
├── install-modules/             # Modular installation scripts
│   ├── homebrew.sh             # Package manager
│   ├── essential-tools.sh      # Core development tools
│   ├── programming-langs.sh    # Python, Rust, Go
│   ├── infrastructure.sh       # Docker, Ansible, AWS CLI, kubectl
│   ├── editors-text.sh         # tmux, jq, yq, text processing
│   ├── network-api.sh          # HTTPie, wget, curl, network tools
│   ├── modern-cli.sh           # fzf, bat, eza, zoxide, ripgrep
│   └── zsh-config.sh           # Zinit, Powerlevel10k, configuration
└── README.md                    # This documentation
```

### Module Details

#### 1. **homebrew.sh** - Package Manager
- Installs Homebrew for macOS
- Configures PATH for both Intel and Apple Silicon Macs
- Updates existing Homebrew installation

#### 2. **essential-tools.sh** - Core Development Tools
- Xcode Command Line Tools
- Essential Unix utilities (git, curl, wget, tree, unzip)
- GNU alternatives for compatibility

#### 3. **programming-langs.sh** - Programming Languages
- **Python 3.12+** with pip and pipx
- **Rust** with cargo via rustup
- **Go** with workspace configuration

#### 4. **infrastructure.sh** - DevOps & Infrastructure
- **Docker Desktop** for containerization
- **Ansible** with ansible-lint for automation
- **AWS CLI** for cloud management
- **kubectl** and **k9s** for Kubernetes
- **Helm** for Kubernetes package management

#### 5. **editors-text.sh** - Text Processing Tools
- **tmux** with optimized configuration
- **jq** for JSON processing
- **yq** for YAML/XML processing
- **bat** for enhanced file viewing
- Modern alternatives to traditional tools

#### 6. **network-api.sh** - Network & API Tools
- **HTTPie** for human-friendly HTTP requests
- **wget** and **curl** for data transfer
- Network diagnostic tools (nmap, netcat, mtr)
- API development tools (Postman, Insomnia)


#### 7. **modern-cli.sh** - Modern CLI Replacements
- **fzf** for interactive fuzzy finding
- **bat**, **eza**, **zoxide**, **ripgrep**, **fd**
- **lazygit** for visual git interface
- **bottom** for system monitoring
- **Nerd Fonts** for icon support

#### 8. **zsh-config.sh** - Zsh Configuration
- **Zinit** plugin manager installation
- **Powerlevel10k** theme configuration
- Complete `.zshrc` setup with optimizations
- Shell configuration and defaults

## ✅ Post-Installation Steps

After running the setup script, complete these steps to get the full experience:

### 1. Restart Your Shell (Required)
```bash
# Option 1: Reload current shell
exec zsh

# Option 2: Close and reopen your terminal
```

### 2. Configure Prompt Appearance (Required)
```bash
p10k configure
```

The configuration wizard will guide you through:
- **Prompt style**: Choose between lean, classic, rainbow, or pure
- **Character set**: Unicode (recommended) or ASCII fallback
- **Show on left**: Current directory, git status, etc.
- **Show on right**: Time, background jobs, etc.
- **Prompt height**: Single or two-line prompt

### 3. Test Your Installation
```bash
# Try some new commands
ls          # Should show icons and colors
ll          # Detailed file listing
cat README.md   # Syntax highlighted output
fzf-edit    # Interactive file selection
lg          # If in a git repo - opens lazygit
```

### 4. Explore Interactive Features
```bash
# File navigation
fe          # Find and edit files
fzf-cd      # Navigate directories

# Git workflow
fzf-git-branch  # Switch branches interactively
gcom        # Conventional commits

# AWS tools
aws-profile # Switch AWS profiles

# System tools
fzf-kill    # Kill processes interactively
tmux-session    # Manage tmux sessions
```

## 🔧 Troubleshooting

### Common Issues and Solutions

#### Installation Problems
| Problem | Solution |
|---------|----------|
| **Permission denied** | Run `chmod +x setup-zsh-environment.sh` |
| **Script fails** | Run with debug: `bash -x setup-zsh-environment.sh` |
| **Homebrew errors** | Check with `brew doctor` |
| **Module fails** | Run specific module: `./setup-zsh-environment.sh --module <name>` |

#### Runtime Issues
| Problem | Solution |
|---------|----------|
| **Commands not found** | Restart terminal: `exec zsh` |
| **Slow startup** | Run `zsh-profiler` to identify bottlenecks |
| **Icons not showing** | Install Nerd Font and configure terminal |
| **Completions broken** | Delete cache: `rm ~/.zcompdump*; exec zsh` |
| **Functions not working** | Check if tools are installed: `which fzf bat eza` |

#### Font and Display Issues
| Problem | Solution |
|---------|----------|
| **Missing icons/symbols** | Ensure Nerd Font is installed and selected in terminal |
| **Garbled characters** | Switch terminal font to "MesloLGS NF" |
| **Wrong colors** | Check terminal color scheme compatibility |
| **Prompt issues** | Re-run `p10k configure` |


### Performance Optimization
```bash
# Check startup time
zsh-profiler

# Update plugins
zinit self-update
zinit update

# Clear caches if needed
zinit cclear
rm ~/.zcompdump*
```

### Module-Specific Troubleshooting
```bash
# Test specific module
./setup-zsh-environment.sh --module modern-cli

# List available modules
./setup-zsh-environment.sh --list-modules

# Reinstall specific tools
brew reinstall fzf bat eza
```

### Getting Help
1. Check if the issue is covered in this troubleshooting section
2. Try running the setup script again: `./setup-zsh-environment.sh`
3. Use debug mode for detailed output: `bash -x setup-zsh-environment.sh`
4. Check your shell: `echo $SHELL` (should be `/bin/zsh` or similar)
5. Verify tool installations: `which <tool-name>`

---

**Built for productivity. Optimized for performance. Ready for development.**

🌟 **Enjoy your enhanced development environment!**