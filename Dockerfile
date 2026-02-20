FROM rust:1.75-slim as builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/bin
COPY --from=builder /usr/src/app/target/release/your_project_name .
COPY index.html .
COPY Template.docx .
# Ensure .env is handled via Cloud Run Variables instead of copying it
CMD ["./your_project_name"]