# Use Debian slim as base
FROM debian:bookworm-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    fortune cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/games:${PATH}"

# Copy Wisecow script
COPY wisecow.sh .

# Make script executable
RUN chmod +x wisecow.sh

# Expose port
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]




