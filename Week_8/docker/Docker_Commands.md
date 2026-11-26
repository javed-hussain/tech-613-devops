# Basic Docker Commands

## Create and run a container

```bash
docker run -d --name web -p 8080:80 nginx
```

- `docker run`: Creates and starts a new container from an image.
- `-d`: Detached mode — runs in the background.
- `--name web`: Names the container `web`.
- `-p 8080:80`: Maps host port `8080` to container port `80`. left side exposes port on the machine, right side is port exposed inside the container
- `nginx`: Image to use; downloaded automatically if needed.
- Visit `http://localhost:8080` to access the web server.

> Port order: HOST:CONTAINER. Published ports are accessible beyond localhost by default.

## List containers

```bash
docker ps       # Running containers
docker ps -a    # All containers, including stopped ones
```

## Stop, start and restart

```bash
docker stop web       # Stop the container
docker start web      # Start the existing stopped container
docker restart web    # Restart the container
```

> `run` creates a new container; `start` reuses an existing one.

## Remove a container

```bash
docker stop web
docker rm web         # Remove the stopped container
```

```bash
docker rm -f web      # Force-remove a container, even if running
```

- Stopping keeps the container and its writable data.
- Removing deletes the container and its writable layer, not the image.
- Use volumes for data that must survive container removal.

## View logs

```bash
docker logs web       # Show application output
docker logs -f web    # Follow new output live
```

## Run a command inside a running container

```bash
docker exec -it web sh
```

- `-i`: Keeps input open.
- `-t`: Allocates a terminal.
- `sh`: Starts a shell; type `exit` to leave.

## Automatically remove after exit

```bash
docker run --rm nginx
```

- `--rm`: Removes the container automatically when it exits.

## Images
- `docker images`: lists all images
- `docker rmi imagename`: removes said image

