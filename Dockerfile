FROM node:current-buster-slim

# Install packages
RUN apt-get update \
    && apt-get install -y supervisor dnsmasq

# Setup dnsmasq
COPY config/dnsmasq.conf /etc/dnsmasq.conf
    
# Setup app
RUN mkdir -p /app

# Add application
WORKDIR /app
COPY app .

# Install dependencies
RUN yarn

# Setup superivsord
COPY config/supervisord.conf /etc/supervisord.conf

# Expose the port node-js is reachable on
EXPOSE 1337

# Start the node-js application
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]