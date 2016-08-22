FROM daocloud.io/library/centos
RUN yum install wget -y
RUN echo root:root | chpasswd
