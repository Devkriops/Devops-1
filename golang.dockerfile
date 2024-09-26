# Use a base image
FROM centos:7

# Install necessary dependencies
RUN yum -y update && \
    yum install -y curl git && \
    yum clean all

# Install gvm (Go Version Manager)
RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash && \
    echo '[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"' >> /root/.bash_profile

# Load gvm
RUN /bin/bash -c "source /root/.bash_profile"

# Install specific Go versions
ENV GVM_ROOT /root/.gvm
ENV PATH $GVM_ROOT/bin:$PATH

RUN bash -c "source /root/.bash_profile && \
    gvm install go1.20 && \
    gvm install go1.21 && \
    gvm use go1.21 --default"

# Verify installation
RUN go version

# Set the default command
CMD ["/bin/bash"]
