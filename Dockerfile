FROM golang:1.10 AS builder
WORKDIR /go/src/github.com/pusher/k8s-spot-rescheduler
COPY . .
RUN curl -s https://glide.sh/get | sh \
    && glide install -v \
    && env GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o rescheduler

FROM scratch
COPY --from=builder /go/src/github.com/pusher/k8s-spot-rescheduler/rescheduler /bin/rescheduler

ENTRYPOINT ["/bin/rescheduler"]
