#!/bin/bash
# NikajOS Package Manager Installer
# Copyright (c) nikajo14™ (2018)2024-2026
# Install nikaj-pkg on any Linux system

set -e

VERSION="0.2.0"

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

echo ""
echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  NikajOS Package Manager Installer    ║${NC}"
echo -e "${BLUE}║           Version ${VERSION}                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "This script must be run as root (use sudo)"
    exit 1
fi

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    PRETTY_OS="$PRETTY_NAME"
else
    OS="unknown"
    PRETTY_OS="Unknown Linux"
fi

print_info "Detected: $PRETTY_OS"
echo ""

# Check dependencies
print_info "Checking dependencies..."

MISSING_DEPS=()

# Check Python 3.6+
if ! command -v python3 &> /dev/null; then
    MISSING_DEPS+=("python3")
else
    PY_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    print_success "Python ${PY_VERSION} found"
    
    # Check if version is >= 3.6
    PY_MAJOR=$(echo $PY_VERSION | cut -d. -f1)
    PY_MINOR=$(echo $PY_VERSION | cut -d. -f2)
    if [ "$PY_MAJOR" -lt 3 ] || ([ "$PY_MAJOR" -eq 3 ] && [ "$PY_MINOR" -lt 6 ]); then
        print_error "Python 3.6 or higher is required (found ${PY_VERSION})"
        exit 1
    fi
fi

# Check other tools
for tool in wget tar gzip; do
    if command -v $tool &> /dev/null; then
        print_success "$tool found"
    else
        MISSING_DEPS+=("$tool")
    fi
done

# Install missing dependencies if any
if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    print_warning "Missing dependencies: ${MISSING_DEPS[*]}"
    
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        print_info "Installing missing dependencies..."
        apt-get update -qq
        apt-get install -y ${MISSING_DEPS[@]}
    elif [ "$OS" = "fedora" ] || [ "$OS" = "rhel" ] || [ "$OS" = "centos" ]; then
        print_info "Installing missing dependencies..."
        yum install -y ${MISSING_DEPS[@]}
    else
        print_error "Cannot auto-install dependencies on $OS"
        print_info "Please install: ${MISSING_DEPS[*]}"
        exit 1
    fi
fi

echo ""

# Remove old installation if exists
if [ -f "/usr/local/bin/nikaj-pkg" ]; then
    print_info "Removing old installation..."
    rm -f /usr/local/bin/nikaj-pkg
    rm -f /usr/local/bin/nikaj-build
    rm -f /usr/local/bin/nikaj-repo
    print_success "Old installation removed"
fi

# Create temporary directory
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

cd "$TEMP_DIR"

print_info "Downloading nikaj-pkg tools..."

# GitHub raw content URLs
REPO_BASE="https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/src/nikaj-pkg"

# Download tools
for tool in nikaj-pkg nikaj-build nikaj-repo; do
    print_info "Downloading $tool..."
    if wget -q --show-progress -O "$tool" "$REPO_BASE/$tool" 2>&1 | grep -v "failed: No such file"; then
        if [ -f "$tool" ] && [ -s "$tool" ]; then
            print_success "$tool downloaded"
        else
            print_error "Failed to download $tool (file empty or missing)"
            exit 1
        fi
    else
        print_error "Failed to download $tool"
        exit 1
    fi
done

echo ""
print_info "Installing nikaj-pkg tools..."

# Install tools to /usr/local/bin
for tool in nikaj-pkg nikaj-build nikaj-repo; do
    if [ -f "$tool" ]; then
        install -m 755 "$tool" /usr/local/bin/
        print_success "$tool installed to /usr/local/bin/$tool"
    else
        print_error "Tool file not found: $tool"
        exit 1
    fi
done

# Create directories
print_info "Creating directories..."
mkdir -p /var/lib/nikaj
mkdir -p /var/cache/nikaj
mkdir -p /usr/local/share/doc/nikaj-pkg

print_success "Directories created"

# Create simple README
cat > /usr/local/share/doc/nikaj-pkg/README << 'EOF'
NikajOS Package Manager (nikaj-pkg)
===================================

Installation completed successfully!

Usage:
------
  nikaj-pkg search <keyword>         Search for packages
  nikaj-pkg install <package>        Install a package from repository
  nikaj-pkg remove <package>         Remove an installed package
  nikaj-pkg list                     List installed packages
  nikaj-pkg info <package>           Show package information
  nikaj-pkg update [packages...]     Update packages

Examples:
---------
  nikaj-pkg search fastfetch
  nikaj-pkg install fastfetch
  nikaj-pkg list
  nikaj-pkg remove fastfetch

Repository:
-----------
  https://github.com/nikajo14a/nikajos-packages

Documentation:
--------------
  https://github.com/nikajo14a/nikajos-packages/blob/main/README.md

Copyright (c) nikajo14™ (2018)2024-2026
EOF

print_success "Documentation created"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Installation completed successfully! ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

print_info "Verifying installation..."

# Verify installation
if command -v nikaj-pkg &> /dev/null; then
    INSTALLED_VERSION=$(nikaj-pkg --version 2>&1 | grep -oP '\d+\.\d+\.\d+' || echo "unknown")
    print_success "nikaj-pkg is installed and working (version: $INSTALLED_VERSION)"
else
    print_error "Installation verification failed"
    print_info "Check if /usr/local/bin is in your PATH"
    exit 1
fi

echo ""
print_info "Quick Start:"
echo ""
echo "  1. Search for packages:"
echo "     ${BOLD}nikaj-pkg search fastfetch${NC}"
echo ""
echo "  2. Install a package:"
echo "     ${BOLD}nikaj-pkg install fastfetch${NC}"
echo ""
echo "  3. List installed packages:"
echo "     ${BOLD}nikaj-pkg list${NC}"
echo ""
print_info "For more information: cat /usr/local/share/doc/nikaj-pkg/README"
echo ""
print_success "Ready to use!"
echo ""
