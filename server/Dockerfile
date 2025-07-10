ARG GO_VERSION=1
FROM golang:${GO_VERSION}-bookworm as builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy go mod files and download dependencies
COPY /server/go.mod /server/go.sum ./
RUN go mod download && go mod verify

# Copy the source code into the container
COPY ./server .

# Build the Go app
RUN go build -v -o /run-app .

# Final image setup
FROM debian:bookworm-slim

# Install CA certificates
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the compiled Go binary from the builder stage
COPY --from=builder /run-app /usr/local/bin/

COPY . /throwaway

RUN cp -r /throwaway/Static ./server/Static || echo "No resources to copy"
RUN rm -rf /throwaway

# Expose the port your app runs on
EXPOSE 8080

# Start the Go application
CMD ["run-app"]
