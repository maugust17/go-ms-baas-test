# syntax=docker/dockerfile:1

# Etapa de build
FROM golang:alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main ./cmd/api

# Etapa de deploy
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main ./main
EXPOSE 8080
CMD ["./main"]
