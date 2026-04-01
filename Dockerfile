FROM rust:latest as builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates libssl-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /app

COPY --from=builder /usr/src/app/target/release/nlb204 /app/nlb204
COPY index.html /app/index.html
COPY Template.docx /app/Template.docx

RUN chmod +x /app/nlb204

EXPOSE 8080
CMD ["./nlb204"]