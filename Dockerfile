FROM docker.io/library/rust:buster

RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup toolchain install stable-aarch64-unknown-linux-gnu

RUN apt-get update && apt-get -y install \
  curl \
  g++-aarch64-linux-gnu \
  libc6-dev-arm64-cross

ENV CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=aarch64-linux-gnu-gcc
# Alternately:
#ENV RUSTFLAGS="-C linker=aarch64-linux-gnu-gcc"

RUN cargo new --bin hello && \
  cd hello && \
  cargo build --target=aarch64-unknown-linux-gnu && \
  readelf -h target/aarch64-unknown-linux-gnu/debug/hello | grep -i machine
