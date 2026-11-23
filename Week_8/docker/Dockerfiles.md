# What is a Dockerfile?

- A `Dockerfile` is a text file containing instructions to build a Docker image automatically.
- It describes the base image, files to add, commands to run, and what starts when the container runs.
- It removes the need to manually change files inside a running container.
- You build an image from it using: `docker build -t IMAGE_NAME .`
- The final `.` tells Docker to use the current folder, where it looks for a file named `Dockerfile`.

# How it works

- Docker reads the `Dockerfile` from top to bottom.
- Each instruction creates or changes a layer in the image.
- The image can then be run as one or more containers.
- Changes to the Dockerfile require rebuilding the image.

# Common instructions

- `FROM` chooses the starting/base image.
- `COPY` copies files from your computer into the image.
- `RUN` runs a command while building the image.
- `WORKDIR` sets the folder used inside the container.
- `EXPOSE` documents which port the container uses.
- `CMD` sets the command that runs when the container starts.

# Nginx example

- `FROM nginx:alpine` starts with a small Nginx image.
- `COPY index.html /usr/share/nginx/html/index.html` replaces Nginx’s default page with yours.
- Build it with: `docker build -t techxxx-nginx-auto:1.0 .`
- Run it with: `docker run -d --name techxxx-web -p 8080:80 techxxx-nginx-auto:1.0`
- Open it at: `http://localhost:8080`

# Why use it

- Makes image creation repeatable.
- Keeps the setup in files you can share.
- Makes it easy to update the page or app and rebuild.
- Lets you create the same image consistently on different machines.