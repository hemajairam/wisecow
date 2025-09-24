#!/usr/bin/env bash


# Add Debian games directory to PATH
export PATH=$PATH:/usr/games

SRVPORT=4499
RSPFILE=response

# Remove previous FIFO and create a new one
rm -f "$RSPFILE"
mkfifo "$RSPFILE"

# Function to simulate getting API input (just reads one line)
get_api() {
    read -r line
    echo "$line"
}

# Function to handle each HTTP request
handleRequest() {
    # Process the request
    get_api
    mod=$(fortune)

    # Write HTTP response to the FIFO
    cat <<'EOF' > "$RSPFILE"
HTTP/1.1 200 OK
Content-Type: text/html

<pre>$(cowsay "$mod")</pre>
EOF
}

# Check if required commands exist
prerequisites() {
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 || { 
        echo "Install prerequisites: cowsay and fortune"
        exit 1
    }
}

# Main loop
main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        # Listen on SRVPORT and handle requests
        cat "$RSPFILE" | nc -l -p "$SRVPORT" -s 0.0.0.0 -N | handleRequest
        sleep 0.01
    done
}

main


