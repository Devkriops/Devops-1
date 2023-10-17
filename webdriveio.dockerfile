# Use a more recent base image
FROM debian:stretch

# Update the maintainer label
LABEL MAINTAINER="krishna"

# Set proxy environment variables
ARG http_proxy=http://proxy.ebiz.verizon.com:80
ARG https_proxy=http://proxy.ebiz.verizon.com:80
ARG no_proxy=.verizon.com

# Update the system and install necessary packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --fix-missing \
    build-essential \
    apt-transport-https \
    curl

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs


#fireofx

# Manually download Firefox
RUN curl -o /tmp/firefox.tar.bz2 "https://download.mozilla.org/?product=firefox-latest-ssl&os=linux64"
RUN tar -xvjf /tmp/firefox.tar.bz2 -C /opt/
RUN ln -s /opt/firefox/firefox /usr/bin/firefox

# Install Google Chrome
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN apt-get update -y && apt-get install -y google-chrome-stable --allow-unauthenticated --fix-missing
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -ms /bin/bash node
USER node

# Create a directory for WebdriverIO tests
RUN mkdir /tmp/webdriverio-test
WORKDIR /tmp/webdriverio-test

# Configure npm to use the proxy
RUN npm config set https-proxy http://proxy.ebiz.verizon.com:80
RUN npm config set http-proxy http://proxy.ebiz.verizon.com

# Install WebdriverIO CLI and dependencies
RUN npm install --save-dev @wdio/cli
RUN npm install --save-dev @wdio/sync
RUN npm install chromedriver --save-dev

# Generate a WebdriverIO configuration file
RUN npx wdio config -y

# Copy over the pre-configured wdio.conf.js
COPY wdio.conf.js /tmp/webdriverio-test/wdio.conf.js

wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/latest/linux-x86_64/en-US/firefox-XX.X.X.zip
sudo apt-get update
sudo apt-get install unzip
sudo yum install unzip
unzip firefox-XX.X.X.zip
sudo mv firefox /opt/
sudo ln -s /opt/firefox/firefox /usr/local/bin/firefox

