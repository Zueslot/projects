FROM tomcat:9.0
COPY /var/jenkins_home/workspace/Declarative_pipeline/target/*.war /usr/local/tomcat/webapps
