#!/bin/bash
# NikajOS Package Manager Installer for Debian/Ubuntu
# Copyright (c) nikajo14™ (2018)2024-2025
#
# This script installs nikaj-pkg on Debian and Ubuntu systems

set -e

VERSION="0.1.0"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1" >&2; }
print_info() { echo -e "${BLUE}[*]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_error "This script must be run as root (use sudo)"
    exit 1
fi

print_info "NikajOS Package Manager Installer v${VERSION}"
echo ""

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
else
    print_error "Cannot detect OS. This script is for Debian/Ubuntu systems."
    exit 1
fi

if [ "$OS" != "ubuntu" ] && [ "$OS" != "debian" ]; then
    print_warning "This system appears to be $OS, not Debian or Ubuntu."
    print_warning "Installation may still work, but it's untested."
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

print_info "Detected: $PRETTY_NAME"
echo ""

# Check for Python 3
print_info "Checking dependencies..."
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is required but not installed."
    print_info "Installing Python 3..."
    apt-get update
    apt-get install -y python3
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
print_success "Python 3 found: $(python3 --version)"

# Check for other dependencies
DEPS="wget tar gzip bzip2 xz-utils"
MISSING_DEPS=""

for dep in $DEPS; do
    if ! dpkg -s $dep &> /dev/null; then
        MISSING_DEPS="$MISSING_DEPS $dep"
    fi
done

if [ -n "$MISSING_DEPS" ]; then
    print_info "Installing missing dependencies:$MISSING_DEPS"
    apt-get update
    apt-get install -y $MISSING_DEPS
fi

print_success "All dependencies satisfied"
echo ""

# Create directory structure
print_info "Creating directory structure..."
mkdir -p /usr/local/bin
mkdir -p /var/lib/nikaj/local
mkdir -p /var/cache/nikaj
mkdir -p /etc
mkdir -p /usr/local/share/doc/nikaj-pkg

print_success "Directories created"

# Download or copy nikaj-pkg tools
INSTALL_DIR="/tmp/nikaj-pkg-install-$$"
mkdir -p "$INSTALL_DIR"

print_info "Downloading nikaj-pkg tools..."

# GitHub raw content URLs
REPO_BASE="https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/src/nikaj-pkg"

for tool in nikaj-pkg nikaj-build nikaj-repo; do
    print_info "Downloading $tool..."
    if wget -q -O "$INSTALL_DIR/$tool" "$REPO_BASE/$tool"; then
        print_success "$tool downloaded"
    else
        print_error "Failed to download $tool"
        print_info "Attempting alternative download method..."
        # Try with different URL format
        if ! wget -O "$INSTALL_DIR/$tool" "https://github.com/nikajo14a/NikajOS/raw/main/src/nikaj-pkg/$tool"; then
            print_error "Could not download $tool. Please check your internet connection."
            rm -rf "$INSTALL_DIR"
            exit 1
        fi
    fi
done

# Install tools
print_info "Installing nikaj-pkg tools..."
for tool in nikaj-pkg nikaj-build nikaj-repo; do
    cp "$INSTALL_DIR/$tool" /usr/local/bin/
    chmod +x /usr/local/bin/$tool
done

print_success "Tools installed to /usr/local/bin/"

# Create configuration file
print_info "Creating configuration file..."
cat > /etc/nikaj-pkg.conf << 'EOF'
# NikajOS Package Manager Configuration

# Repository URL
REPO_DB_URL=https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/NikajOS%20Official%20Package%20Repository.db
REPO_PKG_URL=https://github.com/nikajo14a/nikajos-packages/raw/main/x86_64/

# Local paths
DB_PATH=/var/lib/nikaj
CACHE_PATH=/var/cache/nikaj

# Package installation options
SKIP_ROOT_CHECK=0
AUTO_DEPS=1
EOF

print_success "Configuration created at /etc/nikaj-pkg.conf"

# Create documentation
print_info "Creating documentation..."
cat > /usr/local/share/doc/nikaj-pkg/README << 'EOF'
NikajOS Package Manager
=======================

The nikaj-pkg system allows you to install .nikaj packages on your system.

Installation Commands:
----------------------
  nikaj-pkg install <package.nikaj>  - Install a package file
  nikaj-pkg remove <package>         - Remove an installed package
  nikaj-pkg list                     - List all installed packages
  nikaj-pkg info <package>           - Show package information
  nikaj-pkg search <term>            - Search for packages
  nikaj-pkg update [packages...]     - Update packages from repository

Build Tools:
------------
  nikaj-build                        - Build package from PKGBUILD
  nikaj-build -i                     - Build and install package
  nikaj-build -c                     - Clean build before building

Repository Management:
----------------------
  nikaj-repo update <directory>      - Update repository database
  nikaj-repo add <repo> <package>    - Add package to repository

Repository:
-----------
  Official: https://github.com/nikajo14a/nikajos-packages
  Main OS: https://github.com/nikajo14a/NikajOS

Installation Location:
----------------------
  Installed packages: /var/lib/nikaj/local/
  Package cache: /var/cache/nikaj/
  Configuration: /etc/nikaj-pkg.conf

Note: Most nikaj packages are designed for NikajOS and may have 
dependencies or paths specific to that system. Use with caution on 
Debian/Ubuntu systems. Some packages may require adaptation.

Copyright (c) nikajo14™ (2018)2024-2025
EOF

print_success "Documentation created"

# Cleanup
rm -rf "$INSTALL_DIR"

# Verify installation
echo ""
print_info "Verifying installation..."
if command -v nikaj-pkg &> /dev/null; then
    print_success "nikaj-pkg is installed and available"
    VERSION_OUTPUT=$(nikaj-pkg --version 2>/dev/null || echo "version check N/A")
    echo "  Location: $(which nikaj-pkg)"
else
    print_error "Installation verification failed"
    exit 1
fi

if command -v nikaj-build &> /dev/null; then
    print_success "nikaj-build is installed and available"
else
    print_warning "nikaj-build not found in PATH"
fi

if command -v nikaj-repo &> /dev/null; then
    print_success "nikaj-repo is installed and available"
else
    print_warning "nikaj-repo not found in PATH"
fi

echo ""
print_success "Installation complete!"
echo ""
echo "${BOLD}Quick Start:${NC}"
echo "  1. Download a .nikaj package:"
echo "     wget https://github.com/nikajo14a/nikajos-packages/raw/main/x86_64/<package>.nikaj"
echo ""
echo "  2. Install it:"
echo "     nikaj-pkg install <package>.nikaj"
echo ""
echo "  3. List installed packages:"
echo "     nikaj-pkg list"
echo ""
echo "For more information: cat /usr/local/share/doc/nikaj-pkg/README"
echo ""
