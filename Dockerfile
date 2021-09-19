FROM alpine:latest AS base

ARG USER=code
ENV HOME /home/$USER
RUN  apk update --no-cache \
        && apk upgrade --no-cache -a \
        && apk add --no-cache sudo fish npm nodejs nano htop 

FROM base AS build
RUN  apk add --no-cache --virtual .build-deps \
        alpine-sdk bash python3 libstdc++ libc6-compat \
        && npm config set python python3 \
        && npm i -g code-server --unsafe-perm \
        && npm cache clean --force \
        && apk del .build-deps

FROM build as release
RUN  adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

USER code

EXPOSE 8080
ENTRYPOINT ["code-server"]
