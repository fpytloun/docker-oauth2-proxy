FROM golang:1.10-alpine

ENV GOPATH=/go

# Install build dependencies
RUN apk add --update git wget openssh unzip

# Install oauth2_proxy
RUN go get github.com/bitly/oauth2_proxy
#RUN mkdir -p /go/src/github.com/bitly/oauth2_proxy && \
#    git clone --depth 1 https://github.com/bitly/oauth2_proxy.git /go/src/github.com/bitly/oauth2_proxy && \
#    cd /go/src/github.com/bitly/oauth2_proxy && go build && go install && \
#    rm -rf /go/src/github.com/bitly/oauth2_proxy

ENTRYPOINT ["/go/bin/oauth2_proxy"]

FROM alpine
RUN apk add --update ca-certificates
COPY --from=0 /go/bin/oauth2_proxy /usr/local/bin/oauth2_proxy
ENTRYPOINT ["/usr/local/bin/oauth2_proxy"]
