# make auth directory
mkdir -p auth
# create auth basic credentials
docker run --entrypoint htpasswd \
  httpd:2 -Bbn iris_hub_admin 2345trfd34f3g4tet4 >auth/htpasswd
# start registry and UI
docker-compose up -d
