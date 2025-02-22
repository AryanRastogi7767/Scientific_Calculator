FROM alpine:latest

# Install dependencies
RUN apk update && apk add --no-cache python3 py3-pip openssh
RUN apk add --no-cache py3-requests

# Set root password for SSH
RUN echo "root:password" | chpasswd

# Configure SSH to allow root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Generate SSH keys
RUN ssh-keygen -A

# Expose SSH port
EXPOSE 22

# Create working directory and copy files
WORKDIR /app
COPY calculator.py /app/

# Make the script executable
RUN chmod +x /app/calculator.py

# Start SSH daemon by default
CMD ["/usr/sbin/sshd", "-D"]

