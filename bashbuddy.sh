#!/bin/bash

# Enable strict error handling
set -euo pipefail

#############################################################################
# BashBuddy - Cross-Platform Dependency Management Skeleton Script
#############################################################################
# This is a template script for managing dependencies across different
# operating systems and package managers. Customize the command_to_package
# mapping below for your specific project needs.
#
# Supported platforms:
# - Linux (apt, dnf/yum, pacman)
# - macOS (brew)
# - Windows (Git Bash/WSL with apt, Chocolatey, Scoop)
#############################################################################

# CUSTOMIZE THIS: Map commands to their package names
# Add or modify entries based on your project's dependencies
declare -A command_to_package=(
    [curl]="curl"
    [wget]="wget"
    [tar]="tar"
    # Add more dependencies here, e.g.:
    # [git]="git"
    # [python3]="python3"
)

# Detect the package manager used by the system.
detect_package_manager() {
  # Check for Windows environments first
  if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    # Git Bash / MSYS2 / Cygwin on Windows
    if command -v pacman > /dev/null 2>&1; then
      PACKAGE_MANAGER="pacman"
      echo "Detected MSYS2 on Windows"
    elif command -v choco > /dev/null 2>&1; then
      PACKAGE_MANAGER="choco"
      echo "Detected Chocolatey on Windows"
    elif command -v scoop > /dev/null 2>&1; then
      PACKAGE_MANAGER="scoop"
      echo "Detected Scoop on Windows"
    else
      echo "No supported Windows package manager found (Chocolatey, Scoop, or MSYS2)."
      echo "Please install one: https://chocolatey.org/ or https://scoop.sh/"
      exit 1
    fi
  # Check for WSL (appears as linux-gnu but has Windows interop)
  elif grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    echo "Detected WSL (Windows Subsystem for Linux)"
    if command -v apt > /dev/null 2>&1; then
      PACKAGE_MANAGER="apt"
    else
      echo "Unsupported WSL distribution. Please install dependencies manually."
      exit 1
    fi
  # Standard Linux distributions
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt > /dev/null 2>&1; then
      PACKAGE_MANAGER="apt"
    elif command -v dnf > /dev/null 2>&1; then
      PACKAGE_MANAGER="dnf"
    elif command -v yum > /dev/null 2>&1; then
      PACKAGE_MANAGER="yum"
    elif command -v pacman > /dev/null 2>&1; then
      PACKAGE_MANAGER="pacman"
      echo "Ah, an Arch user, I see. Have you checked the Wiki yet today?"
    else
      echo "Unsupported Linux distribution. Please install dependencies manually."
      exit 1
    fi
  # macOS
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew > /dev/null 2>&1; then
      PACKAGE_MANAGER="brew"
    else
      echo "Homebrew not found. Please install Homebrew for macOS."
      echo "Visit: https://brew.sh/"
      exit 1
    fi
  else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
  fi
}

# Check for the required commands and identify any that are missing.
# Returns missing commands via stdout (one per line) for capture
check_required_commands() {
  local missing=()
  for cmd in "$@"; do
    if ! command -v "$cmd" &> /dev/null; then
      missing+=("$cmd")
    fi
  done

  # Output missing commands to stdout (for capture)
  if [ ${#missing[@]} -ne 0 ]; then
    printf '%s\n' "${missing[@]}"
    return 1
  else
    return 0
  fi
}

# Update package manager index (for package managers that need it)
update_package_index() {
    case "$PACKAGE_MANAGER" in
        apt)
            echo "Updating package index..."
            sudo apt update || echo "Warning: Failed to update package index"
            ;;
        # dnf, yum, pacman, brew, choco, scoop auto-update on install
    esac
}

# Attempt to install packages for the missing commands.
install_packages() {
    local failed_packages=()

    # Update package index if needed
    update_package_index

    for cmd in "$@"; do
        package="${command_to_package[$cmd]}"
        if [[ -z "$package" ]]; then
            echo "No known package for command '$cmd'. Please install it manually."
            failed_packages+=("$cmd")
            continue
        fi

        echo "Attempting to install '$package' for command '$cmd'..."

        # Install package based on package manager
        case "$PACKAGE_MANAGER" in
            apt)
                if ! sudo apt install -y "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            dnf)
                if ! sudo dnf install -y "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            yum)
                if ! sudo yum install -y "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            pacman)
                if ! sudo pacman -S --noconfirm "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            brew)
                if ! brew install "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            choco)
                if ! choco install -y "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            scoop)
                if ! scoop install "$package"; then
                    failed_packages+=("$cmd")
                fi
                ;;
            *)
                echo "Unsupported package manager: $PACKAGE_MANAGER"
                return 1
                ;;
        esac
    done

    # Report any failures
    if [ ${#failed_packages[@]} -ne 0 ]; then
        echo "Failed to install packages for: ${failed_packages[*]}"
        return 1
    fi

    return 0
}

# Confirm with the user before proceeding with the installation.
confirm_installation() {
    echo "The following commands are missing and need to be installed: $*"
    read -p "Do you want to proceed with the installation? (y/N) " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        echo "Installation aborted by user."
        return 1
    fi
}

# Main function to orchestrate the script operations.
# CUSTOMIZE THIS: Change the required commands list to match your needs
main() {
    echo "BashBuddy - Checking dependencies..."

    # Detect what package manager we're using
    detect_package_manager

    # CUSTOMIZE: List your required commands here
    local required_commands=(curl wget tar)

    # Check which commands are missing
    local missing_commands=()
    mapfile -t missing_commands < <(check_required_commands "${required_commands[@]}")

    if [ ${#missing_commands[@]} -gt 0 ]; then
        # Some commands are missing
        if confirm_installation "${missing_commands[@]}"; then
            if install_packages "${missing_commands[@]}"; then
                echo "Successfully installed all missing packages!"

                # Verify installation
                if check_required_commands "${required_commands[@]}" > /dev/null 2>&1; then
                    echo "All required commands are now available."
                else
                    echo "Warning: Some commands may still be unavailable. Please verify."
                    exit 1
                fi
            else
                echo "Some packages failed to install. Please install them manually."
                exit 1
            fi
        else
            echo "Installation aborted. Required commands are missing."
            exit 1
        fi
    else
        echo "All required commands are installed. You're good to go!"
    fi
}

# Starting point
main
