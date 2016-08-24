FROM daocloud.io/library/centos
RUN yum install wget vim gcc openssl openssl-devel pam-devel net-tools wget -y
RUN echo root:root | chpasswd
COPY soft/lzo-2.06.tar.gz lzo-2.06.tar.gz
COPY soft/openvpn-2.2.2.tar.gz openvpn-2.2.2.tar.gz
RUN tar -zxf lzo-2.06.tar.gz && cd lzo-2.06
RUN ./configure && make && make install 
RUN cd .. && rm -rf lzo-2.06
RUN tar -zxf openvpn-2.2.2.tar.gz && cd openvpn-2.2.2
RUN ./configure --prefix=/etc/ovpn && make && make install
RUN cd .. && rm -rf openvpn-2.2.2
