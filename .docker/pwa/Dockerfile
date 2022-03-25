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

COPY ./entrypoint.sh /usr/src
RUN chmod +x /usr/src/entrypoint.sh

CMD [ "/usr/src/entrypoint.sh" ]
