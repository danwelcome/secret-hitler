FROM node:lts-alpine

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories \
    && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories \
    && apk update \
    && apk --update add mongodb \
    && apk --update add git

WORKDIR /secret-hitler
COPY . .
RUN yarn --ignore-engines --frozen-lockfile && yarn build

ENV MONGO_HOSTNAME mongo:27017
ENV REDIS_HOSTNAME redis
ENV REDIS_PORT 6379
EXPOSE 8080
CMD ./wait-for $MONGO_HOSTNAME -- ./wait-for $REDIS_HOSTNAME:$REDIS_PORT -- node bin/dev.js