# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

# Docker parameters
DOCKER=docker
DOCKER_BUILD=$(DOCKER) build
DOCKER_RUN=$(DOCKER) run
DOCKER_STOP=$(DOCKER) stop
DOCKER_RM=$(DOCKER) rm

# Binary name
BINARY_NAME=main

# Docker image and container names
IMAGE_NAME=go-docker-multistage-build-app
CONTAINER_NAME=go-docker-multistage-build-app-container

all: build

build:
	$(GOBUILD) -o $(BINARY_NAME) -v

clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)

run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)

build-docker:
	$(DOCKER_BUILD) -t $(IMAGE_NAME) .

run-docker: build-docker
	$(DOCKER_RUN) -p 8080:8080 --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop-docker:
	$(DOCKER_STOP) $(CONTAINER_NAME)

rm-docker:
	$(DOCKER_RM) $(CONTAINER_NAME)

.PHONY: all build clean run build-docker run-docker stop-docker rm-docker
