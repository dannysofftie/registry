# export the vars in .env into shell
export $(egrep -v '^#' .env | xargs)
# make auth directory
mkdir -p auth
# create auth basic credentials
docker run --entrypoint htpasswd \
  httpd:2 -Bbn $REGISTRY_USERNAME $REGISTRY_PASSWORD >auth/htpasswd
# start registry and UI
docker-compose up -d
