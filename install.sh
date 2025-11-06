#!/bin/bash

# GitHub Actions Runner Manager - Installation Script
# Version: 1.0.0
# This script downloads and installs the runner-manager.sh script

# set -e removed to allow better error handling

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://raw.githubusercontent.com"
REPO_OWNER="joonheeu"
REPO_NAME="actions-runner-manager"
BRANCH="main"
SCRIPT_NAME="runner-manager.sh"
INSTALL_DIR="${HOME}/.local/bin"
INSTALL_PATH="${INSTALL_DIR}/${SCRIPT_NAME}"

# Detect download tool
detect_download_tool() {
    if command -v curl &> /dev/null; then
        echo "curl"
    elif command -v wget &> /dev/null; then
        echo "wget"
    else
        echo ""
    fi
}

# Download file
download_file() {
    local url=$1
    local output=$2
    local tool=$(detect_download_tool)
    
    if [ -z "$tool" ]; then
        echo -e "${RED}Error: Neither curl nor wget is installed.${NC}"
        echo -e "${YELLOW}Please install curl or wget and try again.${NC}"
        exit 1
    fi
    
    echo -e "${CYAN}Downloading from: ${url}${NC}"
    
    if [ "$tool" = "curl" ]; then
        if ! curl -fsSL "$url" -o "$output"; then
            echo -e "${RED}Error: Failed to download from ${url}${NC}"
            return 1
        fi
    elif [ "$tool" = "wget" ]; then
        if ! wget -q "$url" -O "$output"; then
            echo -e "${RED}Error: Failed to download from ${url}${NC}"
            return 1
        fi
    fi
    return 0
}

# Main installation
main() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}  GitHub Actions Runner Manager${NC}"
    echo -e "${BLUE}  Installation Script${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    
    # Check if script already exists
    if [ -f "$INSTALL_PATH" ]; then
        echo -e "${YELLOW}Warning: ${SCRIPT_NAME} already exists at ${INSTALL_PATH}${NC}"
        echo -e "${CYAN}Removing existing file...${NC}"
        rm -f "$INSTALL_PATH"
        echo -e "${GREEN}✓ Existing file removed${NC}"
    fi
    
    # Create install directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo -e "${CYAN}Creating directory: ${INSTALL_DIR}${NC}"
        mkdir -p "$INSTALL_DIR"
    fi
    
    # Get latest release tag
    echo -e "${CYAN}Checking for latest version...${NC}"
    local tool=$(detect_download_tool)
    local latest_tag=""
    local api_response=""
    
    if [ "$tool" = "curl" ]; then
        api_response=$(curl -fsSL -H "Accept: application/vnd.github.v3+json" -H "User-Agent: install.sh/1.0.0" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest" 2>/dev/null)
        if [ $? -eq 0 ] && [ -n "$api_response" ]; then
            # Check if response contains error message
            if ! echo "$api_response" | grep -q '"message"'; then
                latest_tag=$(echo "$api_response" | grep -o '"tag_name"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4)
            fi
        fi
    elif [ "$tool" = "wget" ]; then
        api_response=$(wget -qO- --header="Accept: application/vnd.github.v3+json" --header="User-Agent: install.sh/1.0.0" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases/latest" 2>/dev/null)
        if [ $? -eq 0 ] && [ -n "$api_response" ]; then
            # Check if response contains error message
            if ! echo "$api_response" | grep -q '"message"'; then
                latest_tag=$(echo "$api_response" | grep -o '"tag_name"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4)
            fi
        fi
    fi
    
    # Use latest tag if available, otherwise fall back to main branch
    if [ -n "$latest_tag" ]; then
        SCRIPT_URL="${REPO_URL}/${REPO_OWNER}/${REPO_NAME}/${latest_tag}/${SCRIPT_NAME}"
        echo -e "${GREEN}Downloading ${SCRIPT_NAME} from ${latest_tag}...${NC}"
    else
        SCRIPT_URL="${REPO_URL}/${REPO_OWNER}/${REPO_NAME}/${BRANCH}/${SCRIPT_NAME}"
        echo -e "${YELLOW}Could not determine latest version, using main branch${NC}"
        echo -e "${GREEN}Downloading ${SCRIPT_NAME}...${NC}"
    fi
    
    if download_file "$SCRIPT_URL" "$INSTALL_PATH"; then
        echo -e "${GREEN}✓ Downloaded successfully${NC}"
    else
        echo -e "${RED}✗ Download failed${NC}"
        echo -e "${YELLOW}Please check your internet connection and try again.${NC}"
        exit 1
    fi
    
    # Make script executable
    echo -e "${GREEN}Setting executable permissions...${NC}"
    chmod +x "$INSTALL_PATH"
    echo -e "${GREEN}✓ Permissions set${NC}"
    
    # Create symlink without .sh extension for convenience
    local symlink_name="runner-manager"
    local symlink_path="${INSTALL_DIR}/${symlink_name}"
    
    if [ -L "$symlink_path" ]; then
        # Remove existing symlink if it exists
        rm "$symlink_path"
    fi
    
    echo -e "${GREEN}Creating symlink: ${symlink_name}${NC}"
    ln -s "$INSTALL_PATH" "$symlink_path"
    echo -e "${GREEN}✓ Symlink created${NC}"
    
    # Check if install directory is in PATH
    if [[ ":$PATH:" != *":${INSTALL_DIR}:"* ]]; then
        echo ""
        echo -e "${YELLOW}Warning: ${INSTALL_DIR} is not in your PATH${NC}"
        echo -e "${YELLOW}Add the following to your shell configuration file (~/.bashrc, ~/.zshrc, etc.):${NC}"
        echo ""
        echo -e "${CYAN}export PATH=\"\${PATH}:${INSTALL_DIR}\"${NC}"
        echo ""
        read -p "Add to PATH automatically? (y/N): " ADD_TO_PATH
        
        if [[ "$ADD_TO_PATH" =~ ^[Yy]$ ]]; then
            SHELL_CONFIG=""
            if [ -n "$ZSH_VERSION" ]; then
                SHELL_CONFIG="${HOME}/.zshrc"
            elif [ -n "$BASH_VERSION" ]; then
                SHELL_CONFIG="${HOME}/.bashrc"
            fi
            
            if [ -n "$SHELL_CONFIG" ]; then
                if ! grep -q "${INSTALL_DIR}" "$SHELL_CONFIG" 2>/dev/null; then
                    echo "" >> "$SHELL_CONFIG"
                    echo "# GitHub Actions Runner Manager" >> "$SHELL_CONFIG"
                    echo "export PATH=\"\${PATH}:${INSTALL_DIR}\"" >> "$SHELL_CONFIG"
                    echo -e "${GREEN}✓ Added to ${SHELL_CONFIG}${NC}"
                    echo -e "${YELLOW}Please run: source ${SHELL_CONFIG}${NC}"
                else
                    echo -e "${YELLOW}Already in ${SHELL_CONFIG}${NC}"
                fi
            else
                echo -e "${YELLOW}Could not detect shell configuration file${NC}"
            fi
        fi
    fi
    
    # Get installed version
    local installed_version=""
    if [ -f "$INSTALL_PATH" ]; then
        installed_version=$(grep -o 'SCRIPT_VERSION="[^"]*"' "$INSTALL_PATH" 2>/dev/null | sed 's/SCRIPT_VERSION="//' | sed 's/"//')
    fi
    
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    
    if [ -n "$installed_version" ]; then
        echo -e "${GREEN}Installed version: ${BOLD}v${installed_version}${NC}"
        echo ""
    fi
    
    # Check if script is in PATH
    if command -v "$symlink_name" &> /dev/null || command -v "$SCRIPT_NAME" &> /dev/null; then
        echo -e "${GREEN}✓ Script is available in PATH${NC}"
        echo ""
        echo -e "${BOLD}Usage examples:${NC}"
        echo -e "  ${CYAN}${symlink_name}${NC}                    # Start interactive menu"
        echo -e "  ${CYAN}${symlink_name} --update${NC}          # Update to latest version"
        echo -e "  ${CYAN}${symlink_name} --version${NC}        # Show version"
        echo -e "  ${CYAN}${symlink_name} --help${NC}            # Show help"
    else
        echo -e "${YELLOW}Note: You may need to restart your terminal or run:${NC}"
        echo -e "${CYAN}  export PATH=\"\${PATH}:${INSTALL_DIR}\"${NC}"
        echo ""
        echo -e "${BOLD}Usage examples:${NC}"
        echo -e "  ${CYAN}${symlink_name}${NC}                    # Start interactive menu"
        echo -e "  ${CYAN}${symlink_name} --update${NC}          # Update to latest version"
        echo -e "  ${CYAN}${symlink_name} --version${NC}        # Show version"
        echo -e "  ${CYAN}${symlink_name} --help${NC}            # Show help"
    fi
    echo ""
}

# Run installation
main

