# Filename: Dockerfile 
FROM openjdk:8-jdk

# Set timezone
ARG TIMEZONE="Asia/Bangkok"
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone

# Add Maintainer Info
LABEL maintainer="ariya.k@pttdigital.com"

# Add a volume pointing to /portal
VOLUME /portal

# Add user liferay
RUN useradd --user-group --create-home --shell /bin/false liferay

ADD /liferay-ce-portal-tomcat-7.3.0/liferay-ce-portal-7.3.0-ga1 /portal

RUN chown -R liferay:liferay /portal/*

RUN chmod +x /portal/tomcat-9.0.17/bin/*

RUN chgrp -R 0 /portal 

RUN chmod -R g+rwX /portal

EXPOSE 8080

USER liferay

ENTRYPOINT ["/portal/tomcat-9.0.17/bin/catalina.sh", "run"]
