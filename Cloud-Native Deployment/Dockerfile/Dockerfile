FROM tomcat:9.0-jdk11-openjdk-slim

WORKDIR /usr/local/tomcat/webapps

ADD https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war /usr/local/tomcat/webapps/

EXPOSE 80

CMD ["catalina.sh", "run"]