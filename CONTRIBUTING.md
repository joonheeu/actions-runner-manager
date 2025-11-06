# Contributing to GitHub Actions Runner Manager

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## How to Contribute

### Reporting Bugs

1. **Check Existing Issues**: Before creating a new issue, check if the bug has already been reported
2. **Create an Issue**: Use the bug report template to provide:
   - Clear description of the bug
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, Bash version, Docker version)
   - Relevant error messages or logs

### Suggesting Features

1. **Check Existing Issues**: Check if the feature has already been suggested
2. **Create an Issue**: Use the feature request template to provide:
   - Clear description of the feature
   - Use case and motivation
   - Proposed implementation (if you have ideas)

### Pull Requests

1. **Fork the Repository**: Create your own fork of the repository
2. **Create a Branch**: Create a feature branch from `main`
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make Changes**: Implement your changes following the coding standards
4. **Test Your Changes**: Ensure your changes work correctly
5. **Commit Changes**: Write clear commit messages
   ```bash
   git commit -m "Add: description of your changes"
   ```
6. **Push to Your Fork**: Push your branch to your fork
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Create Pull Request**: Open a pull request with a clear description

## Coding Standards

### Bash Scripting

- Use `#!/bin/bash` shebang
- Follow shellcheck recommendations when possible
- Use meaningful variable names
- Add comments for complex logic
- Use consistent indentation (2 spaces)

### Code Style

- **Functions**: Use descriptive function names in snake_case
- **Variables**: Use descriptive variable names, prefer UPPER_CASE for constants
- **Comments**: Add comments for complex logic or non-obvious code
- **Error Handling**: Always handle errors appropriately

### Example

```bash
# Good
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed"
        return 1
    fi
}

# Avoid
cd() {
    if ! command -v docker &> /dev/null; then
        echo "err"
        exit
    fi
}
```

## Commit Message Guidelines

Use clear and descriptive commit messages:

- **Format**: `Type: Brief description`
- **Types**: `Add`, `Fix`, `Update`, `Remove`, `Refactor`, `Docs`, `Style`
- **Examples**:
  - `Add: Docker installation check function`
  - `Fix: Error handling in runner start function`
  - `Update: README with installation instructions`
  - `Docs: Add contributing guidelines`

## Testing

Before submitting a pull request:

1. **Test on Different Systems**: If possible, test on different OS (Linux, macOS)
2. **Test Edge Cases**: Test with empty lists, invalid inputs, etc.
3. **Test Error Handling**: Ensure errors are handled gracefully
4. **Check Shell Compatibility**: Ensure compatibility with Bash 4.0+

## Documentation

- Update README.md if you add new features
- Add comments to complex code sections
- Update this file if you change contribution guidelines

## Review Process

1. All pull requests will be reviewed
2. Reviewers may request changes
3. Address review comments promptly
4. Once approved, your PR will be merged

## Questions?

If you have questions about contributing, feel free to:
- Open an issue with the `question` label
- Contact the maintainers

Thank you for contributing! 🎉

