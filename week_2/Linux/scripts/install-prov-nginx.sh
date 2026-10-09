#First bash script for installing nginx, run on fresh ubuntu 24.04
#Every bash script needs a `shebang` (#! for bash) this tells unix like systems which interpreter to use
#nNGINX is a background service (daemon) on your Linux system 
#that runs a high‑performance web server and often also acts as a reverse proxy, load balancer, and cache.

#!/bin/bash

#update
sudo apt-get update
#upgrade
sudo apt-get upgrade -y
#install nginx
sudo apt-get install nginx -y
#restart nginx
sudo systemctl restart nginx
#enable nginx adds nginx to the startup
sudo systemctl enable nginx