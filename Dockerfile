FROM ppandyaiiinfo/agile-bpa-docker
MAINTAINER Triple-i
ADD deploy/agile-bpa.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
