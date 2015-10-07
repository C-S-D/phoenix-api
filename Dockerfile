FROM ubuntu:latest

MAINTAINER Adam Radabaugh <adam@walkingtoast.com>

# Elixir requires UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install some software requirements
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget git make

# download and install Erlang package
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
 && dpkg -i erlang-solutions_1.0_all.deb \
 && apt-get update

# install erlang from package
RUN apt-get install -y erlang erlang-ssl erlang-inets && rm erlang-solutions_1.0_all.deb

# install elixir from source
RUN git clone https://github.com/elixir-lang/elixir.git && cd elixir && git checkout v1.1.1 && make
ENV PATH $PATH:/elixir/bin

ENV PHOENIX_VERSION 1.0.3

# install Phoenix from source with some previous requirements
RUN git clone https://github.com/phoenixframework/phoenix.git \
 && cd phoenix && git checkout v$PHOENIX_VERSION \
 && mix local.hex --force && mix local.rebar --force \
 && mix do deps.get, compile \
 && mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v$PHOENIX_VERSION/phoenix_new-$PHOENIX_VERSION.ez --force

WORKDIR /code