CONTAINER_RUNTIME ?= sudo podman
IMAGE ?= slaclab/x11-docker
TAG ?= latest
ONDEMAND_IMAGE_PATH ?= /sdf/sw/images/x11-docker

build:
	$(CONTAINER_RUNTIME) build -t $(IMAGE):$(TAG) .

push:
	$(CONTAINER_RUNTIME) push $(IMAGE):$(TAG)

apptainer:
	# install the image into teh expected location for ondemand
	apptainer pull -F --dir $(ONDEMAND_IMAGE_PATH) docker://$(IMAGE):$(TAG)
