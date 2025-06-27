# CwlDemangle Makefile

.PHONY: build test clean docker-build docker-test help

# Default target
all: build

# Build the project
build:
	@echo "🔨 Building CwlDemangle..."
	swift build -c release

# Run tests
test:
	@echo "🧪 Running tests..."
	swift test

# Clean build artifacts
clean:
	@echo "🧹 Cleaning build artifacts..."
	swift package clean
	rm -rf .build

# Build Docker image
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t cwl-demangle .

# Test Docker image
docker-test: docker-build
	@echo "🧪 Testing Docker image..."
	@echo "Testing basic demangling..."
	docker run --rm cwl-demangle single "_TFC3foo3bar3bazfT_S0_"
	@echo "Testing JSON output..."
	docker run --rm cwl-demangle single "_TFC3foo3bar3bazfT_S0_" --json
	@echo "Testing help..."
	docker run --rm cwl-demangle --help

# Run the executable locally
run:
	@echo "🚀 Running CwlDemangle..."
	swift run demangle

# Show help
help:
	@echo "CwlDemangle Makefile Targets:"
	@echo "  build        - Build the project (release mode)"
	@echo "  build-linux  - Build with Linux optimization flags"
	@echo "  test         - Run tests"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-test  - Build and test Docker image"
	@echo "  run          - Run the executable locally"
	@echo "  help         - Show this help message"