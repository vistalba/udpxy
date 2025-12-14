
# udpxy Docker Image  

**A lightweight Docker image that builds and runs **`udpxy`**, a UDP‑to‑HTTP proxy, on top of Debian bookworm‑slim.**  

---  

## Overview  

This repository provides a multi‑stage Dockerfile that:

1. **Compiles** `udpxy` from source (using the `pcherenkov/udpxy` repository).  
2. **Packages** the resulting binaries into a minimal `debian:bookworm-slim` runtime image.  

The resulting container can be used to forward multicast UDP streams (e.g., IPTV) over HTTP, making them accessible to clients that cannot handle UDP directly.  

---  

## Run the Container  

`udpxy` is controlled entirely by command‑line options. Pass them through the `UDPXY_OPTS` environment variable.

```bash
docker run -d \
  --name udpxy \
  -p 4022:4022/tcp \   # default listening port (change if you use a different one)
  -e UDPXY_OPTS="-p 4022 -U 239.0.0.1:1234" \
  udpxy:latest
```
---
## Environment Variables  

| Variable | Required | Description |
|----------|----------|-------------|
| `UDPXY_OPTS` | **Yes** (at least the listening port) | Full list of command‑line arguments for `udpxy`. If omitted, the container will exit because no options are supplied. |

---  

### Common `udpxy` Options  

| Option | Description |
|--------|-------------|
| `-v` | enable verbose output [default = disabled] |
| `-S` | enable client statistics [default = disabled] |
| `-T` | do NOT run as a daemon [default = daemon if root] |
| `-a` | (IPv4) address/interface to listen on [default = 0.0.0.0] |
| `-p` | port to listen on |
| `-m` | (IPv4) address/interface of (multicast) source [default = 0.0.0.0] |
| `-c` | max clients to serve [default = 3, max = 5000] |
| `-l` | log output to file [default = stderr] |
| `-B` | buffer size (65536, 32Kb, 1Mb) for inbound (multicast) data [default = 2048 bytes] |
| `-R` | maximum messages to store in buffer (-1 = all) [default = 1] |
| `-H` | maximum time (sec) to hold data in buffer (-1 = unlimited) [default = 1] |
| `-n` | nice value increment [default = 0] |
| `-M` | periodically renew multicast subscription (skip if 0 sec) [default = 0 sec] |

All options can be combined, e.g.:

```bash
-e UDPXY_OPTS="-p 4022 -c 30 -T"
```
---  
