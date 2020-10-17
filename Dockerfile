FROM golang:alpine as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o kubewatchdog .
FROM arm32v6/alpine:latest
COPY --from=builder /build/kubewatchdog /app/
WORKDIR /app
CMD ["./kubewatchdog"]