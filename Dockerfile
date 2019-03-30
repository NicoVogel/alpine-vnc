FROM alpine:latest

# add newest librarys and update 
RUN apk -U update \
    && apk add librdkafka --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
    && apk add librdkafka --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

# install VNC & the desktop system
RUN apk add --no-cache x11vnc xvfb openbox xterm

# set up support for supervisord & our core users
RUN \
    apk add supervisor sudo && \
    addgroup alpine && \
    adduser -G alpine -s /bin/sh -D alpine && \
    echo "alpine:alpine" | /usr/sbin/chpasswd && \
    echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers && \
    mkdir -p /etc/supervisor/conf.d

# clean-up
RUN rm -Rf /tmp/* /var/cache/apk/*

# Configure init
COPY /assets/supervisord.conf /etc/supervisord.conf

# Openbox window manager
COPY assets/openbox/menu.xml /etc/xdg/openbox/menu.xml


EXPOSE 5900

# start the system
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

