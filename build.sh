#!/bin/sh
echo "Building Plugin..."
echo "HOST Arch: $(uname -m)"

PLUGIN_DIR="./plugins"
# Navigate to the plugins directory
cd "$PLUGIN_DIR"

# Loop through each directory in the plugins directory
for DIR in */ ; do
    # Check if it's a directory
    if [ -d "$DIR" ]; then
        echo "Building plugin in directory: $DIR"
        # Navigate into the directory
        cd "$DIR"
        # Build the plugin, naming the output file based on the directory name
        # if host is arm64
        if [ "$(uname -m)" == "arm64" ]; then
            docker run -it -v "$PWD:/app" -w /app -e "CGO_ENABLED=1" -e "CC=aarch64-linux-musl-gcc" -e "GOARCH=arm64" -e "GOHOSTARCH=amd64" krakend/builder:2.7.0 go build -buildmode=plugin -o "${DIR%/}.so" .
        else
            docker run -it -v "$PWD:/app" -w /app krakend/builder:2.7.0 go build -buildmode=plugin -o "${DIR%/}.so" .
        fi
        # Move the .so file to the plugins directory
        mv "${DIR%/}.so" ../
        # Navigate back to the plugins directory
        cd ..
    fi
done

echo "Plugin build process completed."
echo "RUN docker compose up to start the server"