FROM phusion/baseimage:latest

MAINTAINER Adam Radabaugh <adam@walkingtoast.com>

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8

ENV ELIXIR_VERSION 1.3.3
ENV ERLANG_VERSION 19.1
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PHOENIX_VERSION 1.2.0

# update and install some software requirements
RUN apt-get update && apt-get upgrade -y --fix-missing
RUN apt-get install -y ca-certificates curl wget git make postgresql-client openssh-client --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*

# Install Elixir using recommended steps from http://elixir-lang.org/install.html#unix-and-unix-like
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
 && dpkg -i erlang-solutions_1.0_all.deb \
 && rm erlang-solutions_1.0_all.deb \
 && apt-get update \
 && apt-get install -y esl-erlang=1:$ERLANG_VERSION elixir=$ELIXIR_VERSION-1

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez
RUN mix hex.info

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /code
