# NikajOS Package Repository

Official package repository for NikajOS - a custom Linux distribution based on Linux From Scratch.

## 📦 Available Packages

**Total Packages**: 41 | **Architecture**: x86_64 | **Repository Size**: ~75MB

Browse packages in the `x86_64/` directory.

## 🚀 Usage

### Using the Package Manager:

```bash
# List installed packages
nikaj-pkg list

# Show package information
nikaj-pkg info bash

# Check for updates
sudo nikaj-pkg update

# Install a downloaded package
sudo nikaj-pkg install package-name.nikaj

# Remove a package
sudo nikaj-pkg remove package-name
```

### Manual Package Installation:

```bash
# Download and install a package
wget https://github.com/nikajo14a/nikajos-packages/raw/main/x86_64/htop-3.2.2-1-x86_64.nikaj
sudo nikaj-pkg install htop-3.2.2-1-x86_64.nikaj
```

## 💿 NikajOS ISO

The complete system is available as a bootable ISO with all packages included.

### Features:
- ✅ **Bootable ISO** with GRUB bootloader
- ✅ **Login prompt** with agetty (Login: root, no password)
- ✅ **Network auto-configuration** via DHCP
- ✅ **Disk installer** - Install to hard drive with `nikaj-install /dev/sda`
- ✅ **Full disk management** - fdisk, mkfs.ext4, fsck (NOT just a live CD!)
- ✅ **Package manager** with automatic updates from GitHub
- ✅ **All 41 packages** pre-installed

### VirtualBox Testing:
1. Create VM (Linux, Other Linux 64-bit, 2GB RAM, 20GB disk)
2. Attach ISO as optical drive
3. Boot from ISO
4. Login as `root` (no password)
5. Install to disk: `nikaj-install /dev/sda`
6. Reboot and enjoy!

## 📊 Repository Statistics

- **Total Packages**: 41
- **Architecture**: x86_64
- **Repository Size**: ~75MB
- **Last Updated**: January 2, 2026

## 🔨 Package Categories

### Core System (15 packages)
**Essential system libraries and utilities**
- **glibc** 2.39-1 - GNU C Library (with libtinfo, libncurses, libz, libexpat)
- **bash** 5.2.21-1 - GNU Bourne Again Shell
- **coreutils** 9.5-1 - Basic file, shell and text utilities (ls, cat, cp, mv, etc.)
- **python3** 3.12.3-1 - Python programming language (for nikaj-pkg)
- **tar** 1.35-1 - Archive utility
- **gzip** 1.13-1 - Compression utility
- **grep** 3.11-1 - Pattern matching utilities
- **sed** 4.9-1 - Stream editor
- **gawk** 5.3.0-1 - GNU AWK implementation
- **findutils** 4.10.0-1 - Find utilities
- **diffutils** 3.10-1 - File comparison utilities
- **file** 5.45-1 - File type identification
- **patch** 2.7.6-1 - Apply patches to files
- **shadow** 4.14.6-1 - User management (useradd, passwd, login, su)
- **nikaj-pkg** 0.1.0-1 - Package manager with update support

### System Utilities (5 packages)
**System administration and maintenance**
- **util-linux** 2.39.3-1 - Essential utilities (mount, fdisk, blkid, **agetty**)
- **e2fsprogs** 1.47.0-1 - Ext2/3/4 filesystem tools (mkfs.ext4, fsck.ext4)
- **sysvinit** 3.08-1 - System V init system
- **procps-ng** 4.0.4-1 - Process utilities (ps, top, free, vmstat)
- **less** 643-1 - Text pager

### Compression Tools (3 packages)
**Additional compression utilities**
- **bzip2** 1.0.8-1 - bzip2 compression
- **xz** 5.6.0-1 - XZ compression
- **unzip** 6.0-1 - ZIP extraction

### Kernel & Bootloader (2 packages)
**Boot and kernel components**
- **linux** 6.6.13-1 - Linux kernel 6.6.13 with ext4, devtmpfs, networking
- **grub** 2.12-1 - GNU GRand Unified Bootloader

### Networking (7 packages)
**Network configuration and tools**
- **iproute2** 6.7.0-1 - Advanced networking (ip, ss, bridge, tc)
- **dhcpcd** 10.0.6-1 - DHCP client daemon
- **netconfig** 0.1.0-1 - Automatic network configuration at boot
- **wget** 1.21.4-1 - Network file downloader
- **net-tools** 2.10-1 - Classic network tools (ping, traceroute, netstat, ifconfig)
- **openssh** 9.6p1-1 - SSH client and server
- **curl** 8.5.0-1 - HTTP client and library

### Security & Encryption (2 packages)
**Cryptography and SSL/TLS**
- **openssl** 3.0.13-1 - SSL/TLS toolkit
- **ca-certificates** 20240203-1 - Root certificate bundle

### Development Tools (1 package)
**Version control and development**
- **git** 2.43.0-1 - Distributed version control system

### Text Editors (2 packages)
**Code and text editing**
- **nano** 7.2-1 - Simple terminal text editor
- **vim** 9.0.2189-1 - Vi IMproved text editor

### System Information & Monitoring (4 packages)
**System status and monitoring tools**
- **htop** 3.2.2-1 - Interactive process viewer
- **neofetch** 7.1.0-1 - System information tool with ASCII art
- **nikajOStatus** 0.1.0-1 - Custom NikajOS system status display
- **hello** 2.12-1 - GNU Hello (test package)

## 📝 Contributing

Want to submit a package? Open an issue or pull request with your `.nikaj` package file.

### Package Submission Guidelines:

1. Package must be built with `nikaj-build`
2. Must include valid PKGBUILD
3. Must be tested on NikajOS
4. Include SHA256 checksum

## 🔗 Links

- [NikajOS Project](https://github.com/nikajo14a/NikajOS)
- [Package Manager Documentation](https://github.com/nikajo14a/NikajOS/tree/main/docs)

## 📄 License

All packages are licensed according to their respective upstream licenses.

Repository infrastructure and tooling: Apache License 2.0  
Copyright (c) nikajo14™ (2018)2024-2025
