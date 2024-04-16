#FROM go0v-vzdocker.oneartifactoryprod.verizon.com/artifactory/go0v-vzdocker/debian/stretch-20210408-slim
FROM go0v-vzdocker.oneartifactoryprod.verizon.com/debian:stretch-20210408-slim
LABEL MAINTAINER="Tim Raphael"

ARG http_proxy=http://proxy.ebiz.verizon.com:80
ARG https_proxy=http://proxy.ebiz.verizon.com:80
ARG no_proxy=.verizon.com

RUN apt-get update && apt-get upgrade -y && apt-get install -q -y --fix-missing \
    g++ \
    vim \
    build-essential \
    apt-transport-https \
    curl
RUN curl -sL https://deb.nodesource.com/setup_15.x |  bash -
RUN cat /etc/apt/sources.list.d/nodesource.list
RUN apt-get install -y  nodejs npm
# Install latest (currently 87 which matches ZAP webdriverlinux23.zap plugin)
#RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -q -y --allow-unauthenticated --fix-missing \
    google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

# Remove due to twistlock concerts of a private key.
#RUN rm /usr/share/doc/libnet-ssleay-perl/examples/server_key.pem

# Run the following as the node user.
RUN useradd -ms /bin/bash node
USER node

# Create a directory where all the node packages and test will be executed from.
RUN mkdir /tmp/webdriverio-test
WORKDIR /tmp/webdriverio-test

RUN npm config set https-proxy http://proxy.ebiz.verizon.com:80 && npm config set http-proxy http://proxy.ebiz.verizon.com:80 && npm config set registry http://registry.npmjs.org/
RUN npm init -y

# Install WebdriverIO CLI
RUN npm i --save-dev @wdio/cli
RUN npm i --save-dev @wdio/sync
RUN npm i chromedriver --detect_chromedriver_version

# Generate Configuration File
RUN npx wdio config -y

# Copy over pre-configured wdio.conf.js
COPY wdio.conf.js wdio.conf.js

# Create Spec Dir
RUN mkdir -p ./test/specs 

# Twistlock issue.
#RUN rm /tmp/webdriverio-test/node_modules/lazystream/secret

CMD ["/bin/bash"]
