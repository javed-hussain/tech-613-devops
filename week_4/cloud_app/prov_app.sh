#!/bin/bash
set -euxo pipefail

APP_DIR="/home/ubuntu/tictactoe-deploy"
# Update and upgrade
sudo apt update
sudo apt upgrade -y

# Install all relevant packages
sudo apt install unzip nginx git -y

# Download the NodeSource setup script for Node.js 20.x
# and  save it in the file nodesource_setup.sh
curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh

# Run the NodeSource setup file with administrator privileges
sudo bash nodesource_setup.sh

# Install the relevant version of Node.js and pm2
sudo apt install nodejs -y
sudo npm install -g pm2

# Fresh clone each run so re-runs are safe

rm -rf "$APP_DIR"
git clone https://github.com/Adnan-SpartaGlobal/tictactoe-deploy.git "$APP_DIR"
cd "$APP_DIR"

# Unzip and run the app only if the zip file exists
if [ -f nodejs20-sparta-tictactoe-v1.zip ]; then

    # Extract the application files from the zip archive.
    # -o overwrites existing files, making re-runs safe.
    unzip -o nodejs20-sparta-tictactoe-v1.zip
    cd "$APP_DIR/app"

    # Stop any PM2 daemon currently owned by the ubuntu user.
    sudo -u ubuntu pm2 kill || true

    # Give the ubuntu user ownership of the cloned and unzipped app.
    chown -R ubuntu:ubuntu "$APP_DIR"

    if [ -n "${MONGODB_URI:-}" ]; then
        sudo -u ubuntu \
            MONGODB_URI="$MONGODB_URI" \
            npm install
    else
        sudo -u ubuntu npm install
    fi

    # Remove any existing tictactoe PM2 process so re-runs do not
    sudo -u ubuntu pm2 delete tictactoe || true

    # Start the Node.js application and name the PM2 process tictactoe.
    # Pass MONGODB_URI to the running app as well, so the website can
    # connect to MongoDB at runtime, not just during seeding.
    if [ -n "${MONGODB_URI:-}" ]; then
        sudo -u ubuntu \
            MONGODB_URI="$MONGODB_URI" \
            pm2 start index.js --name tictactoe
    else
        sudo -u ubuntu \
            pm2 start index.js --name tictactoe
    fi

    # Configure PM2 to start automatically when the EC2 instance boots.
    # This must run as root because it creates and enables a systemd service.
    # -u ubuntu and --hp /home/ubuntu tell PM2 to restore the ubuntu user's
    # saved processes, rather than root's processes.
    sudo env PATH="$PATH:/usr/bin" pm2 startup systemd -u ubuntu --hp /home/ubuntu

    # Save the current PM2 process list for the ubuntu user.
    # PM2 uses this saved list to restore the tictactoe app after a reboot.
    sudo -u ubuntu pm2 save

    # Reverse proxy: replace nginx's file-serving line with a proxy to the app.
    # On re-runs the line is already gone, so sed changes nothing.
    sed -i 's|try_files \$uri \$uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default

    # Check the config is valid, and only reload nginx if it is
    nginx -t && systemctl reload nginx         

else
    echo "Cannot find zip file needed"
fi