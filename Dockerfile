FROM alpine:3.14
RUN apk update \
    && apk upgrade -a \
    && apk add nodejs npm fish nano \
    && npm i -g code-server
ENTRYPOINT ["code-server"]