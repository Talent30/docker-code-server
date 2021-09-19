FROM alpine:latest AS base

ARG USER=code
ENV HOME /home/$USER
RUN  apk update --no-cache \
        && apk upgrade -a --no-cache \
        && apk add alpine-sdk bash libstdc++ libc6-compat python3 sudo fish npm nodejs nano htop --no-cache

RUN  adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

FROM base AS dependencies
RUN  npm config set python python3 \
        && npm i -g code-server --unsafe-perm \
        && npm cache clean --force \
        && apk del alpine-sdk bash python3 

FROM dependencies AS build
RUN npm i -g code-server --unsafe-perm 

FROM build as release
RUN npm cache clean --force \
        && apk del alpine-sdk bash python3 
USER code

EXPOSE 8080
ENTRYPOINT ["code-server"]
