IMAGE_ROOT?=ghcr.io/biodt
IMAGE=hmsc-hpc
IMAGE_VERSION=0.1.1

build: Dockerfile
	docker build \
		--label "org.opencontainers.image.source=https://github.com/BioDT/hmsc-container" \
		--label "org.opencontainers.image.description=HMSC-HPC environment for LUMI-G" \
		-t $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION) \
		.

push:
	docker push $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION)

singularity:
	rm -f $(IMAGE).sif $(IMAGE).tar
	docker save $(IMAGE_ROOT)/$(IMAGE):$(IMAGE_VERSION) -o $(IMAGE).tar
	singularity build $(IMAGE).sif docker-archive://$(IMAGE).tar
	rm -f $(IMAGE).tar
