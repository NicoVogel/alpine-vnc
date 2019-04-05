FROM alpine:latest

# install VNC & the desktop system
# set up support for supervisord & our core users
RUN apk -U update && \
    apk add --no-cache x11vnc xvfb openbox xterm\
    apk add supervisor sudo && \
    addgroup alpine && \
    adduser -G alpine -s /bin/sh -D alpine && \
    echo "alpine:alpine" | /usr/sbin/chpasswd && \
    echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers && \
    mkdir -p /etc/supervisor/conf.d

# Configure init
COPY /assets/supervisord.conf /etc/supervisord.conf

# Openbox window manager
COPY assets/menu.xml /etc/xdg/openbox/menu.xml

EXPOSE 5900

# start the system
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

