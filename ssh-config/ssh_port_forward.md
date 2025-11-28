# SSH Port Forwarding Setup

## Use Case
Setting up SSH local port forwarding to complete device-based authentication flows from your workstation browser when working on a remote server.

## Best Practice: SSH Local Port Forwarding

This is the simplest approach when you have a browser on your workstation but not on the server.

### Steps

1. **From your workstation**, open an SSH tunnel to the server:
   ```bash
   ssh -L 1455:localhost:1455 root@your-server-ip
   ```

2. **In the same SSH session on the server**, run the CLI that starts the local callback listener:
   ```bash
   codex login
   # or codex login --device-auth if using device flow
   ```

3. **Copy the callback URL** that the CLI prints (looks like `http://localhost:1455/auth/callback?...`)

4. **Open the URL in your workstation browser** (not the server). The browser request to `http://localhost:1455` will be forwarded over the SSH tunnel to the listener on the server.

5. **Complete the sign-in** in your browser. The authentication will flow back to the server. Done!

## Additional Notes

- The `-L` flag sets up local port forwarding: local port 1455 → server's localhost:1455
- Replace `1455` with the actual port your CLI uses
- Keep the SSH session open while authenticating
- This works even if the server doesn't have a display manager or browser
