FROM 3.6.1-alpine
RUN  apk install java-11-openjdk-devel -y && apk install wget curl unzip -y
WORKDIR /rajesh
RUN mvn clean install && mvn clean package
RUN wget wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.71/bin/apache-tomcat-9.0.71.zip
RUN unzip apache-tomcat-9.0.71.zip
RUN cd /rajesh/apache-tomcat-9.0.71/bin
RUN chmod u+x *.sh
RUN ln -s /rajesh/apache-tomcat-9.0.71/bin/startup.sh /usr/bin/startTomcat
RUN ln -s /rajesh/apache-tomcat-9.0.71/bin/shutdown.sh /usr/bin/stopTomcat
CMD ["startTomcat"]
COPY . .
