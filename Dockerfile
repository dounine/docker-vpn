FROM daocloud.io/library/centos
RUN yum install wget vim gcc openssl openssl-devel pam-devel net-tools wget -y
RUN echo root:root | chpasswd
WORKDIR /
COPY soft /
RUN tar -zxf lzo-2.06.tar.gz && cd lzo-2.06 && ./configure && make && make install
RUN tar -zxf openvpn-2.2.2.tar.gz && cd openvpn-2.2.2 && ./configure --prefix=/etc/ovpn && make && make install
RUN tar -zxf easy-rsa.tar.gz && cp -rf easy-rsa /etc/ovpn
RUN rm -rf /soft

