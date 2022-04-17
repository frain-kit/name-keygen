FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \ 
silversearcher-ag \
openssh-server \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

COPY run.sh .

CMD ["/bin/bash", "run.sh"]