FROM jenkins/jenkins:2.346.2@sha256:da871f844343306a0557363e858036acbe3f5016622eb2c9ff0c8bfd8c0edfcf

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY entrypoint.sh /entrypoint.sh
COPY .gitconfig /root/.gitconfig

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

RUN apt-get update && apt-get install -qy python3-pip groff-base
RUN pip install awscli

CMD /bin/bash /entrypoint.sh
