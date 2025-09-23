# Use a lightweight base image
FROM ubuntu:24.04

# Install required dependencies
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH (fortune and cowsay live here)
ENV PATH="/usr/games:${PATH}"

# Set working directory
WORKDIR /app

# Copy your application script
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

# Expose the port your script listens on
EXPOSE 4499

# Run the application
CMD ["./wisecow.sh"]



