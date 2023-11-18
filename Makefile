CONTAINER_RUNTIME ?= sudo podman
ORG ?= slaclab
IMAGE ?= x11-desktop
TAG ?= latest
ONDEMAND_IMAGE_PATH ?= /sdf/sw/images/$(IMAGE)

S3DF_IMAGE ?= s3df-desktop

build:
	$(CONTAINER_RUNTIME) build -t $(ORG)/$(IMAGE):$(TAG) .

push:
	$(CONTAINER_RUNTIME) push $(ORG)/$(IMAGE):$(TAG)

apptainer:
	# install the image into teh expected location for ondemand
	apptainer pull --disable-cache -F $(ONDEMAND_IMAGE_PATH)/$(IMAGE)@$(TAG).sif docker://$(ORG)/$(IMAGE):$(TAG)

s3df-desktop:
	$(CONTAINER_RUNTIME) build -t $(ORG)/$(S3DF_IMAGE):$(TAG) -f Dockerfile.s3df-desktop
	$(CONTAINER_RUNTIME) push $(ORG)/$(S3DF_IMAGE):$(TAG)
	apptainer pull --disable-cache -F $(ONDEMAND_IMAGE_PATH)/$(S3DF_IMAGE)@$(TAG).sif docker://$(ORG)/$(S3DF_IMAGE):$(TAG)

all: build push apptainer
