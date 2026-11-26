

# Modify the Nginx Default Page

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

# Custom multi-platform nginx image (no Dockerfile)

## Problem
- `docker commit` only captures the architecture of the container it came from.
- Committing on an arm64 Mac gives an arm64-only image, so amd64 users saw the default nginx page.

## Process
1. Run one nginx container per platform:
   ```bash
   docker run -d --name web-arm64 --platform linux/arm64 nginx
   docker run -d --name web-amd64 --platform linux/amd64 nginx
   ```
2. Edit the heading in each:
   ```bash
   docker exec <container> sed -i 's|<h1>.*</h1>|<h1>Javed nginx page</h1>|' /usr/share/nginx/html/index.html
   ```
3. Commit and push each to its own tag:
   ```bash
   docker commit web-arm64 javs1204/nginx:v3-arm64
   docker commit web-amd64 javs1204/nginx:v3-amd64
   docker push javs1204/nginx:v3-arm64
   docker push javs1204/nginx:v3-amd64
   ```
4. Combine into one multi-platform tag:
   ```bash
   docker buildx imagetools create -t javs1204/nginx:v3 \
     javs1204/nginx:v3-arm64 \
     javs1204/nginx:v3-amd64
   ```

## Verify
```bash
docker buildx imagetools inspect javs1204/nginx:v3
docker run --rm --platform linux/arm64 javs1204/nginx:v3 cat /usr/share/nginx/html/index.html
docker run --rm --platform linux/amd64 javs1204/nginx:v3 cat /usr/share/nginx/html/index.html
```
- Inspect output should list both `linux/arm64` and `linux/amd64`.
- Both `cat` commands should show the edited heading.

## check
```bash
docker run -d --name web-check -p 8080:80 javs1204/nginx:v3
curl localhost:8080
```
Should show the edited webpage despite the processor ur using




# Create custom Nginx image with dockerfile

- Create a new folder: `mkdir foldername` and cd into it.
- Create `index.html` with your own custom web page inside it.
- Create a `Dockerfile` with the following content:
  - `FROM nginx:alpine` Use the Nginx base image: (alpine is basic linux)
  -  `COPY index.html /usr/share/nginx/html/index.html` Copy your custom page over the default Nginx page:

### Supports only your chip

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
