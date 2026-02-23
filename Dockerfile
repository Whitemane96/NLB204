FROM rust:latest as builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /app

COPY --from=builder /usr/src/app/target/release/rust_chappie /app/rust_chappie
COPY index.html /app/index.html
COPY Template.docx /app/Template.docx

RUN chmod +x /app/rust_chappie

EXPOSE 8080
CMD ["./rust_chappie"]