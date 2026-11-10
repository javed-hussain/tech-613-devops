
#!/bin/bash
set -eu

# Wait for the image's existing PM2 service to finish starting.
systemctl start pm2-ubuntu.service

# Update the existing application as Ubuntu.
sudo -iu ubuntu bash <<'EOF'
set -eu

#db Ip address hard coded in
cd /home/ubuntu/tictactoe-deploy/app
export MONGODB_URI='mongodb://172.31.54.0:27017/tictactoe'

pm2 restart tictactoe --update-env
pm2 save
EOF