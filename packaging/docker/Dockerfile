FROM alpine:latest

RUN apk add --no-cache bash openssh-client fzf

COPY bin/sshm /usr/local/bin/sshm
RUN chmod +x /usr/local/bin/sshm

ENTRYPOINT ["sshm"]
CMD ["--help"]
