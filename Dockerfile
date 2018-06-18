FROM alpine:latest

RUN apk add --no-cache curl jq

WORKDIR /
COPY src/. src

CMD ash
