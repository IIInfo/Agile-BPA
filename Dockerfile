FROM ppandyaiiinfo/agile-bpa-docker
MAINTAINER Triple-i
CMD [rm -r "/usr/local/tomcat/webapps/agile-bpa"]
ADD Code/deploy/agile-bpa.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
