FROM jenkins/jenkins:2.347@sha256:24118114fa3235905fce84748b630e72f4c8bcd2b2881f2bc16199e19ff4ecc7

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
