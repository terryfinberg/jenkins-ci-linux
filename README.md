# Auto CI for Jenkins on a Linux Machine
Shell script to automatically download and install all required tools to kickstart a basic CI pipeline

## Basic Setup
Clone this repository using `git clone https://github.com/pjw6193/jenkins-ci-linux.git`.
Give run permissions to this file with: `chmod 111 auto-ci.sh`
Run the script with `sh auto-ci.sh`

## Setup Jenkins 
Navigate to your Jenkins with http://your.aws.ip:8080/jenkins
Follw their instructions there.

## Tools Installed
You will have OpenJDK, Maven, Git, and Jenkins latest running on Tomcat 8.

## Troubleshooting
The only issues with the script is if the Tomcat or Maven download URLs change. In this case, find the 2 `wget` statements and update the URLs accordingly.
