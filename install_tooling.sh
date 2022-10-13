#!/bin/sh

DEVSPACE_VERSION="v6.1.1"

apk add --no-cache curl vim wget bash iputils bind-tools git nodejs-lts npm openssl || (apt-get update && apt-get -y install curl vim wget bash inetutils-ping dnsutils git openssl && curl -sL https://deb.nodesource.com/setup_lts.x -o nodesource_setup.sh && bash nodesource_setup.sh && apt-get install nodejs)

npm install -g yarn

ARCH_SHORT="arm64"
ARCH=$(arch)
if [ "$ARCH" = "x86_64" ]; then
    ARCH_SHORT="amd64"
fi

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH_SHORT/kubectl"
chmod +x kubectl
install -p kubectl /usr/local/bin;
rm kubectl

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
rm get_helm.sh

curl -s -L "https://github.com/loft-sh/devspace/releases/download/$DEVSPACE_VERSION/devspace-linux-$ARCH_SHORT" -o devspace
chmod +x devspace
install -p devspace /usr/local/bin;
rm devspace

devspace add plugin https://github.com/loft-sh/loft-devspace-plugin

curl -s -L "https://github.com/loft-sh/devspace/releases/download/v2.3.1-beta.0/loft-linux-$ARCH_SHORT" -o loft
chmod +x loft
install -p loft /usr/local/bin;
rm loft
