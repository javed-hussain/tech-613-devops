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

## Modify the Nginx Default Page

- `docker ps` — find the running container.
- `docker exec -it web sh` — open a shell inside `web`.
- `cd /usr/share/nginx/html` — navigate to the page directory.
- `cat index.html` — view the current HTML.
- `echo '<h1>Hello from Docker!</h1>' > index.html` — replace the page.
- `exit` — leave the shell; the container keeps running.
- Open `http://localhost` — our port mapping is `80:80`.
- Changes affect the container, not the image, and are lost when the container is removed.

## Save and Push an Image to Docker Hub

- Replace `YOUR_USERNAME` with your Docker Hub username.
- `docker commit web YOUR_USERNAME/my-nginx:latest` — save the modified container as an image.
  - my-nginx is the name :latest is the tag
- `docker login` — sign in to Docker Hub on terminal
- `docker push YOUR_USERNAME/my-nginx:latest` — upload the image.
- Share: `docker run -d -p 90:80 YOUR_USERNAME/my-nginx:latest` - other people to run your image
- Others run the command and open `http://localhost:90`.

# Create custom Nginx image with dockerfile

- Create a new folder: `mkdir foldername` and cd into it.
- Create `index.html` with your own custom web page inside it.
- Create a `Dockerfile` with the following content:
  - `FROM nginx:alpine` Use the Nginx base image: (alpine is basic linux)
  -  `COPY index.html /usr/share/nginx/html/index.html` Copy your custom page over the default Nginx page:

# Supports only your chip

- Build and tag the image: `docker build -t IMAGE_NAME`
  - Uses the default builder and normally creates an image for your computer’s architecture.
- Run the container to test it: `docker run -d --name CONTAINER_NAME -p 8080:80 IMAGE_NAME`
- Log in to Docker Hub: `docker login`
- Tag the image for Docker Hub: `docker tag IMAGE_NAME DOCKER_USERNAME/IMAGE_NAME`
- Push the image to Docker Hub: `docker push DOCKER_USERNAME/IMAGE_NAME`
- Share this command so others can run it: `docker run -d --name CONTAINER_NAME -p 8080:80 DOCKER_USERNAME/IMAGE_NAME`

# Support both chips

- Build and push an image for both AMD64 and ARM64: `docker build --platform linux/amd64,linux/arm64 -t javs1204/my_nginx:1.0 --push .`
- `docker build` builds the image using Docker’s default builder.
- `--platform linux/amd64,linux/arm64` builds two versions:
  - `linux/amd64` for Intel/AMD computers.
  - `linux/arm64` for Apple Silicon and ARM computers.
- `-t javs1204/my_nginx:1.0` names the image for Docker Hub:
  - `javs1204` is the Docker Hub username.
  - `my_nginx` is the repository name.
  - `1.0` is the version tag.
- `--push` uploads the image directly to Docker Hub.
- `.` tells Docker to use the current folder, which must contain the `Dockerfile` and `index.html`.
- Docker automatically selects the correct version when someone pulls the image.

# Run the shared image

- Anyone can run your image with: `docker run -d --name techxxx-web -p 8080:80 javs1204/my_nginx:1.0`
- Open the page at: `http://localhost:8080`
- To force Docker to pull the latest image from Docker Hub before running it: `docker run -d --name techxxx-web -p 8080:80 --pull always javs1204/my_nginx:1.0`
