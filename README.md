# Docker Registry

Setup your own Docker Registry in a matter of seconds

## Requirements

1. Server running Ubuntu v18.04 or v20.04
2. Basic `docker` & `docker compose` familiarity

You can skip to **Setup** stage if you have `docker` & `docker compose` installed. Run the install script to install both dependencies/packages.

> chmod +x ./install.sh && ./install.sh

## Setup

1. Create required configs

   - Copy `.sample.env` to `.env` and update below environment variables

   ```bash
   REGISTRY_PUBLIC_URL="registry.yourdomain.com"
   REGISTRY_PROTOCOL="https" # or http
   SSL_VERIFY=true # set this to false if you don't have SSL for your domain

   TITLE="" # title as it would appear on the browser
   ALLOW_REGISTRY_LOGIN=true
   USERNAME="" # required to secure the web interface
   PASSWORD=""

   REGISTRY_ALLOW_DELETE=true
   REGISTRY_USERNAME="" # this username and password will secure the registry (pull and push will require authentication using this username and password)
   REGISTRY_PASSWORD=""
   REGISTRY_HTTP_ADDR="registry.yourdomain.com" # must be same as REGISTRY_PUBLIC_URL above
   REGISTRY_AUTH="htpasswd" # leave this as it is
   REGISTRY_AUTH_HTPASSWD_PATH="/auth/htpasswd" # leave this as it is
   REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" # leave this as it is
   ```

2. Run setup script

   > chmod +x ./setup.sh && ./setup.sh

   After this scripts runs, both `docker registry` and `craneoperator` (in this case the UI to view images in the registry) will be running. Use `docker ps` to confirm they are both up and running.

3. Now that both the registry and web interface are running, setup reverse proxy with your favourite web server. There are two nginx config files in `config`, one for the web interface and the other for docker registry.

   Open each and replace `yourdomain.com` with your valid DNS name

4. View on the browser.
   Open your browser at `hub.yourdomain.com` and login to view your new docker registry.

5. Proceed to push your images as you would to docker hub.

   - Login to the new registry
     > docker login registry.yourdomain.com
   - Tag your image
     > docker tag your_image_name:latest registry.yourdomain.com/your_image_name:latest
   - Push to registry
     > docker push registry.yourdomain.com/your_image_name:latest

6. To pull images from registry, you'll be required to login as you did in step 5 above, then run the pull command
   > docker pull registry.yourdomain.com/your_image_name:latest

## House keeping

From time to time, you'll need to do garbage collection to clean up old images.
The most quick and straight forward way is to run the gargabe collection command.

> docker exec docker_registry bin/registry garbage-collect /etc/docker/registry/config.yml -m

Where `docker_registry` is the running container name. Replace with your running instance name.

You can set up a cron job to run every day, say at midnight to do garbage collection for you.
