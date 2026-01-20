#!/bin/bash
#
# Uninstall nikaj-pkg from the system
# Usage: sudo bash uninstall-nikaj-pkg.sh
#

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   NikajOS Package Manager Uninstaller ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo

# Check for root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[✗] This script must be run as root${NC}"
    echo "Usage: sudo bash $0"
    exit 1
fi

echo -e "${YELLOW}[!] This will completely remove nikaj-pkg from your system${NC}"
echo -e "${YELLOW}[!] Installed packages will NOT be removed${NC}"
echo
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}[*] Uninstallation cancelled${NC}"
    exit 0
fi

echo

# Remove binaries
echo -e "${BLUE}[*] Removing binaries...${NC}"
rm -f /usr/local/bin/nikaj-pkg
rm -f /usr/local/bin/nikaj-build
rm -f /usr/local/bin/nikaj-repo
echo -e "${GREEN}[✓] Binaries removed${NC}"

# Remove database
echo -e "${BLUE}[*] Removing package database...${NC}"
rm -rf /var/lib/nikaj
echo -e "${GREEN}[✓] Database removed${NC}"

# Remove cache
echo -e "${BLUE}[*] Removing package cache...${NC}"
rm -rf /var/cache/nikaj
echo -e "${GREEN}[✓] Cache removed${NC}"

# Remove documentation
echo -e "${BLUE}[*] Removing documentation...${NC}"
rm -rf /usr/local/share/doc/nikaj-pkg
echo -e "${GREEN}[✓] Documentation removed${NC}"

echo
echo -e "${GREEN}[✓] nikaj-pkg has been completely removed${NC}"
echo
echo -e "${BLUE}[*] Note: Installed packages remain in the system${NC}"
echo -e "${BLUE}[*] To reinstall: wget -qO- https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/scripts/install-nikaj-pkg.sh | sudo bash${NC}"
echo
