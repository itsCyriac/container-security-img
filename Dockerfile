FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y curl gnupg2

# Install Anchore
RUN curl https://anchore.io/getting-started/install.sh | bash

RUN apt install figlet

# Add script to provide tool selection
COPY scan-image.sh /scan-image.sh
RUN chmod +x /scan-image.sh

CMD [ "/bin/bash", "/scan-image.sh" ]
