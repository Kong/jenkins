FROM mashape/jenkins@sha256:c994b42198f880778ee2518c666ab15b0848c80cabba007c1191cbfeb5bbf236

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
