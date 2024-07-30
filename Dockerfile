FROM openjdk:8-jre
# RUN apt-get update && apt-get install -y --no-install-recommends nano
EXPOSE 8111

RUN mkdir -p /opt
RUN wget -P /tmp https://github.com/sevdokimov/log-viewer/releases/download/v1.0.11/log-viewer-1.0.11.tar.gz
RUN tar zxfv /tmp/log-viewer-1.0.11.tar.gz -C /opt
RUN rm -f /tmp/log-viewer-1.0.11.tar.gz

# move expanded directory to a nicer location
RUN mv /opt/log-viewer-1.0.11 /opt/logviewer

# existing scripts is not sh-friendly, rewritten
COPY scripts/logviewer.sh /opt/logviewer/

WORKDIR /opt/logviewer
# RUN chmod +x /opt/logviewer/logviewer.sh
# ENTRYPOINT ["bash", "/opt/logviewer/logviewer.sh"]
ENTRYPOINT ["java", "-ea", "-Dlog-viewer.config-file=/opt/logviewer/config.conf", \
            "-jar","/opt/logviewer/lib/log-viewer-cli-1.0.11.jar", "startup"]
            