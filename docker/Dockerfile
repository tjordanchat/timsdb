# AutoCheckin
FROM centos:centos6

WORKDIR /root

ADD tibco_build_files/tibco.tar.gz /opt/

ENV HOME /root
ENV TIBCO_HOME /opt/tibco/DSEngine/work/jbccllbre101-0/tibco
ENV PATH  /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/tibco/DSEngine/work/jbccllbre101-0/tibco/tra/5.8/bin
ENV JAVA_HOME /usr/lib/jvm/java-1.6.0-openjdk.x86_64/jre
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
ENV DISPLAY :1

RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh

COPY ssh_config /root/.ssh/config
COPY autocheckin_build /root/autocheckin_build
COPY bwengine.tra /root/bwengine.tra

RUN \
    set -x && \
    yum -y install java-1.6.0-openjdk-devel && \
    yum -y install wget && \
    yum -y install tar && \
    yum -y install git && \
    yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts" && \
    yum -y install xorg-x11-server-Xvfb && \
    yum -y install firefox

RUN rm -f /opt/tibco/DSEngine/work/jbccllbre101-0/tibco/bw/5.11/bin/bwengine.tra && \
    cp -f /root/bwengine.tra /opt/tibco/DSEngine/work/jbccllbre101-0/tibco/bw/5.11/bin && \
    rm -f /opt/tibco/DSEngine/work/jbccllbre101-0/tibco/designer/5.8/bin/designer.tra && \
    cp -f /root/designer.tra /opt/tibco/DSEngine/work/jbccllbre101-0/tibco/designer/5.8/bin/designer.tra 

RUN cd /opt/tibco/DSEngine_INT && \
    ./configure.sh -s 10.156.74.33:8080 && \
    ./engine.sh start && \
    /usr/bin/Xvfb :1 -screen 0 1024x768x24 & firefox & 


CMD ["/bin/bash"]
