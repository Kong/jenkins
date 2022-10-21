#!/bin/bash

set -e

if [ -n "${SKIP_S3:-}" ]; then
  echo "skipping s3 sync"
else
  aws s3 sync s3://kong-aws-ecs-jenkins/.ssh /root/.ssh
fi

chmod 500 /root/.ssh/id_rsa
git config --global user.name "Kong - Jenkins"
git config --global user.email office@konghq.com
ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
/usr/bin/tini -- /usr/local/bin/jenkins.sh
