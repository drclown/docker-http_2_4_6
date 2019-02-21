FROM centos:7

MAINTAINER tpeyrou: thomaspeyrou@gmail.com

# Update the image with the latest packages (recommended)
RUN yum update -y; yum clean all && yum upgrade -y

# Install des packages
RUN yum install -y \
  gcc \
  make \
  perl \
  pcre-devel \
  zlib-devel \
  lua-devel \
  openssl-devel

# Install Development Tools for compile apache
#RUN yum -y groupinstall "Development Tools"

# Add bin httpd et apr
ADD bin/httpd-2.4.6-deps.tar.bz2 bin/httpd-2.4.6.tar.bz2 /tmp/

# Install d'Apache
WORKDIR /tmp/httpd-2.4.6

RUN ./configure \
    --prefix=/etc/httpd \
    --with-included-apr \
    --enable-asis \
    --enable-cgi \
    --enable-charset-lite \
    --enable-data \
    --enable-dav \
    --enable-deflate \
    --enable-dialup \
    --enable-echo \
    --enable-heartbeat \
    --enable-heartmonitor \
    --enable-log-forensic \
    --enable-lua \
    --enable-mime-magic \
    --with-mpm=prefork \
    --with-mpm=event \
    --with-mpm=worker \
    --enable-proxy-fdpass \
    --enable-reflector \
    --enable-slotmem-plain \
    --enable-ssl \
    --enable-suexec \
    --enable-usertrack \
    --enable-watchdog \
    --enable-rewrite

RUN make && make install

# On clean le répertoire /tmp de l'image
RUN rm -rf /tmp/*

# Lance apache
CMD ["/etc/httpd/bin/apachectl","-DFOREGROUND"]

