# KrakenD Plugin Builder Project

This project allows you to create custom plugins for the KrakenD API Gateway. It includes a build script that automates the compilation of plugins from source code into shared objects (.so files) and a Docker Compose setup to run KrakenD with these plugins.

## Prerequisites

- Docker
- Docker Compose
- Basic knowledge of Docker and command-line operations

## Project Structure

- `plugins/`: Directory where each subdirectory is a plugin. Create your plugin directories here.
- `build.sh`: Script to build all plugins in the `plugins/` directory.
- `krakend.json`: Krakend config file for Routes configuration.
- `docker-compose.yml`: Docker Compose configuration file to run KrakenD with built plugins.

## Setting Up Your Plugins

1. **Create a Plugin**: Navigate to the `plugins/` directory and create a new directory for your plugin. The directory name will be used as the plugin name.
  
    ```bash
    mkdir -p plugins/my-plugin
    ```

2. **Add Plugin Code**: Place your Go source code inside this new directory.

## Building Plugins

Before running the API gateway, you need to build the plugins using the provided script.

1. **Make the Build Script Executable**:

    ```bash
    chmod +x build.sh
    ```

2. **Run the Build Script**:

    ```bash
    ./build.sh
    ```

    This script will compile each plugin into a `.so` file and move it to the `plugins/` directory.

## Running KrakenD API Gateway

After building the plugins, you can start the KrakenD API Gateway with all plugins loaded:

```bash
docker-compose up
```

This command starts the KrakenD service as defined in the docker-compose.yml file, loading all the built plugins.

## Customizing Docker Compose

If needed, you can edit the `docker-compose.yml` file to tweak the KrakenD configuration or to add additional services to your setup.