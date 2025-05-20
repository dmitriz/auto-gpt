# How to use git-secret in this project

1. Install git-secret (https://git-secret.io/)
2. Initialize: git secret init
3. Add allowed users: git secret tell your@email.com
4. Add files to hide: git secret add .env
5. Encrypt files: git secret hide

The encrypted files (.env.secret) can be safely committed.
