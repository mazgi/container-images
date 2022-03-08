FROM debian:11

LABEL maintainer="docker@mazgi.com"
LABEL org.opencontainers.image.source="https://github.com/mazgi/dockerfiles/blob/main/Dockerfile.d/provisioning/Dockerfile"

# Set in non-interactive mode.
ENV DEBIAN_FRONTEND=noninteractive

ARG ANSIBLE_VERSION=2.10
ENV ANSIBLE_VERSION=${ANSIBLE_VERSION}
ARG OP_VERSION=1.12.4
ENV OP_VERSION=${OP_VERSION}
# https://www.terraform.io/downloads.html
ARG TERRAFORM_VERSIONS=1.1.6,1.0.6,0.15.5
ENV TERRAFORM_VERSIONS=${TERRAFORM_VERSIONS}

RUN : Prepare\
  && echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends\
  && apt-get update\
  # 
  # Set up locales
  && apt-get install --assume-yes locales procps dialog\
  && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen\
  && locale-gen\
  # 
  # Install basic packages
  && apt-get install --assume-yes\
  apt-utils curl dnsutils git jq openssh-client sudo tmux unzip zsh\
  build-essential\
  cargo\
  apt-transport-https ca-certificates gnupg gnupg2 rsync software-properties-common\
  avahi-utils libnss-mdns\
  libffi-dev\
  python3-pip python3-setuptools\
  python3-dev libssl-dev\
  && :
RUN : APT Repository [Docker]\
  # See https://docs.docker.com/engine/install/debian/
  && curl --fail --silent --show-error --location https://download.docker.com/linux/debian/gpg\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/docker-archive-keyring.gpg --import -\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable"\
  | tee /etc/apt/sources.list.d/docker.list > /dev/null\
  && :
RUN : APT Repository [Azure]\
  # See https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
  && curl --fail --silent --show-error --location https://packages.microsoft.com/keys/microsoft.asc\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/microsoft-keyring.gpg --import -\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main"\
  | tee /etc/apt/sources.list.d/azure-cli.list > /dev/null\
  && echo\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-keyring.gpg] https://packages.microsoft.com/repos/microsoft-debian-$(lsb_release -cs)-prod/ $(lsb_release -cs) main"\
  | tee /etc/apt/sources.list.d/microsoft-debian-prod.list > /dev/null\
  && :
RUN : APT Repository [Google Cloud]\
  # See https://cloud.google.com/sdk/docs/install#deb
  && curl --fail --silent --show-error --location https://packages.cloud.google.com/apt/doc/apt-key.gpg\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/cloud.google.gpg --import -\
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main"\
  | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list\
  && :
RUN : APT Repository [Helm]\
  # See https://helm.sh/docs/intro/install/#from-apt-debianubuntu
  && curl --fail --silent --show-error --location https://baltocdn.com/helm/signing.asc\
  | gpg --no-default-keyring --keyring /usr/share/keyrings/helm.gpg --import -\
  && echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main"\
  | tee -a /etc/apt/sources.list.d/helm-stable-debian.list\
  && :
RUN : Install Packages from Added Repositories\
  && apt-get update\
  # Azure
  && apt-get install --assume-yes azure-cli powershell\
  && pwsh -c 'Install-Module -AllowClobber -Force -Name Az'\
  # Docker
  && apt-get install --assume-yes docker-ce docker-ce-cli containerd.io\
  # Google Cloud
  && apt-get install --assume-yes google-cloud-sdk\
  # Helm
  && apt-get install --assume-yes helm\
  # for `gsutil signurl`
  && pip3 install pyopenssl\
  && :
RUN : Install AWS CLI v2\
  # See https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"\
  && unzip /tmp/awscliv2.zip -d /tmp/\
  && /tmp/aws/install\
  && rm -rf /tmp/awscliv2.zip /tmp/aws/\
  && apt-get install --assume-yes groff less\
  && curl --fail --silent --show-error --location https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb\
  --output /tmp/session-manager-plugin.deb\
  && dpkg -i /tmp/session-manager-plugin.deb\
  && :
RUN : Terraform\
  # Install tfenv
  && git clone --depth=1 https://github.com/tfutils/tfenv.git /usr/local/tfenv\
  && ls -1 /usr/local/tfenv/bin/ | xargs -IB ln -s /usr/local/tfenv/bin/B /usr/local/bin/B\
  # Install Terraform via tfenv
  && echo $TERRAFORM_VERSIONS | tr ',' '\n' | xargs -IV tfenv install V\
  # use the beginning version on the list
  && tfenv use ${TERRAFORM_VERSIONS%%,*}\
  && :
RUN : Ansible\
  # Install Ansible
  && pip3 install wheel\
  && pip3 install ansible==${ANSIBLE_VERSION} ansible-lint\
  && :
RUN :\
  # Install starship
  && curl "https://starship.rs/install.sh" -o "/tmp/install.sh"\
  && sh /tmp/install.sh --yes\
  && rm -rf /tmp/install.sh\
  && :
RUN :\
  # Install 1Password CLI
  && curl -fsSLO https://cache.agilebits.com/dist/1P/op/pkg/v${OP_VERSION}/op_linux_amd64_v${OP_VERSION}.zip\
  && unzip op_linux_amd64_v${OP_VERSION}.zip\
  && mv op /usr/local/bin/\
  && rm -rf op_linux_amd64_v${OP_VERSION}.zip op.sig\
  && :

COPY rootfs /

# Reset DEBIAN_FRONTEND to default(`dialog`).
# If you no need `dialog`, you can set `DEBIAN_FRONTEND=readline`.
# see also: man 7 debconf
ENV DEBIAN_FRONTEND=
