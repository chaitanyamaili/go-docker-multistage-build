# Stage 1: Build the Go binary
FROM golang:latest AS BuildStage

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.* ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY *.go ./

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux go build -o main

# Stage 2: Copy the Go binary to a new image
FROM alpine:latest

#  Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go binary from the builder stage to the Working Directory inside the container
COPY --from=BuildStage /app/main /main

#  Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the executable
ENTRYPOINT ["/main"]
