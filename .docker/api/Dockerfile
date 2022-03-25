FROM node:12-buster

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/src/app

# ENV REDIS_LOGIN_SERVER="172.17.0.1:6379" \
# 	NODE_ENV='development'

# setup yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt install --no-install-recommends yarn

# Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

COPY ./entrypoint.sh /usr/src
RUN chmod +x /usr/src/entrypoint.sh

CMD [ "dockerize -wait tcp://mysql:3306 -timeout 40s /usr/src/entrypoint.sh" ]
