# Proxy

- A proxy is a middleman server between two systems: instead of a client connecting directly to a server, the request goes through the proxy, which forwards it and returns the response.
- there are 2 main types: forward proxy and reverse proxies:

### Forward Proxy:
- A forward proxy acts for the user. For example, your browser sends a request to the proxy, and the proxy fetches the website. The destination website may only see the proxy’s IP address, not yours.
- User → Forward proxy → Internet website

### Reverse Proxy:
- A reverse proxy acts for the server.
- A reverse proxy is a server that sits in front of your application server and forwards incoming user requests to it. The user talks to the reverse proxy; the reverse proxy talks to your actual app behind the scenes.
- Reasons to use one:
  - One public entry point: users use port 80/443, while your Node app can stay on an internal port such as 3000.
  - Security: the Node app does not need to be directly exposed to the internet.
  - TLS/HTTPS: Nginx can handle HTTPS certificates, so your Node app can remain on plain HTTP internally.
  - Load balancing: if you run multiple app instances, Nginx can distribute requests between them
  - Static files and caching: Nginx can serve images/CSS/JS directly and reduce load on Node.

### Configure Nginx as a reverse proxy:
- Nginx acts as a reverse proxy: it receives public web traffic on port 80 and forwards it to your Node.js application running privately on port 3000. Users access Nginx; Nginx accesses the app
- First we must ensure the node app is running
- Then we need to edit the nginx site configuration - the default site config is at `/etc/nginx/sites-available/default`
- We need to add the proxy_pass to the config file so requests are sent from nginx to the specified server port
- we can manually open and edit the location block or use the following command:
- `sudo sed -i 's|try_files \$uri \$uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default`
  - `sed` : stream editor
  - `-i`: edit file in place
  - `s|old|new|`: sub old text with new
  - `try_files \$uri \$uri/ =404;` : what we are replacing
  - `proxy_pass http://localhost:3000;`: What we are changing it to - this is configuring the proxy
  - `/etc/nginx/sites-available/default`: name of the file
- Then we verify:
  - `sudo nginx -t && sudo systemctl reload nginx`: checks config is valid and reloads nginx only if it is valid
    - `nginx -t` tests ngingx config files for errors