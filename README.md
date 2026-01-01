# NikajOS Package Repository

Official package repository for NikajOS - a custom Linux distribution based on Linux From Scratch.

## 📦 Available Packages

Browse packages in the `x86_64/` directory.

## 🚀 Usage

### Adding this repository to your NikajOS system:

```bash
# Download the repository database
sudo mkdir -p /etc/nikaj/repos.d
sudo wget https://raw.githubusercontent.com/nikajo14a/nikajos-packages/main/nikajos.db -O /etc/nikaj/repos.d/nikajos.db
```

### Installing packages:

```bash
# Download package
wget https://github.com/nikajo14a/nikajos-packages/raw/main/x86_64/hello-2.12-1-x86_64.nikaj

# Install
sudo nikaj-pkg install hello-2.12-1-x86_64.nikaj
```

## 📊 Repository Statistics

- **Total Packages**: 1
- **Architecture**: x86_64
- **Last Updated**: January 1, 2026

## 🔨 Package List

| Package | Version | Description |
|---------|---------|-------------|
| hello   | 2.12-1  | GNU Hello - prints a friendly greeting |

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
