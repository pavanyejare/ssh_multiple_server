
FROM	centos:centos6  
# Pull the Image from docker

#Install Python2.7 
RUN	yum groupinstall "Development tools" -y     
RUN	yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel wget 
#Installed Dependency packages 
#dowanload and installed python source code package
RUN	cd /tmp && wget https://www.python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz 
RUN	["tar", "xf", "/tmp/Python-2.7.14.tar.xz", "-C", "/tmp"]
RUN	cd /tmp/Python-2.7.14 ; ./configure --prefix=/usr/local && make  && make install	


# Installing Mongo DB
#Added yum repo for mongo db and installed uding yum 

RUN	echo "[mongodb-org-3.4]" >> /etc/yum.repos.d/mongodb.repo
RUN     echo "name=MongoDB 3.4 Repository" >> /etc/yum.repos.d/mongodb.repo
RUN     echo "baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/3.4/x86_64/" >> /etc/yum.repos.d/mongodb.repo
RUN     echo "gpgcheck=0" >> /etc/yum.repos.d/mongodb.repo
RUN     echo "enabled=1" >> /etc/yum.repos.d/mongodb.repo
RUN	yum install -y mongodb-org

#Installing Tomacat7
#Tomacat required java so installed first java 1.8 
#dowanload tomact and extracted and stored in /usr/local directory
RUN	yum install -y java-1.8.0-openjdk
RUN	cd /tmp && wget http://www-us.apache.org/dist/tomcat/tomcat-7/v7.0.84/bin/apache-tomcat-7.0.84.tar.gz && tar -xvzf apache-tomcat-7.0.84.tar.gz
RUN	mv /tmp/apache-tomcat-7.0.84 /usr/local/tomcat7

#Post Setup
#opened mongodb and tomact port to outside network 
EXPOSE	27017
EXPOSE	8080
#ENTRYPOINT	["service", "mongod", "start"]
#ENTRYPOINT	["/usr/local/tomcat7/bin/startup.sh"]
RUN 	echo "service mongod start" >> /etc/rc.d/rc.local
RUN	echo "/usr/local/tomcat7/bin/startup.sh" >> /etc/rc.d/rc.local
#CMD	["/bin/sh","/etc/rc.d/rc.local"]
CMD	["/bin/sh","-c"]


