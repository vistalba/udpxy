FROM alpine:latest AS builder
LABEL org.opencontainers.image.authors="vistalba"

WORKDIR /tmp

RUN apk update && \
    apk add build-base git

RUN git clone https://github.com/pcherenkov/udpxy.git . && \
    cd chipmunk && make && make install

FROM alpine:latest
LABEL org.opencontainers.image.authors="vistalba"
COPY --from=builder /usr/local/bin/udpxy /usr/local/bin/udpxy

# Set start command
ENTRYPOINT [ "sh", "-c", "/usr/local/bin/udpxy ${UDPXY_OPTS}" ]
