# build
FROM            golang:1.9-alpine as builder
COPY            . /go/src/github.com/moul/grpcbin
WORKDIR         /go/src/github.com/moul/grpcbin
RUN             go build -o /go/bin/grpcbin -ldflags "-extldflags \"-static\"" -v

# minimal runtime
FROM            alpine
COPY            --from=builder /go/bin/grpcbin /bin/grpcbin
COPY            --from=builder /go/src/github.com/moul/grpcbin/cert /root/cert
WORKDIR         /root
EXPOSE          9000 9001
ENTRYPOINT      ["/bin/grpcbin"]
