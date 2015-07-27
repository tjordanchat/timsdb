FROM centos:centos6

COPY  build_tools/explode_war /usr/local/bin/explode_war
COPY  build_tools/assemble_war /usr/local/bin/assemble_war
COPY  build_tools/instrument_jar /usr/local/bin/instrument_jar
COPY config /root/.ssh/config

RUN \
    set -x && \
    cd /root && \
    mkdir -p /root/.ssh && \
    yum clean metadata && \
    yum clean all && \
    yum -y install wget && \
    yum -y install tar && \
    yum -y install git && \
    mkdir -p /root/bin && \
    wget http://10.156.74.122:8081/nexus/service/local/repositories/thirdparty/content/misc/xidel/1.0/xidel-1.0.xidel && \
    mv xidel-1.0.xidel /usr/local/bin/xidel && \
    yum -y install java-1.7.0-openjdk && \
    wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo && \
    yum -y install apache-maven && \
    yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps && \
    chmod 700 /root/.ssh && \
    touch /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    yum -y groupinstall "Development Tools" && \
    yum -y install python-devel && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install shyaml && \
    yum -y install lynx && \
    yum -y install links && \
    yum -y install expect && \
    yum -y install xorg-x11-server-Xvfb && \
    yum -y install firefox ImageMagick && \
    dbus-uuidgen > /var/lib/dbus/machine-id && \
    wget http://mirrors.dotsrc.org/jpackage/5.0/generic/free/RPMS/emma-2.0-0.5312.4.jpp5.noarch.rpm && \
    rpm -Uvh emma-2.0-0.5312.4.jpp5.noarch.rpm && \
    yum -y install emma.noarch && \
    cp /usr/share/java/emma.jar /usr/lib/jvm/jre-1.6.0-openjdk.x86_64/lib/ext

ENV HOME /root
ENV DISPLAY :1
ENV M2_HOME /usr/local/apache-maven
ENV M3_HOME /usr/local/apache-maven
ENV PATH /usr/local/apache-maven/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79.x86_64/jre
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8

WORKDIR /root
