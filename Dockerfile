FROM ubuntu:18.04

WORKDIR /opt/

#COPY ./axis .
RUN apt-get update && apt-get install -y vim
RUN apt-get install -y default-jdk 
RUN apt-get install -y openjdk-8-jdk 
#RUN apt-get install -y openjdk-8-doc 
#RUN apt-get install -y openjdk-8-jre-lib 
RUN apt-get install -y ant 
RUN apt-get install -y apt-utils
RUN apt-get install -y wget
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

#WORKDIR /usr/local/tomcat/bin




ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV AXIS2_HOME /opt/axis2
ENV AXIS2_LIB /opt/tomcat/webapps-javaee/axis2/WEB-INF/lib
ENV MAVEN_HOME /opt/maven
ENV M2_HOME /opt/maven
#ENV CLASSPATH ${AXIS2_LIB}:${JAVA_HOME}/lib
#WORKDIR /usr/lib/jvm/java-11-openjdk-amd64/
ENV PATH ${PATH}:${JAVA_HOME}/bin:${AXIS2_HOME}/bin:${M2_HOME}/bin
ENV CLASSPATH ${AXIS2_LIB}/axis2-transport-http-1.8.2.jar:${AXIS2_LIB}/*.jar
ENV wsdl https://snia.mop.gob.cl/controlextraccion/wsdl/datosExtraccion/SendDataExtraccionService?wsdl

COPY ./apache-tomcat-10.0.23/ /opt/tomcat/
COPY ./axis2/ /opt/axis2/
COPY ./maven /opt/maven/
COPY ./axis2-1.8.2/ /home/axis2-1.8.2

WORKDIR /opt/axis2/webapp/
RUN ant create.war

WORKDIR /opt/tomcat/
RUN mkdir /opt/tomcat/webapps-javaee/
RUN cp /opt/axis2/dist/axis2.war /opt/tomcat/webapps-javaee/
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r conf
RUN chmod g+x conf
RUN chown -R tomcat webapps-javaee/ work/ temp/ logs/

#COPY ./tomcat.service /etc/systemd/system/

WORKDIR /opt/tomcat/bin
CMD [ "/bin/bash"]


#RUN ./startup.sh

#RUN export JAVA_HOME
#ENV PATH=$PATH:/etc/lib/jvm/java-11-openjdk-amd64
#RUN ["./startup.sh"]

EXPOSE 8080

