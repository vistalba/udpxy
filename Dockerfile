FROM debian:bookworm-slim AS builder
LABEL org.opencontainers.image.authors="vistalba"
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

RUN apt-get update && apt-get install -y wget make gcc git && \
    git clone https://github.com/pcherenkov/udpxy.git . && \
    cd chipmunk && make && make install


FROM debian:bookworm-slim
LABEL org.opencontainers.image.authors="vistalba"
COPY --from=builder /usr/local  /usr/local

# Set start command
#CMD ["/usr/local/bin/udpxy", ${UDPXY_OPTS}]
ENTRYPOINT [ "sh", "-c", "/usr/local/bin/udpxy ${UDPXY_OPTS}" ]
