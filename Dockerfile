FROM 3.6.3-openjdk-17-slim
WORKDIR /rajesh
COPY ..
RUN mvn clean install

FROM tomcat:8.0.20-jre8
COPY /rajeshtarget/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
