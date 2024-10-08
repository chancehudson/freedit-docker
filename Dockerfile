FROM rust:1-slim-bookworm AS builder

RUN apt update && apt install -y git build-essential
RUN git clone https://github.com/freedit-org/freedit.git /tmp/freedit

WORKDIR /tmp/freedit

RUN cargo build -r

FROM rust:1-slim-bookworm
COPY --from=builder /tmp/freedit/target/release/freedit /usr/local/bin/freedit

COPY ./config.toml /config.toml

CMD ["freedit", "/config.toml"]
