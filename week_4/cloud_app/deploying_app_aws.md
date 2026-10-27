# Deploying an app on AWS

We are deploying a Node.js app (javascript app)
We are deploying the app onto port 3000 (The port is the numbered ednpoint for communication inside a server - specified by its IP address) so we need to open port 3000
We need a web server to run the app - nginx
Need linux
need the app code to run and deploy - monolith application - front and backend on same server

First thing we do is launch the instance - then connect to the remote host - make sure to install nginx

 - copy the app file .zip from your local device to your remote EC2 instance:
   - `scp -i ~/.ssh/tech613-javed-aws-key.pem ~/Downloads/node-app.zip ubuntu@54.78.161.154:/home/ubuntu/`
   - scp: secure copy
   - -i path-to-key: uses EC2 private key to authenticate
   - path to file: local file to upload
   - `ubuntu@54.78.161.154`: connects to the ubuntu user in the EC2 instance at the public IP
   - `:/home/ubuntu/` specifies the location to copy to

- install nodejs and npm on the EC2 instance
``` bash
sudo apt update # gets latest packages
sudo apt install -y nodejs npm #installs nodjs and npm
node -v#check version
npm -v 
```

- Extract and prep the app (unzip)
``` bash
sudo apt install -y unzip #install unzip
unzip tic-tac-toe.zip
ls # should have the unzipped app
```
- install dependencies:
``` bash
cd app #navigate into the app folder (must contain package.json)
npm install #this installs all the packages in the package.json file
```
- start the app:
  - open the package.json file using cat and find the scripts section to find what the start command is (typically nom start) and then run it
  - after running it if terminal output says server running on port 3000 it is a success
  - can visit http://YOUR_EC2_PUBLIC_IP:3000 to see if it is up


### Making the app persist
PM2 is a process manager for Node.js. Instead of running npm start directly and losing the app when you close SSH, PM2 keeps it running in the background, restarts it if it crashes, captures logs, and can start it again after an EC2 reboot. PM2 keeps the app running so long as the instance is up

- install PM2
``` bash
sudo npm install -g pm2
```
- start the app in pm2
``` bash
pm2 start index.js --name node_app
# start index.js is the start command found in package.json
```
- now the app will persist if we close our SSH session as long as the instance is up and we do not stop the app

### Useful commands
| Command | What it does |
|---|---|
| `pm2 start index.js --name node_app` | Start the app |
| `pm2 status` | Check if it is running |
| `pm2 logs node_app` | View live logs |
| `pm2 restart node_app` | Restart the app |
| `pm2 stop node_app` | Stop the app |
| `pm2 delete node_app` | Remove it from PM2 |
| `pm2 save` | Save apps for reboot |
| `pm2 startup systemd -u root --hp /root` | Enable auto-start on reboot - uses ubunutus service manager systemd, configures pmr for roor user and tells pmt that roots home directory is /root |
| `pm2 monit` | View CPU/memory dashboard |


## Automating:
- we can then add all these commands into a script
- for idempotency, before we run a command such as unzip or pm2 start or git clone check if files alreay exist and either delete or skip that step

### User Data
- If our script is up and running we can paste this into the **user data section** of our instance when we are launching it - this will run the script on bootup and execute the commands without us ever needing to ssh into the instance
- User data lets you bootstrap a fresh EC2 instance without manually SSH-ing in first. On Linux, cloud-init reads the user data during the first boot and executes it as root.
- You can use it to:
  - Update packages
  - Install software such as Node.js, PM2, Nginx, or MongoDB
  - Clone or download your application
  - Install dependencies
  - Create configuration files
  - Start services
  - Configure a reverse proxy


### Images:
- In AWS, an image usually means an AMI (Amazon Machine Image). It is a saved template of an EC2 server’s operating system, installed software, files, and configuration, used to launch new EC2 instances.
- In simple terms it is a server blueprint or saved snapshot of a configured machine
- Instead of rerunning the entire user data script we can launch an instance of that image
- To create an image we just need to go on the instance - actions - image and templates - create image - name and describe it and then we can launch an instance from that