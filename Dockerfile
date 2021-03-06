FROM node:14-alpine3.15 AS base

USER root

RUN  apk update --no-cache \
        && apk upgrade --no-cache -a \
        && apk add --no-cache git fish nano htop openssh openssh-keygen

FROM base AS build-deps
RUN  apk add --no-cache --virtual .build-deps \
        alpine-sdk bash python3 libstdc++ libc6-compat

FROM build-deps AS build
RUN  npm config set python python3 \
        && yarn global add code-server

FROM build AS clean
RUN  npm cache clean --force \
        && yarn cache clean \
        && apk del .build-deps

EXPOSE 80
CMD ["code-server"]
