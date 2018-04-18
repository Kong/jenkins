FROM jenkins/jenkins:lts

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY entrypoint.sh /entrypoint.sh
COPY .gitconfig /root/.gitconfig

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

[job-local "job-executed-on-current-host"]
schedule = @hourly
command = touch /tmp/example

CMD /bin/bash /entrypoint.sh
