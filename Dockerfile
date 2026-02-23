FROM rust:1.75-slim as builder
WORKDIR /usr/src/app
COPY . .

RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/src/app/target/release/rust_chappie /app/rust_chappie
COPY index.html /app/index.html
COPY Template.docx /app/Template.docx

ENV RUST_LOG=info

RUN chmod +x /app/rust_chappie

CMD ["./rust_chappie"]