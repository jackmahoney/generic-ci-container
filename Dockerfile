FROM node:10-stretch

# prepare apt-get
RUN apt-get update
RUN apt-get install -y software-properties-common

# install swagger codegen
RUN apt-get install wget
RUN wget http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/2.3.1/swagger-codegen-cli-2.3.1.jar -O /usr/bin/swagger-codegen-cli.jar
RUN echo -e '#!/usr/bin/env sh\njava -jar /usr/bin/swagger-codegen-cli.jar "$@"' | tee --append /usr/bin/swagger-codegen
RUN chmod a+x /usr/bin/swagger-codegen

# install java 10
RUN echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | tee /etc/apt/sources.list.d/linuxuprising-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 73C3DB2A
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java10-installer
RUN apt-get install -y oracle-java10-set-default

# install terraform
RUN apt-get install -y unzip
RUN wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
RUN unzip terraform_0.11.8_linux_amd64.zip
RUN mv terraform /usr/local/bin/

# install aws cli
# RUN apt-get install -y python-setuptools
# RUN easy_install pip
# RUN pip install awscli --upgrade --user
