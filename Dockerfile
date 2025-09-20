FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH so fortune and cowsay are detected
ENV PATH="/usr/games:${PATH}"

WORKDIR /app

# Copy the Wisecow script
COPY wisecow.sh /app/wisecow.sh
RUN chmod +x /app/wisecow.sh

EXPOSE 4499

# Start the application
CMD ["./wisecow.sh"]


