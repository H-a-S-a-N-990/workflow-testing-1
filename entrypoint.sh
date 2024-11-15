#!/bin/bash

# Check if the required environment variables are set
if [ -z "$VPS_USER" ] || [ -z "$VPS_IP" ] || [ -z "$VPS_SSH_KEY" ]; then
    echo "Error: VPS_USER, VPS_IP, and VPS_SSH_KEY environment variables must be set."
    exit 1
fi

# Create a temporary private key file
echo "$VPS_SSH_KEY" > /root/.ssh/private_key
chmod 600 /root/.ssh/private_key

# Use sshx to connect to the VPS and run commands
sshx -i /root/.ssh/private_key "$VPS_USER@$VPS_IP" << 'EOF'
    # Update package list and install neofetch
    sudo apt-get update
    sudo apt-get install -y neofetch
    
    # Start a long-running process (replace with your command)
    # For example, starting a simple HTTP server
    nohup python3 -m http.server 8000 &
EOF
