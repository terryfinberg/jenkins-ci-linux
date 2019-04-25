#!/bin/bash
# change directory to /home/ec2-user (user home)
cd ~

# Print output to the console
echo "Paste Maven tar.gz download URL: "

# read input from the user to store as a variable
read maven
# http://apache.mirrors.pair.com/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz

# Print output to the console
echo "Paste Tomcat tar.gz download URL: "

# read input from the user to store as a variable
read tomcat
# http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.40/bin/apache-tomcat-8.5.40.tar.gz

# install Git using Yellowdog Update Manager
sudo yum install -y git

# check install succeeded
git --version

# use HTTP GET to fetch maven
wget $maven

# list contents of current directory
ls

# print working directory (where you are now)
pwd

m=${$maven##*/}
m2=${m::-6}
t=${$tomcat##*/}
t2=${t::-6}

# expands a gunzip file (tar means it is a folder and not a single file only)
tar -zxf ~/$m

# remove unneeded file
rm ~/$m

# rename files by moving them
mv ~/$m ~/maven

# use HTTP GET to fetch Tomcat
wget $tomcat

# expands gunzip file
tar -zxf ~/$t

# remove unneeded file
rm ~/$t

# rename files by moving them
mv ~/$t2 ~/tomcat

# add manager-gui role and tomcat user with this role.. 
# echo prints something and > pipes the content into the file 
# ( > overwrites while >> will concatenate)
echo "<?xml version='1.0' encoding='utf-8'?><tomcat-users><role rolename=\"manager-gui\"/><role rolename=\"manager-script\"/><user username=\"tomcat\" password=\"tomcat\" roles=\"manager-gui\"/><user username=\"maven\" password=\"maven\" roles=\"manager-script\"/></tomcat-users>" > tomcat/conf/tomcat-users.xml

# allow the remote access of Tomcat manager console
# removes the default RemoteAddrValve constraint
echo "<?xml version='1.0' encoding='UTF-8'?><Context antiResourceLocking=\"false\" privileged=\"true\"><Manager sessionAttributeValueClassNameFilter=\"java\.lang\.(?:Boolean|Integer|Long|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)>HashMap\"/></Context>" > tomcat/webapps/manager/META-INF/context.xml

# setup maven tomcat plugin credentials
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd\"><localRepository>/home/ec2-user/.m2/repository</localRepository><servers><server><id>maven</id><username>maven</username><password>maven</password></server></servers></settings>" > maven/conf/settings.xml

# install OpenJDK 8
sudo yum install -y java-1.8.0-openjdk-devel.x86_64

# creates an environment variable for this Shell session. 
# long-term variables can go into /etc/environment file
export JAVA_HOME=/usr/lib/jvm/java-openjdk

# print an environment variable with $variable_name
echo $JAVA_HOME

# use HTTP GET to fetch the latest Jenkins war
wget http://mirrors.jenkins.io/war/latest/jenkins.war

# moving a war into webapps folder will deploy the war
mv ~/jenkins.war ~/tomcat/webapps/jenkins.war

# executes a shell command to start Tomcat
sudo sh ~/tomcat/bin/startup.sh

# prints the Jenkins admin credentials
# this only works after browsing to your.aws.ip:8080/jenkins
# hence it is commented here
# sudo cat /root/.jenkins/secrets/initialAdminPassword
