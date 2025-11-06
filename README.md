# GitHub Actions Runner Manager

An interactive Bash script to easily manage GitHub Actions Runners using Docker containers.

## Features

- 🚀 **Interactive Interface**: Manage Runners easily with keyboard arrow keys
- 📦 **Docker-based**: Run Runners using the `myoung34/github-runner` image
- 🔄 **Lifecycle Management**: Create, start, stop, restart, and delete Runners
- 📊 **Status Monitoring**: Check Runner status and view logs
- 🏷️ **Label Management**: Organize and manage Runners with custom labels
- 🔄 **Auto Update**: Automatic update check and easy manual update via `--update` flag

## Requirements

- **Bash** 4.0 or higher
- **Docker** installed and running
- **less** (optional, for log viewer)

### Check Docker Installation

```bash
docker --version
```

If Docker is not installed, please refer to the [official Docker documentation](https://docs.docker.com/get-docker/) for installation instructions.

## Installation

### Quick Install (Recommended)

Install using wget or curl:

```bash
# Using wget
wget -qO- https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/install.sh | bash

# Or using curl
curl -fsSL https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/install.sh | bash
```

The installation script will:
- Download `runner-manager.sh` to `~/.local/bin/`
- Make it executable
- Create a symlink `runner-manager` (without .sh extension) for convenience
- Optionally add it to your PATH

After installation, you can run the script from anywhere:
```bash
# Using the symlink (recommended, no extension)
runner-manager

# Or using the full filename
runner-manager.sh
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/joonheeu/actions-runner-manager.sh.git
cd actions-runner-manager.sh
```

2. Make the script executable:
```bash
chmod +x runner-manager.sh
```

3. Run directly:
```bash
./runner-manager.sh
```

### Direct Download

You can also download the script directly (curl recommended):

```bash
# Using curl (Recommended - works on most systems)
curl -fsSL https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/runner-manager.sh -o runner-manager.sh
chmod +x runner-manager.sh
./runner-manager.sh

# Or using wget (if HTTPS support is available)
wget https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/runner-manager.sh
chmod +x runner-manager.sh
./runner-manager.sh
```

> **Note**: If wget shows "HTTPS support not compiled in" error, use curl instead or use the installation script above.

## Usage

### Basic Execution

```bash
./runner-manager.sh
```

### Command Line Options

```bash
# Show version
runner-manager --version
# or
runner-manager -v

# Update to latest version
runner-manager --update
# or
runner-manager -u

# Show help
runner-manager --help
# or
runner-manager -h
```

### Automatic Update Check

The script automatically checks for updates when you run it. If a new version is available, you'll be prompted to update.

### Manual Update

To manually check and update:

```bash
runner-manager --update
```

This will:
- Check for the latest version on GitHub
- Download and install the update if available
- Create a backup of your current version (`.backup` file)
- Exit so you can restart with the new version

### Interface Guide

After running the script, an interactive menu will be displayed:

- **↑/↓**: Navigate through the Runner list
- **←/→**: Change actions for the selected Runner (start, stop, restart, logs, info, delete)
- **Enter/Space**: Execute the selected action
- **q**: Quit the program

### Adding a Runner

1. Select "Add New Runner" from the menu
2. Enter the following information:
   - **Service name**: kebab-case format (e.g., `my-service`)
   - **RUNNER_NAME**: Runner name (default: `{service-name}-runner-1`)
   - **GitHub Organization**: GitHub organization or username
   - **GitHub Repository**: Repository name
   - **RUNNER_TOKEN**: Runner registration token issued by GitHub
   - **RUNNER_LABELS**: Runner labels (default: `self-hosted,linux,x64,docker,{service-name}`)
   - **RUNNER_WORKDIR**: Working directory (default: `/tmp/github-runner`)

### How to Obtain Runner Token

1. Navigate to your GitHub repository or organization settings
2. Go to **Settings** → **Actions** → **Runners** → **New self-hosted runner**
3. Select your operating system and copy the displayed token

> ⚠️ **Security Warning**: Runner tokens are sensitive information. Be careful not to expose tokens.

## Examples

### Create and Start a Runner

```bash
runner-manager
# Select "Add New Runner" from the menu
# Enter required information and confirm
```

### Check Runner Status

```bash
runner-manager
# Select Runner → → (select info action) → Enter
```

### View Runner Logs

```bash
runner-manager
# Select Runner → → → (select logs action) → Enter
```

## Project Structure

```
actions-runner-manager.sh/
├── runner-manager.sh                    # Main script
├── install.sh                     # Installation script
├── README.md                      # This file
├── LICENSE                        # License
├── SECURITY.md                    # Security policy
├── CONTRIBUTING.md                # Contributing guidelines
├── .gitignore                     # Git ignore file
└── .github/
    ├── ISSUE_TEMPLATE/            # Issue templates
    │   ├── bug_report.md
    │   └── feature_request.md
    └── pull_request_template.md   # PR template
```

## Troubleshooting

### Docker is Not Running

```bash
# Check Docker service status
sudo systemctl status docker  # Linux
# or
docker info
```

### Runner Won't Start

1. Check Runner logs:
   ```bash
   docker logs runners_{service-name}
   ```

2. Verify token validity:
   - Check if the token has expired on GitHub
   - Verify repository/organization permissions

### less is Not Installed

The log viewer feature requires `less`:

```bash
# Ubuntu/Debian
sudo apt-get install less

# CentOS/RHEL
sudo yum install less

# macOS
brew install less
```

### wget HTTPS Support Error

If you encounter "HTTPS support not compiled in" error when using wget:

**Solution 1: Use curl instead (Recommended)**
```bash
curl -fsSL https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/install.sh | bash
```

**Solution 2: Use the installation script (Recommended)**
The installation script automatically detects and uses curl if available:
```bash
# This will use curl if wget doesn't support HTTPS
curl -fsSL https://raw.githubusercontent.com/joonheeu/actions-runner-manager.sh/main/install.sh | bash
```

**Solution 3: Install curl**
```bash
# Ubuntu/Debian
sudo apt-get install curl

# CentOS/RHEL
sudo yum install curl

# Alpine
sudo apk add curl
```

**Solution 4: Update wget with HTTPS support**
```bash
# Ubuntu/Debian
sudo apt-get install wget

# CentOS/RHEL
sudo yum install wget

# Or compile wget with OpenSSL support
```

## Contributing

Bug reports, feature suggestions, and Pull Requests are welcome!

Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Security

If you discover a security vulnerability, please **do not** open a public issue. Instead, please refer to our [Security Policy](SECURITY.md) for details on how to report it.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## References

- [GitHub Actions Runner Documentation](https://docs.github.com/en/actions/hosting-your-own-runners)
- [myoung34/github-runner Docker Image](https://github.com/myoung34/docker-github-runner)

## Contributors

- [Joonheeu](https://github.com/joonheeu)

---

**Note**: This script is a tool for managing GitHub Actions Runners. Please use with caution as it handles sensitive information such as Runner tokens.
