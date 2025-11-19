![file-qG7xJYxXVw5KuElGjeBdXBhf](https://github.com/shadowdevnotreal/Bash-buddy/assets/43219706/a2dfbc79-ceb4-498a-9d1e-703072e169d5)

<div align="center">

# 🛠️ BashBuddy

### Cross-Platform Dependency Management for Bash Scripts

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS%20%7C%20Windows-lightgrey.svg)](https://github.com/shadowdevnotreal/Bash-buddy)

**Never worry about missing dependencies again!**

BashBuddy automatically detects your system, checks for required commands, and installs missing packages across any platform.

[Features](#-features) • [Installation](#-installation) • [Usage](#-usage) • [Documentation](#-documentation)

---

</div>

## ✨ Features

<table>
<tr>
<td width="50%">

### 🔍 Smart Detection
- Automatic OS and package manager detection
- Cross-platform support out of the box
- Intelligent fallback mechanisms

</td>
<td width="50%">

### 🔒 Safe & Reliable
- Strict error handling (`set -euo pipefail`)
- User confirmation before installations
- Post-installation verification

</td>
</tr>
<tr>
<td width="50%">

### 📦 Wide Compatibility
- Linux: `apt`, `dnf`, `yum`, `pacman`
- macOS: `brew`
- Windows: `choco`, `scoop`, MSYS2, WSL

</td>
<td width="50%">

### 🎯 Developer Friendly
- Template-based skeleton script
- Easy to customize for your project
- Comprehensive inline documentation

</td>
</tr>
</table>

## 🌍 Platform Support

| Platform | Package Managers | Status |
|----------|-----------------|--------|
| 🐧 **Linux** | apt, dnf, yum, pacman | ✅ Full Support |
| 🍎 **macOS** | Homebrew (brew) | ✅ Full Support |
| 🪟 **Windows** | Chocolatey, Scoop, MSYS2 | ✅ Full Support |
| 🐧 **WSL** | apt (Ubuntu/Debian) | ✅ Full Support |
| 🔧 **Cygwin** | Auto-detection | ✅ Supported |

## 💖 Support FOSS Development

<a href="https://www.buymeacoffee.com/diatasso" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Book" style="height: 40px !important;width: 145px !important;" ></a>

## 📚 Overview of BashBuddy Scripts

BashBuddy provides three scripts tailored for different use cases:

<table>
<tr>
<th>Script</th>
<th>Purpose</th>
<th>Use Case</th>
</tr>
<tr>
<td><code>bashbuddy.sh</code></td>
<td>🏗️ <strong>Main Skeleton</strong></td>
<td>Template for your own projects. Copy and customize the dependency list for your needs.</td>
</tr>
<tr>
<td><code>full_sample.sh</code></td>
<td>🎯 <strong>Working Example</strong></td>
<td>Full-featured implementation with extended package mappings. Use as a reference or standalone tool.</td>
</tr>
<tr>
<td><code>sim_sample.sh</code></td>
<td>🎓 <strong>Educational Demo</strong></td>
<td>Safe simulation that shows how mappings work without installing anything.</td>
</tr>
</table>

## 📖 Documentation

For detailed usage instructions, advanced features, and best practices, visit our:

**📘 [Wiki Page](https://github.com/shadowdevnotreal/Bash-buddy/wiki/)** — Comprehensive guides and tutorials

---

## 🚀 Installation

### Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/shadowdevnotreal/Bash-buddy.git

# 2. Navigate to the directory
cd Bash-buddy

# 3. Make scripts executable
chmod +x *.sh
```

### Single Command Installation

```bash
curl -fsSL https://raw.githubusercontent.com/shadowdevnotreal/Bash-buddy/main/full_sample.sh | bash
```

---

## 💻 Usage

### 🏗️ Using the Skeleton Script (For Your Projects)

The skeleton script is designed to be copied into your own projects and customized:

```bash
# Run with default dependencies (curl, wget, tar)
./bashbuddy.sh
```

**To customize for your project:**

1. Open `bashbuddy.sh` in your editor
2. Modify the `command_to_package` array on line 21:
```bash
declare -A command_to_package=(
    [git]="git"
    [docker]="docker"
    [python3]="python3"
    # Add your dependencies here
)
```
3. Update the `required_commands` array in the `main()` function (line 209)

### 🎯 Using the Full Sample (Standalone Tool)

The full sample accepts commands as arguments and installs them:

```bash
# Check and install specific tools
./full_sample.sh git nvim htop

# Check multiple dependencies at once
./full_sample.sh curl wget docker nodejs python3
```

**Example Output:**
```
BashBuddy - Checking dependencies...
Detected WSL (Windows Subsystem for Linux)
Missing commands: nvim htop
Do you want to proceed with the installation? (y/N) y
Updating package index...
Attempting to install 'neovim' for command 'nvim'...
✓ Successfully installed all missing packages!
All required commands are now available.
```

### 🎓 Exploring with Simulation

Safe demonstration without installing anything:

```bash
./sim_sample.sh
```

This displays how command-to-package mappings work without making system changes.

---

## 🎯 Use Cases

### For Script Authors
```bash
#!/bin/bash
# your-awesome-script.sh

# Source BashBuddy at the start of your script
source ./bashbuddy.sh

# Your script logic here - all dependencies guaranteed!
curl https://api.example.com/data | jq '.results'
```

### For DevOps & CI/CD
```yaml
# .github/workflows/build.yml
- name: Install dependencies
  run: ./full_sample.sh make gcc docker
```

### For Development Environments
```bash
# Setup script for your team
./full_sample.sh git node python3 docker
```

---

## 🤝 Contributing

We love contributions! Here's how you can help:

### Ways to Contribute
- 🐛 **Report bugs** — Open an issue with details
- 💡 **Suggest features** — We're always looking for ideas
- 📝 **Improve docs** — Help others understand BashBuddy better
- 🔧 **Submit PRs** — Add support for new package managers

### Contribution Workflow

1. **Fork** the repository
2. **Create** a feature branch
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. **Commit** your changes
   ```bash
   git commit -m 'Add AmazingFeature'
   ```
4. **Push** to your branch
   ```bash
   git push origin feature/AmazingFeature
   ```
5. **Open** a Pull Request

---

## 🔧 Troubleshooting

<details>
<summary><strong>Script fails with "Unsupported package manager"</strong></summary>

Make sure you have a supported package manager installed:
- Linux: `apt`, `dnf`, `yum`, or `pacman`
- macOS: Install Homebrew from https://brew.sh
- Windows: Install Chocolatey (https://chocolatey.org) or Scoop (https://scoop.sh)
</details>

<details>
<summary><strong>Permission denied errors</strong></summary>

Make sure the scripts are executable:
```bash
chmod +x bashbuddy.sh full_sample.sh sim_sample.sh
```
</details>

<details>
<summary><strong>WSL not detected correctly</strong></summary>

If you're on WSL but detection fails, check that `/proc/version` exists and contains "microsoft" or "WSL":
```bash
cat /proc/version
```
</details>

<details>
<summary><strong>Package installation fails</strong></summary>

Common causes:
- Update your package manager index first (e.g., `sudo apt update`)
- Check your internet connection
- Verify you have sudo permissions (for Linux package managers)
- Check if the package name is correct for your distro
</details>

---

## 📋 FAQ

**Q: Can I use this in production scripts?**
A: Absolutely! BashBuddy uses strict error handling and is designed for production use.

**Q: Does it require root/sudo access?**
A: Only for installing packages with system package managers (apt, dnf, yum, pacman). Homebrew, Scoop, and user-level installs don't require sudo.

**Q: Can I add custom package sources/PPAs?**
A: Yes! Extend the `install_packages()` function to add custom repositories before installation.

**Q: What if a command has different package names across distros?**
A: Use the `get_package_name()` function pattern from `full_sample.sh` to map commands to distro-specific packages.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🌟 Show Your Support

If BashBuddy helped you, consider:
- ⭐ **Starring** this repository
- 🐦 **Sharing** with your network
- ☕ **Buying me a coffee** (button at the top)

---

<div align="center">

**Made with ❤️ for the open source community**

[Report Bug](https://github.com/shadowdevnotreal/Bash-buddy/issues) • [Request Feature](https://github.com/shadowdevnotreal/Bash-buddy/issues) • [Wiki](https://github.com/shadowdevnotreal/Bash-buddy/wiki)

</div>
