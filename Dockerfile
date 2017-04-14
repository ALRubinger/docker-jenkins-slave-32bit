FROM openshift/jenkins-slave-maven-centos7:latest
MAINTAINER Andrew Lee Rubinger<alr@redhat.com>

USER root

# Install 32bit JDK, removing 64bit
RUN INSTALL_PKGS="java-1.8.0-openjdk.i686 java-1.8.0-openjdk-devel.i686" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V ${INSTALL_PKGS//\*/} && \
    rpm -e java-1.8.0-openjdk.x86_64 --nodeps && \
    rpm -e java-1.8.0-openjdk-devel.x86_64 --nodeps && \
    rpm -e java-1.8.0-openjdk-headless.x86_64 --nodeps && \
    yum clean all -y && \
    echo `java -version`

# Set MAVEN_OPTS
ENV MAVEN_OPTS=-Xmx128m

USER 1001
