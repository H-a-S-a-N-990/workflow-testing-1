# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    sudo \
    openssh-client \
    python3 && \
    rm -rf /var/lib/apt/lists/*

# Install sshx
RUN curl -sSf https://sshx.io/get | sh -s run

# Create a directory for the SSH key
RUN mkdir -p /root/.ssh

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
