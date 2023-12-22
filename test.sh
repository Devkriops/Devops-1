#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract value associated with "risk-3" and "High"
awk -F'</?div>' '/<td class="risk-3">/{getline; risk_value=$2; found_risk=1} /<td align="center">/{if(found_risk) {getline; center_value=$2; exit}} END {if (found_risk) print center_value}' "$html_file" | while read -r risk3_value; do
    quality_gate="yes"  # Set this variable based on your criteria
    
    if [[ "$quality_gate" == "yes" ]]; then
        if [[ "$risk3_value" == "0" ]]; then
            echo "Quality Gate Parameter: Yes"
            echo "Risk-3 Value: $risk3_value"
            echo "Success"
        else
            echo "Quality Gate Parameter: Yes"
            echo "Risk-3 Value: $risk3_value"
            echo "Failed"
            exit 1  # Exit the script with an error code
        fi
    elif [[ "$quality_gate" == "nothing" ]]; then
        echo "Quality Gate Parameter: Nothing"
        echo "Risk-3 Value: $risk3_value"
    else
        echo "Invalid quality gate parameter"
        exit 1  # Exit the script with an error code
    fi
done

------------------------------------

#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract value associated with "risk-3" and "High"
awk -F'</?div>' '/<td class="risk-3">/{getline; risk_value=$2; found_risk=1} /<td align="center">/{if(found_risk) {getline; center_value=$2; print "Risk-3 Value: " center_value; exit}}' "$html_file"
------------------------------------
FROM registry.redhat.io/ubi8/ubi-minimal:8.4

# Install required packages
RUN microdnf install -y openssh-server openssh-clients openssl

# Download and install OpenSSH 8.1
ADD https://openbsd.cs.toronto.edu/pub/OpenBSD/OpenSSH/portable/openssh-8.1p1.tar.gz /tmp
WORKDIR /tmp
RUN tar -xzvf openssh-8.1p1.tar.gz && \
    cd openssh-8.1p1 && \
    ./configure && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf openssh-8.1p1 openssh-8.1p1.tar.gz

# Download and install OpenSSL 3.0.7
ADD https://www.openssl.org/source/openssl-3.0.7.tar.gz /tmp
WORKDIR /tmp
RUN tar -xzvf openssl-3.0.7.tar.gz && \
    cd openssl-3.0.7 && \
    ./config && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf openssl-3.0.7 openssl-3.0.7.tar.gz

# Cleanup
RUN microdnf clean all

# Configure SSH
RUN mkdir /var/run/sshd
RUN ssh-keygen -A

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
