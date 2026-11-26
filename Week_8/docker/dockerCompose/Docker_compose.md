# Docker Compose

## What is Docker Compose?

- Docker Compose is a tool for running **multiple Docker containers together** using one YAML file.
- Instead of running each container separately with `docker run`, you define all of your services in a `docker-compose.yaml` file and start them with one command:
  - `docker compose up -d`

For the TTT app, you need:
- A MongoDB container
- A TTT app container

Docker Compose also creates a shared internal network. 
- This means the app can connect to Mongo using the service name `mongo`, rather than an IP address.

## What is a service?
- A service is one part of your application that Docker Compose runs as a container.
- In this project:
  - `mongo` is the database service.
  - `app` is the web application service.
- A service is the definition in the Compose file. A container is the running instance created from that definition.

## What is a volume?
- A volume is storage managed by Docker that exists outside the container.
- Containers are temporary. If you delete a Mongo container, its database data would normally be deleted too.
- A volume keeps the MongoDB data safe even if the container stops, is removed, or is recreated.

## How it works

1. Create a `docker-compose.yaml` file.
2. Define each service, such as `mongo` and `app`.
3. Run `docker compose up -d`.
4. Docker Compose creates and starts the containers.
5. The services communicate using their service names.
6. Stop them all with `docker compose down`.

## The Compose file

`docker-compose.yaml`

```yaml
services:
  mongo:
    image: mongo:8
    container_name: ttt-mongo
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db

  app:
    image: javs1204/tttapp:v1
    container_name: ttt-app
    ports:
      - "3001:3000"
    environment:
      - MONGODB_URI=mongodb://mongo:27017/tictactoe
    depends_on:
      - mongo
    user: root
    command: sh -c "npm ci --omit=dev && node index.js"

volumes:
  mongo-data:
```

## Explain the services

### `mongo` service

The `mongo` service runs the MongoDB database using the official `mongo:8` image.

- `container_name: ttt-mongo` gives the container a fixed name.
- `ports: "27017:27017"` maps port `27017` on your Mac to port `27017` inside the Mongo container.
- `volumes: mongo-data:/data/db` saves MongoDB data in a volume.
- MongoDB stores its database files in `/data/db`, so the volume keeps the data after the container restarts.

### `app` service

The `app` service runs your TTT Node.js application using the image you pushed to Docker Hub.

- `container_name: ttt-app` gives the app container a fixed name.
- `ports: "3001:3000"` maps port `3001` on your Mac to port `3000` inside the app container.
- Open the app at `http://localhost:3001`.
- `MONGODB_URI=mongodb://mongo:27017/tictactoe` gives the app the MongoDB connection string.
- `mongo` is the Compose service name, `27017` is Mongo’s port, and `tictactoe` is the database name.
- Do not use `localhost`, because inside the app container `localhost` means the app container itself.
- `depends_on: mongo` starts Mongo before the app.
- `user: root` runs the app container as root.
- `command: sh -c "npm ci --omit=dev && node index.js"` installs dependencies, seeds the database, then starts the app.

### Why `user: root` is needed

- Your app image runs as the `node` user, but the files in `/app` were created as `root` when the image was built.
- `npm ci` needs to change files inside `/app/node_modules`, but the `node` user does not have permission to do that.
- This causes the error:
  - `EACCES: permission denied`
- Running the container as `root` gives it permission to install dependencies and seed the database.

### `volumes`

```yaml
volumes:
  mongo-data:
```
- This declares the named volume called `mongo-data`.
- The Mongo service uses it at `/data/db`, so the database data survives container restarts.

## Run the Compose file

- Start both services:
  - `docker compose up -d`
- Check they are running:
  - `docker compose ps`
- Check the app: Open: `http://localhost:3001`
- Check the app logs: `docker compose logs app`
- Stop the services:
  - Stop the containers but keep the database data: `docker compose down`
  - Stop the containers and delete the database data: `docker compose down -v`