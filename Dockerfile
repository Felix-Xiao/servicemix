# This for servicemix under ubuntu 14.04.2
FROM ubuntu:14.04.2
MAINTAINER Felix
# Install Java.
RUN \
  apt-get -y update && \
  apt-get install -y unzip && \
  apt-get install -y wget && \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV SERVICEMIX_VERSION_MAJOR=6
ENV SERVICEMIX_VERSION_MINOR=1
ENV SERVICEMIX_VERSION_PATCH=2
ENV SERVICEMIX_VERSION=${SERVICEMIX_VERSION_MAJOR}.${SERVICEMIX_VERSION_MINOR}.${SERVICEMIX_VERSION_PATCH}

# Define default command.
#CMD ["bash"]
# RUN wget http://159.99.203.31/alam/servicemix/servicemix-$
RUN wget http://mirror.nexcess.net/apache/servicemix/servicemix-${SERVICEMIX_VERSION_MAJOR}/${SERVICEMIX_VERSION}/apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    unzip -d /opt apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    rm -f apache-servicemix-${SERVICEMIX_VERSION}.zip; \
    ln -s /opt/apache-servicemix-${SERVICEMIX_VERSION} /opt/servicemix; \
    mkdir /deploy; \
    sed -i 's/^\(felix\.fileinstall\.dir\s*=\s*\).*$/\1\/deploy/' /opt/servicemix/etc/org.apache.felix.fileinstall-deploy.cfg

VOLUME ["/deploy"]
EXPOSE 22 1099 8101 8181 8081 80
ENTRYPOINT bash -c "ifconfig && cd /opt/servicemix/bin && ./servicemix"