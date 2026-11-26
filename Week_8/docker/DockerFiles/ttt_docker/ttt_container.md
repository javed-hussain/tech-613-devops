# Run Sparta Node.js app in Docker

## Aim

- Run the ttt app in a Docker container.
- Build and push the image to Docker Hub.
- Share a `docker run` command that anyone can use.

## Folder structure

- Create a folder for the project and cd into it
- copy the `app` folder inside this folder.
- Create the `Dockerfile` in the same folder as `app`.

docker-ttt-app/  
    ├── app/  
    └── Dockerfile

## Dockerfile
put this inside the dockerfile
```dockerfile
FROM node:20-alpine

WORKDIR /app

COPY app/ .

RUN npm ci --omit=dev

USER node

EXPOSE 3000

CMD ["node", "index.js"]
```

- `FROM node:20-alpine` uses a stable, small Node.js base image - version 20 is app specific.
- `WORKDIR /app` sets `/app` as the working folder inside the container.
- `COPY app/ .` copies all files from your local `app` folder into `/app` in the container.
- `RUN npm ci --omit=dev` installs production dependencies and skips development dependencies.
- `USER node` runs the app as the non-root `node` user.
- `EXPOSE 3000` documents that the app uses port `3000`.
- `CMD ["node", "index.js"]` starts the app when the container runs.

## Build the image

- Run this from the folder containing the `Dockerfile`: 
  - `docker build --platform linux/amd64,linux/arm64 -t javs1204/tttapp:v1 .` (add --push to push directly)
- `--platform linux/amd64,linux/arm64` builds versions for Intel/AMD and ARM computers.
- `-t javs1204/tttapp:v1` names the image for Docker Hub.
- `.` tells Docker to use the current folder as the build context.

## Run the container

- Remove any old container with the same name: `docker rm -f tttapp`
- Run the app: `docker run -d --name tttapp -p 3001:3000 javs1204/tttapp:v1`
- `-d` runs the container in the background.
- `--name tttapp` gives the container a name.
- `-p 3001:3000` maps port `3001` on your computer to port `3000` inside the container.
- Open the app at: `http://localhost:3001`

## Push to Docker Hub

- Log in: `docker login`
- Push the image: `docker push javs1204/tttapp:v1`

## Share the run command

- Classmates can run your app with: `docker run -d --name tttapp -p 3001:3000 javs1204/tttapp:v1`
- They open it at: `http://localhost:3001`

## Troubleshooting
- If a container name is already used, remove it: `docker rm -f CONTAINER_NAME`
- `docker ps` shows only running containers.
- `docker ps -a` shows running and stopped containers.
- If port `3000` is already in use, use another host port such as `3001`: `-p 3001:3000`
- The left port is your computer’s port; the right port is the container’s port.
- To remove all stopped containers: `docker container prune`
- To remove all containers, including running ones: `docker rm -f $(docker ps -aq)`