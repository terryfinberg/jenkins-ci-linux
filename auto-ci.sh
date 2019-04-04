#!/bin/bash
cd ~
sudo yum install -y git
git --version
wget "http://mirrors.gigenet.com/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz"
ls
pwd
tar -zxvf apache-maven-3.6.0-bin.tar.gz
mv apache-maven-3.6.0 maven
wget "http://mirror.reverse.net/pub/apache/tomcat/tomcat-8/v8.5.39/bin/apache-tomcat-8.5.39.tar.gz"
tar -zxvf apache-tomcat-8.5.39.tar.gz
mv apache-tomcat-8.5.39 tomcat
echo "<?xml version='1.0' encoding='utf-8'?><tomcat-users><role rolename=\"manager-gui\"/><role rolename=\"manager-script\"/><user username=\"tomcat\" password=\"tomcat\" roles=\"manager-gui\"/><user username=\"maven\" password=\"maven\" roles=\"manager-script\"/></tomcat-users>" > tomcat/conf/tomcat-users.xml
echo "<?xml version='1.0' encoding='UTF-8'?><Context antiResourceLocking=\"false\" privileged=\"true\"><Manager sessionAttributeValueClassNameFilter=\"java\.lang\.(?:Boolean|Integer|Long|String)|org\.apache\.catalina\.filters\.CsrfPreventionFilter\$LruCache(?:\$1)?|java\.util\.(?:Linked)>HashMap\"/></Context>" > tomcat/webapps/manager/META-INF/context.xml
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd\"><localRepository>/home/ec2-user/.m2/repository</localRepository><servers><server><id>maven</id><username>maven</username><password>maven</password></server></servers></settings>" > maven/conf/settings.xml
sudo yum install -y java-1.8.0-openjdk-devel.x86_64
export JAVA_HOME=/usr/lib/jvm/java-openjdk
echo $JAVA_HOME
wget http://mirrors.jenkins.io/war/latest/jenkins.war
mv jenkins.war tomcat/webapps/jenkins.war
sudo sh tomcat/bin/startup.sh
sudo cat /root/.jenkins/secrets/initialAdminPassword


