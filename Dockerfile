FROM tomcat:9.0
COPY /var/jenkins_home/workspace/declarative/target/web-app.war /usr/local/tomcat/webapps
