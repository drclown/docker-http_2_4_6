FROM centos:7

MAINTAINER tpeyrou: thomaspeyrou@gmail.com

# Update the image with the latest packages (recommended)
RUN yum update -y; yum clean all && yum upgrade -y

# Install des packages
RUN yum install -y \
  gcc \
  make \
  perl \
  pcre-devel

# Install Development Tools for compile apache
#RUN yum -y groupinstall "Development Tools"

# Add bin httpd et apr
ADD bin/httpd-2.4.6-deps.tar.bz2 bin/httpd-2.4.6.tar.bz2 /tmp/

# Install d'Apache
WORKDIR /tmp/httpd-2.4.6

RUN ./configure \
    --prefix=/etc/httpd \
    --with-included-apr \
    --enable-asis

RUN make && make install
