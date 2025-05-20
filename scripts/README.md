# Git Security Hooks

This directory contains scripts to prevent accidental commits of secrets and sensitive data.
These scripts are designed to be simple, minimalistic, and avoid unnecessary dependencies.

## What these scripts do

1. **Prevent committing to main/master branch directly**
   - Forces you to use feature branches and pull requests
   - Encourages code review and quality control

2. **Block .env files from being committed**
   - Only blocks exact `.env` files (not `.env.example` or other variants)
   - Environment files often contain API keys and secrets
   - Use `.env.example` with empty values (not placeholders) as a template

3. **Detect potential API keys in any committed file**
   - Looks for patterns that might be API keys (20+ character alphanumeric strings)
   - Note: This is a basic check and may have false positives on things like URLs
   - You can override with `git commit --no-verify` if needed

## How to use

### Local project setup

```bash
# Install only in this project
make setup-secrets
```

### Global setup (for all repositories)

```bash
# Install globally (recommended)
make setup-global-hooks

# After running this command, you need to do this in each existing repository
cd /path/to/existing/repo
git init  # This applies the template, doesn't reinitialize
```

## How it works

- The scripts use Git hooks to check files before they're committed
- No external dependencies required, just plain Bash
- All logic is in version-controlled scripts for transparency
- The global setup affects all repositories on your machine

## Files in this directory

- **pre-commit-check.sh**: The main script that contains all checks
  - Called by Git hooks before each commit
  - Blocks secrets, sensitive files, and direct commits to main/master

- **setup-global-hooks.sh**: Script to install hooks globally
  - Sets up Git templates that will be used for all repositories
  - Only needs to be run once on your machine

## Maintenance

- These scripts are deliberately simple and minimal
- No need to make the scripts executable - they are called with `bash`
- Keep the logic in these files to avoid fragmentation
