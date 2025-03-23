FROM tomcat:9.0
COPY /var/jenkins_home/workspace/declarative/target/*.war /usr/local/tomcat/webapps
