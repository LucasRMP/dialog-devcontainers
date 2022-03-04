FROM ruby:2.6.6

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y git curl gawk locales
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
EXPOSE 3000

# setup node 10.x
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

# setup yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt install --no-install-recommends yarn

RUN apt-get install -y \
  autoconf \
  automake \
  binutils \
  bison \
  cpp \
  g++ \
  gawk \
  gcc \
  git \
  gnupg2 \
  imagemagick \
  jq \
  libcurl4-openssl-dev \
  libffi-dev \
  libgdbm-dev \
  libgmp-dev \
  libmariadb-dev \
  libncurses5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libtool \
  libxml2-dev \
  libyaml-dev \
  make \
  mariadb-client \
  nodejs \
  ntp \
  pkg-config \
  sqlite3 \
  tzdata \
  wget \
  zlib1g-dev \
  zstd

# timezone
ENV TZ America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#aha
RUN curl https://codeload.github.com/theZiz/aha/tar.gz/0.5.1 | tar xz \
    && cd aha-0.5.1 \
    && make && make install
RUN rm -rf cd aha-0.5.1
RUN aha --version

# npm packages
RUN npm install -g bower

# RUN gem install bundler -v 2.1.4
RUN gem install bundler

# Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /usr/src/app
COPY ./entrypoint.sh /usr/src
RUN chmod +x /usr/src/entrypoint.sh
