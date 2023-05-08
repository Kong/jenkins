FROM jenkins/jenkins:2.403

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

COPY entrypoint.sh /entrypoint.sh
COPY .gitconfig /root/.gitconfig

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN set -ex; \
    jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt && \
    jenkins-plugin-cli --list

RUN set -ex; \
    apt-get update -y -qq && \
    apt-get install -y -qq wget unzip && \
    cd /tmp && \
    wget -nv "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \
    unzip -q awscli-*.zip && \
    ./aws/install && aws --version

CMD /bin/bash /entrypoint.sh
