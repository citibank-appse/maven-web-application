FROM maven:3.6.1-jdk-8-alpine
WORKDIR /rajesh
COPY . .
RUN mvn clean install
RUN whoami

FROM tomcat:8.0.20-jre8
COPY --from=0 target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
