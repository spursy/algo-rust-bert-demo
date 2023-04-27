FROM bitnami/pytorch:1.13.1-debian-11-r33 AS builder

USER root

RUN apt-get update  \
    && apt-get install curl build-essential ca-certificates tzdata net-tools pkg-config  libssl-dev -y \
    && curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path --default-toolchain none -y \
    && $HOME/.cargo/bin/rustup default stable \
    && $HOME/.cargo/bin/rustc --version

#workdir /app
COPY . .

ENV LIBTORCH=/opt/bitnami/python/lib/python3.8/site-packages/torch
ENV DYLD_LIBRARY_PATH=${LIBTORCH}/lib
ENV LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH

#RUN pip3 install torch torchvisionex
RUN $HOME/.cargo/bin/cargo build --release --bin algo-rust-bert-demo

