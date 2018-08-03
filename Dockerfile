FROM debian:9-slim

ENV k8sversion=1.10.5-00

RUN apt-get update && apt-get install -y apt-transport-https gnupg2 curl

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y kubectl=${k8sversion}

ENTRYPOINT [ "kubectl" ]

CMD [ "get", "events", "--watch-only" ]
