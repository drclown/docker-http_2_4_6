FROM centos:7

MAINTAINER tpeyrou: thomaspeyrou@gmail.com

# Update the image with the latest packages (recommended)
#RUN yum update -y; yum clean all

# Add bin httpd
ADD bin/httpd-2.4.6 /tmp/httpd-2.4.6

WORKDIR

#RUN yum -y groupinstall "Development Tools"