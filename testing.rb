# Use a base image from Debian stretch
FROM debian:stretch

# Set metadata for the image
LABEL MAINTAINER="Your Name"

# Set environment variables for proxy
ENV http_proxy=http://proxy.ebiz.verizon.com:80
ENV https_proxy=http://proxy.ebiz.verizon.com:80
ENV no_proxy=.verizon.com

# Update packages and install necessary tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    g++ \
    vim \
    build-essential \
    apt-transport-https \
    curl

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt-get install -y nodejs npm

# Install Google Chrome stable version
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends google-chrome-stable

# Set npm configuration for proxy
RUN npm config set https-proxy http://proxy.ebiz.verizon.com:80 && \
    npm config set http-proxy http://proxy.ebiz.verizon.com:80 && \
    npm config set registry http://registry.npmjs.org/

# Initialize npm project
RUN npm init -y

# Install WebdriverIO CLI and necessary dependencies
RUN npm install --global --unsafe-perm=true --allow-root @wdio/cli @wdio/sync chromedriver

# Generate Configuration File
RUN npx wdio config -y

# Copy over pre-configured wdio.conf.js
COPY wdio.conf.js .

# Create Spec Directory
RUN mkdir -p ./test/specs

# Set default command to start a shell
CMD ["/bin/bash"]
