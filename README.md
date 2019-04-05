# Alpine-VNC

This is a simple and small alpine image which will be used as basis for other projects. It uses *x11vnc* for VNC and *openbox* as desktop.

If you want to change the openbox right click menu, override the file */etc/xdg/openbox/menu.xml* in the image.

If you use this image as base image and override the CMD, make sure, that the following command is called, Otherwise vnc will not work.

````bash
/usr/bin/supervisord -c /etc/supervisord.conf
````
