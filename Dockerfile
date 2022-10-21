FROM jenkins/jenkins:2.347@sha256:24118114fa3235905fce84748b630e72f4c8bcd2b2881f2bc16199e19ff4ecc7

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

# set to any string to skip s3 skip in entrypoint.sh
ARG SKIP_S3
ENV SKIP_S3=${SKIP_S3}

COPY entrypoint.sh /entrypoint.sh
COPY .gitconfig /root/.gitconfig

COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --verbose -f /usr/share/jenkins/ref/plugins.txt

RUN set -ex; \
    apt-get update -y -qq && \
    apt-get install -y -qq wget unzip && \
    cd /tmp && \
    wget -nv "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \
    unzip -q awscli-*.zip && \
    ./aws/install && aws --version

CMD /bin/bash /entrypoint.sh
