FROM mongo:4

RUN apt-get update && apt-get -y install awscli lsb-release curl

RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN apt-get update && apt-get install -y google-cloud-sdk

RUN mkdir -p /backup/data

WORKDIR /backup/data
ADD run.sh /backup/run.sh
RUN chmod +x /backup/run.sh

ENTRYPOINT ["/backup/run.sh"]