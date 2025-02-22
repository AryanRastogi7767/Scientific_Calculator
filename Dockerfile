FROM ubuntu:latest
# Install SSH
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd  # Change the password as needed
# Allow root login and disable strict host key checking
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Expose SSH Port
EXPOSE 22
# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
WORKDIR /app
COPY calculator.py /app/
RUN chmod +x /app/calculator.py
CMD ["python", "calculator.py"]

