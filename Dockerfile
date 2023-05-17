FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y curl gnupg2

# Install Trivy
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

# Install Dive
RUN curl -L https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.tar.gz | tar -xvz \
    && mv dive /usr/local/bin/

# Install Grype
RUN curl -L https://github.com/anchore/grype/releases/latest/download/grype-linux-amd64 -o /usr/local/bin/grype \
    && chmod +x /usr/local/bin/grype

# Install Syft
RUN curl -L https://github.com/anchore/syft/releases/latest/download/syft-linux-amd64 -o /usr/local/bin/syft \
    && chmod +x /usr/local/bin/syft

# Install Dagda
#RUN curl -L https://github.com/eliasgranderubio/dagda/archive/refs/tags/v0.8.3.tar.gz | tar -xvz \
#    && mv dagda-0.8.3 /opt/dagda \
#    && ln -s /opt/dagda/dagda.py /usr/local/bin/dagda

# Install Anchore
RUN curl https://anchore.io/getting-started/install.sh | bash

# Install Clair
#RUN echo 'deb http://httpredir.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list \
#    && curl https://raw.githubusercontent.com/jessfraz/dockerfiles/master/jessie/usr/local/bin/add-apt-repository -o /usr/local/bin/add-apt-repository \
#    && chmod +x /usr/local/bin/add-apt-repository \
#    && add-apt-repository "deb http://httpredir.debian.org/debian stretch-backports main" \
#    && apt-get update \
#    && apt-get install -y clair

# Install Calico
RUN curl -O -L https://github.com/projectcalico/calicoctl/releases/download/v3.19.1/calicoctl \
    && chmod +x calicoctl \
    && mv calicoctl /usr/local/bin/

RUN apt install figlet

# Add script to provide tool selection
COPY scan-image.sh /scan-image.sh
RUN chmod +x /scan-image.sh

CMD [ "/bin/bash", "/scan-image.sh" ]
