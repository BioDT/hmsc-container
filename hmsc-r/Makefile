IMAGE_ROOT?=ghcr.io/biodt
IMAGE=hmsc-r
IMAGE_VERSION=0.1.2
R_VERSION=4.3.2


build: Dockerfile
	docker build \
		--label "org.opencontainers.image.source=https://github.com/BioDT/hmsc-container" \
		--label "org.opencontainers.image.description=HMSC-R environment with R $(R_VERSION)" \
		--build-arg R_VERSION=$(R_VERSION) \
		-t $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION) \
		.

push:
	docker push $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION)

singularity:
	rm -f $(IMAGE).sif $(IMAGE).tar
	docker save $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION) -o $(IMAGE).tar
	singularity build $(IMAGE).sif docker-archive://$(IMAGE).tar
	rm -f $(IMAGE).tar
