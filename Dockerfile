FROM golang:1.22-bookworm as builder

COPY ./ /build

RUN cd /build && CGO_ENABLED=0 go build -ldflags='-extldflags "-static"' -v -o /build/emporia_exporter .

FROM gcr.io/distroless/static-debian11

COPY --from=builder /build/emporia_exporter /usr/bin/emporia_exporter

ENTRYPOINT ["/usr/bin/emporia_exporter"]
