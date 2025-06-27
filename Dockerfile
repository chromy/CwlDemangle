# Use the official Swift Docker image for Linux
FROM swift:latest AS builder

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Build the project with Linux optimization flags
RUN swift build -c release

# Create a minimal runtime image using the same Swift base
FROM swift:6.0-slim

# Copy the built executable from the builder stage
COPY --from=builder /app/.build/release/demangle /usr/local/bin/demangle

# Set the entry point
ENTRYPOINT ["/usr/local/bin/demangle"]