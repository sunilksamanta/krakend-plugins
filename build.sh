#!/bin/sh
echo "Building Plugin..."

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
        docker run -it -v "$PWD:/app" -w /app krakend/builder:2.7.0 go build -buildmode=plugin -o "${DIR%/}.so" .
        # Move the .so file to the plugins directory
        mv "${DIR%/}.so" ../
        # Navigate back to the plugins directory
        cd ..
    fi
done

echo "Plugin build process completed."