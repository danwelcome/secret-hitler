FROM node:lts-alpine

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories
RUN apk update
RUN apk --update add mongodb
RUN apk --update add git

WORKDIR /secret-hitler
COPY . .
RUN yarn

ENV MONGO_HOSTNAME mongo:27017
EXPOSE 8080
CMD ["yarn", "dev"]