# Use the official Ubuntu as a base image
FROM ubuntu

# Set non-interactive mode for package installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package repositories and install required packages
RUN apt-get update && apt-get install -y \
    firefox \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install GeckoDriver
RUN apt-get update && apt-get install -y wget && \
    wget -O geckodriver-v0.29.1-linux64.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v0.29.1-linux64.tar.gz && \
    tar -xzf geckodriver-v0.29.1-linux64.tar.gz -C /usr/local/bin/ && \
    rm geckodriver-v0.29.1-linux64.tar.gz && \
    chmod +x /usr/local/bin/geckodriver && \
    apt-get remove -y wget && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm
RUN apt-get update && apt-get install -y \
    curl \
    && curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a directory for your project
WORKDIR /app

# Copy your WebDriverIO configuration and test files into the container
COPY wdio.conf.js .
COPY your_test_files_directory /app/your_test_files_directory

# Install WebDriverIO and its dependencies
RUN npm install webdriverio

# Set the entry point for your Docker container
CMD ["npx", "wdio", "--bail", "1", "wdio.conf.js"]
