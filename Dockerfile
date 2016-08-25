FROM daocloud.io/library/centos
RUN yum install wget expect vim gcc openssl openssl-devel pam-devel net-tools wget -y
RUN echo root:root | chpasswd
WORKDIR /
COPY soft /
WORKDIR /soft
RUN tar -zxf lzo-2.06.tar.gz && cd lzo-2.06 && ./configure && make && make install
RUN tar -zxf openvpn-2.2.2.tar.gz && cd openvpn-2.2.2 && ./configure --prefix=/etc/ovpn && make && make install
RUN tar -zxf easy-rsa.tar.gz && cp -rf easy-rsa /etc/ovpn
#rename
WORKDIR /etc/ovpn/easy-rsa
RUN rm -rf Windows && mv 2.0/* . -f && rm -rf 2.0
#copy server.conf to /etc/ovpn
COPY conf/server.conf /etc/ovpn
COPY conf/vpnstart.sh /etc/ovpn
COPY conf/createovpn.sh /etc/ovpn
RUN chmod 755 /etc/ovpn/vpnstart.sh /etc/ovpn/vpnstart.sh
#set openvpn path
RUN echo "#set vpn path" >> /root/.bash_profile
RUN echo "OVPN_HOME=/etc/ovpn" >> /root/.bash_profile
RUN echo "export PATH="'$'"OVPN_HOME/sbin:"'$'"PATH" >> /root/.bash_profile
RUN echo "alias vpnstart='/bin/bash /etc/ovpn/vpnstart.sh'" >> /root/.bash_profile
RUN source /root/.bash_profile
RUN rm -rf /soft
