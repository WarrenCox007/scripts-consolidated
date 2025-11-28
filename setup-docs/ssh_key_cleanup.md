# SSH Key Cleanup

## Remove Cached Host Keys

When reconnecting to a server after reinstalling or changing SSH keys, you may get a host key mismatch warning. Remove the cached host key:

```bash
ssh-keygen -R 192.168.10.20
```

Replace `192.168.10.20` with your server's IP address.

### What This Does
- Removes the server's entry from your `~/.ssh/known_hosts` file
- Allows you to connect and re-cache the new host key on the next connection
- You'll be prompted to verify the new fingerprint

### Example
```bash
# Remove host key for server at 192.168.10.20
ssh-keygen -R 192.168.10.20

# Next SSH connection will prompt you to verify the new key
ssh root@192.168.10.20
```
