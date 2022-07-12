FROM mashape/jenkins:latest

USER root
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

COPY entrypoint.sh /entrypoint.sh
COPY .gitconfig /root/.gitconfig

RUN apt-get update && \
    apt-get install -qy ca-certificates python-pip groff-base && \
    update-ca-certificates && \
    pip install awscli

CMD /bin/bash /entrypoint.sh