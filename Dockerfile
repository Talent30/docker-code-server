FROM node:lts-alpine3.14
RUN apk update --no-cache\
    && apk add fish alpine-sdk bash libstdc++ libc6-compat python3 --no-cache \
    && npm config set python python3 
RUN npm i -g code-server --unsafe-perm

ENTRYPOINT ["code-server"]
