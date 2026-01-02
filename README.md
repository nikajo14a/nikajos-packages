# NikajOS Package Repository

Official package repository for NikajOS - a custom Linux distribution based on Linux From Scratch.

## 📦 Available Packages

Browse packages in the `x86_64/` directory.

## 🚀 Usage

### Adding this repository to your NikajOS system:

```bash
# Repository is automatically configured in NikajOS
# Database URL: https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/NikajOS%20Official%20Package%20Repository.db
```

### Installing packages:

```bash
# Download and install a package
wget https://github.com/nikajo14a/nikajos-packages/raw/main/x86_64/htop-3.2.2-1-x86_64.nikaj
sudo nikaj-pkg install htop-3.2.2-1-x86_64.nikaj

# Or if repository is configured, use update command
sudo nikaj-pkg update
```

### Checking for updates:

```bash
# Check and update all packages
sudo nikaj-pkg update

# Update specific packages
sudo nikaj-pkg update bash coreutils
```

## 📊 Repository Statistics

- **Total Packages**: 20
- **Architecture**: x86_64
- **Last Updated**: January 2, 2026

## 🔨 Package List

### Core System Packages

| Package | Version | Description |
|---------|---------|-------------|
| bash | 5.2.21-1 | GNU Bourne Again Shell |
| coreutils | 9.5-1 | Basic file, shell and text utilities |
| diffutils | 3.10-1 | Utility programs for comparing files |
| e2fsprogs | 1.47.0-1 | Ext2/3/4 filesystem utilities |
| file | 5.45-1 | File type identification utility |
| findutils | 4.10.0-1 | GNU utilities for finding files |
| gawk | 5.3.0-1 | GNU implementation of AWK |
| grep | 3.11-1 | Pattern matching utilities |
| patch | 2.7.6-1 | Utility to apply patches to files |
| sed | 4.9-1 | Stream editor for filtering text |
| sysvinit | 3.08-1 | System V initialization program |
| util-linux | 2.39.3-1 | System utilities (mount, fdisk, etc.) |

### Kernel & Bootloader

| Package | Version | Description |
|---------|---------|-------------|
| linux | 6.6.13-1 | Linux kernel with ext4, networking support |
| grub | 2.12-1 | GNU GRand Unified Bootloader |

### Applications & Utilities

| Package | Version | Description |
|---------|---------|-------------|
| hello | 2.12-1 | GNU Hello - prints a friendly greeting |
| htop | 3.2.2-1 | Interactive process viewer |
| nano | 7.2-1 | Simple text editor |
| neofetch | 7.1.0-1 | System information tool |
| nikajOStatus | 0.1.0-1 | System status display with ASCII art |
| vim | 9.0.2189-1 | Vi IMproved text editor |

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
