# Git Security Hooks

This directory contains scripts to prevent accidental commits of secrets and sensitive data.

## What these scripts do:

1. **Prevent committing to main/master branch directly**
   - Forces you to use feature branches and pull requests

2. **Block .env files from being committed**
   - Environment files often contain API keys and secrets
   - Use `.env.example` without sensitive data as a template instead

3. **Detect potential API keys in any committed file**
   - Looks for patterns that might be API keys (20+ character strings)
   - You can override with `git commit --no-verify` if needed

## How to use:

### Local project setup:
```bash
# Install only in this project
make setup-secrets
```

### Global setup (for all repositories):
```bash
# Install globally (recommended)
make setup-global-hooks

# For existing repositories, run:
cd /path/to/existing/repo
git init  # This applies the template, doesn't reinitialize
```

## How it works:

- The scripts use Git hooks to check files before they're committed
- No external dependencies required, just plain Bash
- All logic is in version-controlled scripts for transparency
- The global setup affects all repositories on your machine
