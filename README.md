# Docker FileBrowser

A Docker setup for [FileBrowser](https://github.com/filebrowser/filebrowser) - a web-based file management application with Alpine Linux base.

FileBrowser is a create-your-own-cloud-kind of software that allows you to upload, delete, preview, and edit your files within a web interface. This Docker setup provides an easy way to deploy and run FileBrowser with proper user permissions and data persistence.

## Features

- **Web-based file management**: Upload, delete, preview, and edit files through a modern web interface
- **User permissions**: Configurable PUID/PGID for proper file ownership
- **Data persistence**: Database and configuration files are stored in a mounted volume
- **Alpine Linux base**: Lightweight container with minimal footprint
- **Easy deployment**: Simple Docker Compose setup with environment variable configuration

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd docker-filebrowser
   ```

2. Start the container:
   ```bash
   docker compose up -d
   ```

3. Access FileBrowser at http://localhost:50000
   - Default username: `admin`
   - Default password: `password`

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| FILEBROWSER_PORT | 50000 | Host port to expose FileBrowser |
| PUID | 1000 | User ID for file permissions |
| PGID | 1000 | Group ID for file permissions |
| INITIAL_USERNAME | admin | FileBrowser admin username |
| INITIAL_PASSWORD | password | FileBrowser admin password |
| TARGET_DIR | /src/servers | Directory to serve files from |

### Custom Configuration

You can customize the configuration by creating a `.env` file:

```bash
# Copy the example environment file
cp .env.example .env

# Edit the configuration
nano .env
```

Example `.env` file:
```env
FILEBROWSER_PORT=8080
PUID=1000
PGID=1000
INITIAL_USERNAME=myuser
INITIAL_PASSWORD=mypassword
TARGET_DIR=/src/servers
```

## Directory Structure

```
docker-filebrowser/
├── Dockerfile          # Multi-stage Docker build
├── docker-compose.yml  # Docker Compose configuration
├── entrypoint.sh      # User/group setup script
├── start.sh           # FileBrowser startup script
├── data/              # Persistent data (created after first run)
│   ├── filebrowser.db # FileBrowser database
│   └── servers/       # Default file serving directory
└── README.md          # This file
```

## Data Persistence

- `./data` - FileBrowser database, configuration files, and served files
- The container automatically creates the necessary directories on first run
- Files are owned by the user/group specified by PUID/PGID

## Security Considerations

- **Change default credentials**: Always change the default username and password
- **File permissions**: Use appropriate PUID/PGID values that match your host system
- **Network exposure**: Consider using a reverse proxy for HTTPS and additional security
- **Access control**: Configure FileBrowser's built-in user management for multiple users

## Troubleshooting

### Permission Issues

If you encounter file permission issues:

1. Check the PUID/PGID values match your host user:
   ```bash
   id your-username
   ```

2. Update the environment variables and restart:
   ```bash
   docker compose down
   docker compose up -d
   ```

### Container Won't Start

Check the logs:
```bash
docker compose logs filebrowser
```

### Can't Access Web Interface

Verify the container is running and port mapping:
```bash
docker compose ps
```

## Contributing

This is a Docker wrapper for the FileBrowser project. For issues with FileBrowser itself, please refer to the [official repository](https://github.com/filebrowser/filebrowser).

## License

This Docker setup is provided as-is under the MIT License.

**FileBrowser License**: This project uses [FileBrowser](https://github.com/filebrowser/filebrowser), which is licensed under the Apache License 2.0.

```
Copyright © FileBrowser Contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Related Links

- [FileBrowser Official Repository](https://github.com/filebrowser/filebrowser)
- [FileBrowser Documentation](https://filebrowser.org)
- [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)