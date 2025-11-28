# User Management Quick Reference

## Create a New Sudo-Capable User

Create a new user and add them to the sudo group:

```bash
adduser username
usermod -aG sudo username
su - username
```

### Step by Step

1. **Create the user** (you'll be prompted for password and user info):
   ```bash
   adduser username
   ```

2. **Add user to sudo group**:
   ```bash
   usermod -aG sudo username
   ```

3. **Switch to the new user**:
   ```bash
   su - username
   ```

### Verify Sudo Access
```bash
sudo -v
```

If no errors appear, sudo is working correctly for the user.

## Other Useful Commands

```bash
# List all users
cat /etc/passwd

# Delete a user
userdel username

# List groups for a user
groups username

# Add user to additional group
usermod -aG groupname username
```
