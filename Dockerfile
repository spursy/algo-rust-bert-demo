FROM bitnami/pytorch:1.13.1-debian-11-r33 AS builder

USER root

RUN apt-get update  \
    && apt-get install curl build-essential ca-certificates tzdata net-tools pkg-config libssl-dev openssl -y \
    && curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain none -y \
    && $HOME/.cargo/bin/rustup default stable \
    && $HOME/.cargo/bin/rustc --version

ENV PATH $HOME/.cargo/bin:$PATH

COPY . .

ENV LIBTORCH=/opt/bitnami/python/lib/python3.8/site-packages/torch
ENV DYLD_LIBRARY_PATH=${LIBTORCH}/lib
ENV LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH


#RUN rustup target add x86_64-unknown-linux-musl
#--target=x86_64-unknown-linux-musl

RUN rustup target add x86_64-unknown-linux-gnu

RUN cargo build --release  --bin algo-rust-bert-demo

RUN cp target/release/algo-rust-bert-demo /app/algo-rust-bert-demo


FROM bitnami/pytorch:1.13.1-debian-11-r33

USER root

ENV GRPC_HEALTH_PROBE_VERSION=v0.4.17
RUN apt-get update \
    && apt-get install curl wget build-essential ca-certificates tzdata net-tools pkg-config libssl-dev openssl -y \
    && wget -qO /bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 \
    && chmod +x /bin/grpc_health_probe \
    && wget -qO /bin/grpcurl_1.8.7_linux_x86_64.tar.gz https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz  \
    && tar -xf /bin/grpcurl_1.8.7_linux_x86_64.tar.gz -C /bin \
    && rm -rf /bin/grpcurl_1.8.7_linux_x86_64.tar.gz \
    && rm -rf /var/lib/apt/lists/*

ENV LIBTORCH=/opt/bitnami/python/lib/python3.8/site-packages/torch
ENV DYLD_LIBRARY_PATH=${LIBTORCH}/lib
ENV LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH

COPY --from=builder /app/algo-rust-bert-demo algo-rust-bert-demo
CMD ["./algo-rust-bert-demo"]