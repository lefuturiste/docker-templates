FROM debian

RUN apt update
RUN apt install -y vim procps psmisc screen net-tools curl htop httpie dnsutils build-essential autoconf lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 netcat nmap openssh-client ftp iputils-ping zip unzip
RUN apt install -y tmux lsof net-tools moreutils tcpdump

# SMTP client
RUN apt install -y s-nail
RUN apt install -y kafkacat
RUN apt install -y strace

CMD [ "sleep", "infinity" ]
