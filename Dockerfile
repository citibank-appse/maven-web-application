
FROM 3.6.1-jdk-8-alpine
WORKDIR /opt
COPY . .
RUN mvn clean install

FROM tomcat:latest
COPY --from=0 /opt/target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war/
