# Use a base image (e.g., CentOS or Ubuntu)
FROM ubuntu:20.04

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Define Go versions to install
ENV GO_VERSIONS=(
    "1.17.6"
    "1.18.3"
)

# Create directories for each Go version
RUN mkdir -p /usr/local/go1.17.6 /usr/local/go1.18.3

# Download and install each Go version
RUN for version in ${GO_VERSIONS[@]}; do \
        wget -q https://golang.org/dl/go$version.linux-amd64.tar.gz && \
        tar -C /usr/local/go$version --strip-components=1 -xzf go$version.linux-amd64.tar.gz && \
        rm go$version.linux-amd64.tar.gz; \
    done

# Create a script to switch Go versions
RUN echo '#!/bin/bash\n\
if [ -z "$1" ]; then\n\
  echo "Please specify a Go version, e.g., setgo.sh 1.17.6"\n\
  exit 1\n\
fi\n\
export GOROOT=/usr/local/go$1\n\
export PATH=$GOROOT/bin:$PATH\n\
go version\n' > /usr/local/bin/setgo.sh && \
chmod +x /usr/local/bin/setgo.sh

# Set the default Go version (optional)
ENV GOROOT=/usr/local/go1.17.6
ENV PATH=$GOROOT/bin:$PATH

# Default command
CMD ["bash"]
