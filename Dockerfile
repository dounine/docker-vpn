FROM daocloud.io/library/centos
RUN yum install iptables-services wget expect vim gcc openssl openssl-devel pam-devel net-tools wget -y
RUN echo root:root | chpasswd
RUN mkdir /soft
WORKDIR /soft
COPY soft /soft
WORKDIR /soft
RUN tar -zxf lzo-2.06.tar.gz && cd lzo-2.06 && ./configure && make && make install
RUN tar -zxf openvpn-2.3.12.tar.gz && cd openvpn-2.3.12 && ./configure --prefix=/etc/ovpn && make && make install
RUN tar -zxf easyrsa.tar.gz && cp -rf easyrsa /etc/ovpn
#rename
WORKDIR /etc/ovpn/easyrsa
#copy server.conf to /etc/ovpn
COPY conf/server.conf /etc/ovpn/
COPY conf/*.sh /etc/ovpn/
COPY conf/easyrsa/*.sh /etc/ovpn/easyrsa/
COPY conf/psw-file /etc/ovpn/
RUN cd /etc/ovpn/easyrsa && bash auto-init.sh
WORKDIR /etc/ovpn/
#set create ta.key
RUN /etc/ovpn/sbin/openvpn --genkey --secret /etc/ovpn/easyrsa/pki/ta.key
#create client ovpn
RUN bash createovpn.sh
#set openvpn path
RUN echo "#set vpn path" >> /root/.bash_profile
RUN echo "OVPN_HOME=/etc/ovpn" >> /root/.bash_profile
RUN echo "export PATH="'$'"OVPN_HOME/sbin:"'$'"PATH" >> /root/.bash_profile
RUN source /root/.bash_profile
#set disabled firewalld
RUN chmod +x /etc/rc.d/rc.local
RUN systemctl disable firewalld.service
RUN systemctl enable iptables.service
RUN sed -i '11a\-A INPUT -p tcp --dport replace_port -j ACCEPT' /etc/sysconfig/iptables
COPY run.sh /
RUN chmod +x /run.sh
RUN echo "bash /run.sh" >> /etc/rc.local
#RUN rm -rf /soft
CMD ["/sbin/init"]
