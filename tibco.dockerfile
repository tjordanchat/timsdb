FROM centos:centos6

WORKDIR /root

ENV HOME /root
ENV TIBCO_HOME /opt/tibco/DSEngine/work/jbccllbre101-0/tibco
ENV PATH  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/tibco/DSEngine/work/jbccllbre101-0/tibco/tra/5.8/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64/jre
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
ENV DISPLAY :1

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh
RUN touch /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

COPY ssh_config /root/.ssh/config
COPY autocheckin_build /root/autocheckin_build
COPY iAPIClient.projlib /root/iAPIClient.projlib

RUN \
    yum -y install java-1.7.0-openjdk-devel && \
    yum -y install wget && \
    yum -y install tar && \
    yum -y install git && \
    yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts" && \
    yum -y install xorg-x11-server-Xvfb && \
    yum -y install firefox && \
    yum -y groupinstall "Development Tools" && \
    yum -y install python-devel && \
    wget http://10.156.74.122:8081/nexus/service/local/repositories/thirdparty/content/misc/tibco.tar/1.0/tibco.tar-1.0.gz && \
    tar xvzf tibco.tar-1.0.gz -C /opt && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install shyaml && \
    wget http://pyyaml.org/download/libyaml/yaml-0.1.5.tar.gz && \
    tar xzvf yaml-0.1.5.tar.gz && \
    rm -f yaml-0.1.5.tar.gz && \
    cd yaml-0.1.5 && \
    ./configure && \
    make && \
    make install && \
    cd && \
    wget http://pyyaml.org/download/pyyaml/PyYAML-3.11.tar.gz && \
    tar xzvf PyYAML-3.11.tar.gz && \
    rm -f PyYAML-3.11.tar.gz && \
    cd PyYAML-3.11 && \
    python setup.py install && \
    yum -y install ImageMagick && \
    dbus-uuidgen > /var/lib/dbus/machine-id && \
    yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps 

CMD cd /opt/tibco/DSEngine_INT && \
    ./configure.sh -s 10.156.74.33:8080 && \
    ./engine.sh start && \
    /usr/bin/Xvfb :1 -screen 0 1024x768x24 & 
