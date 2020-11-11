FROM debian:10

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/provisioning/Dockerfile"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG ANSIBLE_VERSION=2.9.12
ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ARG TERRAFORM_VERSIONS=0.13.4,0.13.3
ENV TERRAFORM_VERSIONS=${TERRAFORM_VERSIONS}

RUN echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  # 
  # Set up locales
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  #
  # Install basic packages
  && apt-get install --assume-yes apt-utils curl dnsutils git jq openssh-client sudo tmux unzip zsh\
  && apt-get install --assume-yes apt-transport-https ca-certificates gnupg gnupg2 rsync software-properties-common\
  && apt-get install --assume-yes avahi-utils libnss-mdns\
  && apt-get install --assume-yes python3-pip python3-setuptools\
  # 
  # Install Docker CLI
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -\
  && add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"\
  && apt-get update\
  && apt-get install --assume-yes docker-ce-cli\
  # 
  # Install AWS CLI v.2
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"\
  && unzip /tmp/awscliv2.zip -d /tmp/\
  && /tmp/aws/install\
  && rm -rf /tmp/awscliv2.zip /tmp/aws/\
  && apt-get install --assume-yes groff less\
  && curl --location https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb\
  --output /tmp/session-manager-plugin.deb\
  --silent\
  && dpkg -i /tmp/session-manager-plugin.deb\
  # 
  # Install Google Cloud SDK
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -\
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"\
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
  && apt-get update\
  && apt-get install --assume-yes google-cloud-sdk\
  # for gsutil signurl
  && pip3 install pyopenssl\
  # 
  # Install tfenv
  && git clone --depth=1 https://github.com/tfutils/tfenv.git /usr/local/tfenv\
  && ls -1 /usr/local/tfenv/bin/ | xargs -IB ln -s /usr/local/tfenv/bin/B /usr/local/bin/B\
  # Install Terraform via tfenv
  && echo $TERRAFORM_VERSIONS | tr ',' '\n' | xargs -IV tfenv install V\
  # use the beginning version on the list
  && tfenv use ${TERRAFORM_VERSIONS%%,*}\
  #
  # Install Ansible
  && pip3 install ansible==${ANSIBLE_VERSION} ansible-lint\
  # 
  # Place empty .zshrc
  && touch /etc/skel/.zshrc

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
