FROM maven:3.9.1-eclipse-temurin-8-alpine
RUN 

FROM tomcat:8.0.20-jre8
COPY target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
