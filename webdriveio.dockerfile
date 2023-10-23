# Use the base image
FROM ubuntu:20.04

# Set proxy environment variables if needed


# Set non-interactive frontend
ARG DEBIAN_FRONTEND=noninteractive

# Set timezone to EST
ENV TZ=EST

# Update package lists and install required packages
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    curl \
    apt-utils \
    apt-transport-https \
    software-properties-common \
    g++ \
    vim \
    build-essential

# Install Node.js 16.x
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Install Google Chrome
RUN curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome-archive-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get -y install --no-install-recommends google-chrome-stable && apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /etc/apt/sources.list.d/google-chrome.list

# Create a user and switch to it
RUN useradd -ms /bin/bash node
USER node

# Create a directory for your project
RUN mkdir /tmp/webdriverio-test
WORKDIR /tmp/webdriverio-test

# Set npm registry and initialize the project
RUN npm config set https-proxy http://proxy.ebiz.verizon.com:80 && \
    npm config set http-proxy http://proxy.ebiz.verizon.com:80 && \
    npm config set registry http://registry.npmjs.org/
RUN npm init -y

# Install WebdriverIO CLI and any other dependencies
RUN npm install --save-dev @wdio/cli @wdio/sync
