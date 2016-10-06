FROM alpine:edge
MAINTAINER Ruben Vermeersch <ruben@rocketeer.be>

ENV GOROOT=/usr/lib/go \
    GOPATH=/gopath     \
    GOBIN=/gopath/bin  \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin \
    CGO_ENABLED=0

ADD main.go /gopath/src/github.com/rubenv/ec2-disable-source-dest/

RUN apk add --update go git openssh gcc && \
    go get -v github.com/rubenv/ec2-disable-source-dest/... && \
    go install -v github.com/rubenv/ec2-disable-source-dest && \
    apk del go git openssh gcc && \
    mv $GOPATH/bin/ec2-disable-source-dest /usr/bin/ && \
    rm -rf $GOPATH && \
    rm -rf /var/cache/apk/*

CMD ["ec2-disable-source-dest"]
