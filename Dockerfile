FROM thewalkingtoast/phoenix-api:latest

MAINTAINER Adam Radabaugh <aradabaugh@csd.org>

# update and install some software requirements
RUN apt-get purge -y mysql-client
RUN apt-get install -y openssh-client -y --no-install-recommends
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
