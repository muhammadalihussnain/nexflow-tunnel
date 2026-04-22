# Build stage
FROM ubuntu:22.04 AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY . .
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make -j $(nproc) nexflow_data_plane

# Runtime stage
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r nexflow && useradd -r -g nexflow -u 1000 nexflow

WORKDIR /app
COPY --from=builder /build/build/containers/nexflow-data-plane/nexflow_data_plane .

USER nexflow

ENTRYPOINT ["/app/nexflow_data_plane"]
CMD ["--config", "/etc/nexflow/config.yaml"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD /app/nexflow_data_plane --health || exit 1
