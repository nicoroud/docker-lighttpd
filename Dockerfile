FROM debian:latest

# uninstall non-critical packages
RUN apt-get update && \
apt-get install -y --no-install-recommends aptitude && \
apt-get purge -y $(aptitude search '~i!~M!~prequired!~pimportant!~R~prequired!~R~R~prequired!~R~pimportant!~R~R~pimportant!busybox!grub!initramfs-tools' | awk '{print $2}') && \
apt-get purge -y aptitude && \
apt-get autoremove -y --purge && \
apt-get install --no-install-recommends -y lighttpd

ADD lighttpd.conf /etc/lighttpd/
RUN lighttpd -t -f /etc/lighttpd/lighttpd.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/*

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
