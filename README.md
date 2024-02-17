![file-qG7xJYxXVw5KuElGjeBdXBhf](https://github.com/shadowdevnotreal/Bash-buddy/assets/43219706/a2dfbc79-ceb4-498a-9d1e-703072e169d5)


# BashBuddy

BashBuddy is a comprehensive tool designed to ensure your Bash scripts run smoothly across different environments by managing system commands and package dependencies. It supports a variety of package managers across Linux distributions and macOS.

## Support FOSS future development

<a href="https://www.buymeacoffee.com/notarealdev" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-blue.png" alt="Buy Me A Coffee" style="height: 40px !important;width: 145px !important;" ></a>


## Features

- Automatic detection of the operating system and the appropriate package manager.
- Verification of required system commands' availability.
- Installation of missing packages upon user confirmation.
- Support for `apt`, `dnf`/`yum`, `brew`, and `pacman` package managers.
- Friendly, optional humor for users of all distributions, including Arch Linux.

## Overview of BashBuddy Scripts

BashBuddy comes with three key scripts:

1. **Main Skeleton Script**: The backbone of BashBuddy, providing the fundamental logic for detecting package managers, checking for command availability, and managing package installations.

2. **Simulation Sample Script**: A demonstration tool that simulates BashBuddy's functionality. It showcases how command-to-package mappings are defined and utilized, making it an excellent educational resource.

3. **Fully Working Sample Script**: An expanded version of the Main Skeleton Script, including comprehensive command-to-package mappings and real installation capabilities. This script is intended for users who want to see BashBuddy in action, managing actual dependencies.


## Highly advised reading on usage instructions
***[WIKI Page](https://github.com/shadowdevnotreal/Bash-buddy/wiki/).***

## Installation

```bash
# Clone the repository
git clone https://github.com/shadowdevnotreal/Bash-Buddy.git

# Navigate to the BashBuddy directory
cd BashBuddy

# Make the scripts executable
chmod +x bashbuddy.sh
chmod +x sim_sample.sh
chmod +x full_sample.sh
```

## Usage

### Basic Usage with Main Skeleton Script

Run BashBuddy with a list of required commands. It will verify their presence and offer to install any that are missing.

```bash
./bashbuddy.sh curl wget tar
```

### Exploring with the Simulation Sample Script

Understand BashBuddy's logic without affecting your system by running the simulation script.

```bash
./sim_sample.sh
```

### Advanced Usage with Fully Working Sample Script

Use the fully working sample script for managing real dependencies. This script will perform actual checks and installations.

```bash
./full_sample.sh git nvim htop
```

## Contributing

We welcome contributions! Please follow these steps to contribute to BashBuddy:

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## Feedback and Support

For support, feedback, or suggestions, please open an issue in the GitHub repository. Your input helps make BashBuddy better for everyone.

### Final Steps

- Ensure you replace `https://github.com/shadowdevnotreal/Bash-Buddy.git` with the actual URL of your GitHub repository.
- Adjust any specific instructions or descriptions as needed based on your project's setup or requirements.
- If you have not already, consider adding a `LICENSE` file to clearly communicate how others can use or contribute to your project.

This README provides a comprehensive guide for users to get started, understand its features, and know how to contribute.

---

As always = TY 😊 
