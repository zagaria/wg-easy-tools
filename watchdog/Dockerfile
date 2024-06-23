FROM alpine:3.19.1

RUN apk update && apk add bash coreutils curl jq
RUN adduser --disabled-password --uid 1000 watchdog

ADD main.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER watchdog

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
