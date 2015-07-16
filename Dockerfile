FROM gliderlabs/alpine:3.2
MAINTAINER Greg Allen code@firstandthird.com

# Install nginx, curl and entrykit
RUN apk-install curl nginx \
 && curl -Ls https://github.com/progrium/entrykit/releases/download/v0.2.0/entrykit_0.2.0_Linux_x86_64.tgz \
    | tar -zxC /bin \
 && entrykit --symlink

ENV DOCKER_GEN_VERSION 0.4.0
RUN curl -Ls https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
    | tar -C /usr/local/bin -xvz

COPY . /app/
WORKDIR /app/

# Configure Nginx the way we want
RUN rm -f /etc/nginx/nginx.conf \
    && ln -s /app/nginx.conf /etc/nginx/nginx.conf \
    && touch /etc/nginx/conf.d/envy.conf

ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["codep", "nginx", "/app/docker-events-handler"]
