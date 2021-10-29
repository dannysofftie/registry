#!/usr/bin/env bash
# install docker if not installed
if ! command -v docker &>/dev/null; then
    # remove older versions of docker
    sudo apt-get remove docker docker-engine docker.io containerd runc -y
    # add docker repositories
    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
    # add Docker gpg key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # set up stable repositories
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs)  stable" -y
    # install docker
    sudo apt update && sudo apt install docker-ce containerd.io -y
    # add current user to docker group and refresh current shell
    sudo usermod -aG docker $USER
    # notify user to rerun script again
    echo -e "\n\e[0;32mAfter entering your password, rerun ./deploy.sh again to proceed\e[0;39m\n"
    # refresh current shell
    exec su $USER
fi
# install docker compose if not installed
if ! command -v docker compose &>/dev/null; then
    # download docker compose
    sudo curl -L --output docker-compose "https://github.com/docker/compose/releases/download/v2.0.1/docker-compose-$(uname -s)-$(uname -m)"
    mkdir -p ~/.docker/cli-plugins
    mv docker-compose ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose
fi
