# Deploying MongoDB

- Set security rules - allow inbound traffic from port 27017
- update and upgrade
  - `sudo apt update; sudo apt upgrade
- Add MongoDBs signing key:
  - `curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \ sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg`
  - gpg 

| part | meaning |
| ------ | -------|
| curl -fsSL| Download a file quietly and fail clearly on errors|
| https://...server-8.0.asc  | MongoDB’s public signing key                        |
| \\                         | Continues the command on the next line              |
| gpg --dearmor              | Converts the ASCII key into a binary keyring format |
| -o /usr/share/keyrings/... | Saves the converted key                             |

- Add MongoDBs repository - Ubuntue default repos (packages) does not include the official mongodb-org package so we must add it first before we can download it
  - `echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list`

| Part                        | Meaning                                              |
| --------------------------- | ---------------------------------------------------- |
| echo "..."                  | Prints the repository configuration text             |
| deb                         | Tells APT this is a Debian/Ubuntu package repository |
| arch=amd64,arm64            | Supports Intel/AMD and ARM CPUs                      |
| signed-by=...               | Uses the MongoDB key to verify packages              |
| noble                       | Ubuntu 24.04’s codename                              |
| mongodb-org/7.0             | MongoDB 7.0 official repository                      |
| tee                         | Writes the text into a file                          |
| /etc/apt/sources.list.d/... | Where Ubuntu stores extra package repositories       |

- Install MongoDB
  - we now update our packages - goes to the mongoDB repo and reads it and then installs it
  - `sudo apt update &&
sudo apt install -y mongodb-org`
  - OR `sudo apt-get install -y \
   mongodb-org=7.0.22 \
   mongodb-org-database=7.0.22 \
   mongodb-org-server=7.0.22 \
   mongodb-mongosh \
   mongodb-org-shell=7.0.22 \
   mongodb-org-mongos=7.0.22 \
   mongodb-org-tools=7.0.22 \
   mongodb-org-database-tools-extra=7.0.22` this installs individual packages then all of mongodb
- Check the state of mongodb:
  - `sudo systemctl status mongod --no-pager`
  - --no-pager prints output directly instead of opening a pager
- Change the config:
  - by default mongodb only allows connections from the local host so we need to edit the config to allow others
    - `cd /; cd etc` (where all the config files/directories are)
    - `sudo nano mongod.config`
    - edit the network interfaces: change the bindip from local host to a specific IP / range of IP addresses that are allowed
- Start MongoDB:
  - `sudo systemctl enable --now mongod`
    - enable makes it a startup process - start just starts it --now makes sure it happens now
  - check the status should be running

## Connecting mongodb to app instance

- set the mongodb uri as an evironment variable:    
  - `export MONGODB_URI=mongodb://DB-PUBLIC-IP-ADDRESS:27017/tictactoe`
  - kill the process
  - run npm install - simply connect to said db by specifying the url above
  - start the process again