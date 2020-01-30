#!/bin/bash

while [ ! -f /var/jenkins_home/secrets/initialAdminPassword ]; do sleep 5; done
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' 127.0.0.1:8080/jnlpJars/jenkins-cli.jar)" != "200" ]]; do sleep 5; done

curl http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar > jenkins-cli.jar

PASSWORD=$(cat /var/jenkins_home/secrets/initialAdminPassword)

UPDATE_LIST=$( java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD list-plugins | grep -e ')$' | awk '{ print $1 }' ); 
if [ ! -z "${UPDATE_LIST}" ]; then 
    echo Updating Jenkins Plugins: ${UPDATE_LIST}; 
    java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD install-plugin ${UPDATE_LIST};
    java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD safe-restart;
fi

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' 127.0.0.1:8080/jnlpJars/jenkins-cli.jar)" != "200" ]]; do sleep 5; done
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD list-plugins | awk 'BEGIN { OFS = ":"}{print $1,$NF}' > /plugins.txt
