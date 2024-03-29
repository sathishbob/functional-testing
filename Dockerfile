FROM bitnami/minideb-extras:latest-buildpack
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV BITNAMI_PKG_CHMOD="-R g+rwX" \
   BITNAMI_PKG_EXTRA_DIRS="/home/tomcat" \
   HOME="/"

# Install required system packages and dependencies
RUN install_packages libc6 libgcc1
RUN bitnami-pkg install java-1.8.212-0 --checksum 54a18672c8b4c1a44324c607a6bc616f614a062005d5e3384f91f10ff6f6edea
RUN bitnami-pkg unpack tomcat-8.0.53-22 --checksum b1d43ed61da81428e58d681fbf56c95e0130fff67193ca11e6d277297c2d4abe
RUN ln -sf /opt/bitnami/tomcat/data /app

COPY rootfs /
ENV BITNAMI_APP_NAME="tomcat" \
   BITNAMI_IMAGE_VERSION="8.0.53-debian-9-r252" \
   JAVA_OPTS="-Djava.awt.headless=true -XX:+UseG1GC -Dfile.encoding=UTF-8" \
   NAMI_PREFIX="/.nami" \
   PATH="/opt/bitnami/java/bin:/opt/bitnami/tomcat/bin:$PATH" \
   TOMCAT_AJP_PORT_NUMBER="8009" \
   TOMCAT_ALLOW_REMOTE_MANAGEMENT="0" \
   TOMCAT_HOME="/home/tomcat" \
   TOMCAT_HTTP_PORT_NUMBER="8080" \
   TOMCAT_PASSWORD="zippyops" \
   TOMCAT_SHUTDOWN_PORT_NUMBER="8005" \
   TOMCAT_USERNAME="zippyops"

EXPOSE 8080

#USER 1001
ADD target/*.war /opt/bitnami/tomcat/webapps
RUN ["sudo", "chmod", "+x", "/app-entrypoint.sh"]
#chmod +x app-entrypoint.sh
ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "nami", "start", "--foreground", "tomcat" ]
