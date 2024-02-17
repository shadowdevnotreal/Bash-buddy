#!/bin/bash

# Detect the package manager used by the system.
detect_package_manager() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt > /dev/null; then
      PACKAGE_MANAGER="apt"
    elif command -v dnf > /dev/null; then
      PACKAGE_MANAGER="dnf"
    elif command -v yum > /dev/null; then
      PACKAGE_MANAGER="yum"
    elif command -v pacman > /dev/null; then
      PACKAGE_MANAGER="pacman"
      echo "Ah, an Arch user, I see. Have you checked the Wiki yet today?"
    else
      echo "Unsupported Linux distribution. Please install dependencies manually."
      exit 1
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew > /dev/null; then
      PACKAGE_MANAGER="brew"
    else
      echo "Homebrew not found. Please install Homebrew for macOS."
      exit 1
    fi
  else
    echo "Unsupported operating system."
    exit 1
  fi
}

# Check for the required commands and identify any that are missing.
check_required_commands() {
  local missing_commands=()
  for cmd in "$@"; do
    if ! command -v "$cmd" &> /dev/null; then
      missing_commands+=("$cmd")
    fi
  done

  if [ ${#missing_commands[@]} -ne 0 ]; then
    echo "Missing commands: ${missing_commands[*]}"
    return 1
  else
    echo "All required commands are installed."
    return 0
  fi
}

# Extended command-to-package mapping.
declare -A command_to_package=(
    [git]="git"
    [curl]="curl"
    [wget]="wget"
    [nvim]="neovim"
    [htop]="htop"
    [tar]="tar"
    [make]="build-essential" # For Debian/Ubuntu, change as needed for other distros
)

# Attempt to install packages for the missing commands.
install_packages() {
    detect_package_manager
    for cmd in "$@"; do
        package=${command_to_package[$cmd]}
        if [[ -z "$package" ]]; then
            echo "No known package for command '$cmd'. Please install it manually."
            continue
        fi
        
        echo "Attempting to install $package..."
        case $PACKAGE_MANAGER in
            apt) sudo apt install -y $package ;;
            dnf) sudo dnf install -y $package ;;
            yum) sudo yum install -y $package ;;
            pacman) sudo pacman -S --noconfirm $package ;;
            brew) brew install $package ;;
            *)
                echo "Unsupported package manager: $PACKAGE_MANAGER"
                return 1
                ;;
        esac
    done
}

# Confirm with the user before proceeding with the installation.
confirm_installation() {
    echo "The following packages are missing and need to be installed: $@"
    read -p "Do you want to proceed with the installation? (y/N) " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        install_packages "$@"
    else
        echo "Installation aborted by user."
        exit 1
    fi
}

# Main function to orchestrate the script operations.
main() {
    local missing_commands=("$@")
    if check_required_commands "${missing_commands[@]}"; then
        echo "All required commands are installed."
    else
        confirm_installation "${missing_commands[@]}"
    fi
}

# Execute the main function with command line arguments for required commands.
main "$@"
