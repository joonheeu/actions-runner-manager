# Security Policy

## Supported Versions

We actively support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability, please **do not** open a public issue. Instead, please report it via one of the following methods:

### Preferred Method

1. **Email**: Send a detailed report to [joonheeu@gmail.com] (replace with your actual email)
   - Include a description of the vulnerability
   - Include steps to reproduce the issue
   - Include potential impact assessment

2. **GitHub Security Advisory**: Use GitHub's private vulnerability reporting feature if available

### What to Include

When reporting a vulnerability, please include:

- **Description**: A clear description of the vulnerability
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Impact**: Potential impact of the vulnerability
- **Suggested Fix**: If you have a suggested fix, please include it
- **Proof of Concept**: If applicable, include a proof of concept

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Resolution**: Depends on severity and complexity

### Disclosure Policy

- We will acknowledge receipt of your vulnerability report
- We will keep you informed of our progress
- We will notify you when the vulnerability has been fixed
- We will credit you in the security advisory (if you wish)

## Security Best Practices

When using this script, please follow these security best practices:

1. **Runner Tokens**: Never commit Runner tokens to version control
2. **Environment**: Run the script in a secure environment
3. **Permissions**: Use appropriate file permissions
4. **Updates**: Keep the script updated to the latest version
5. **Docker**: Ensure Docker is properly secured and up to date

## Known Security Considerations

- **Runner Tokens**: Runner tokens are sensitive and should be treated as secrets
- **Docker Socket**: The script mounts Docker socket which requires appropriate permissions
- **Network Access**: Runners require network access to GitHub

## Security Updates

Security updates will be released as patches to supported versions. Please keep your installation updated.

---

**Note**: This security policy is subject to change. Please check back periodically for updates.

