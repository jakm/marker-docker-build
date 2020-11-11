default: build

SHELL: /bin/bash
.ONESHELL:

.PHONY: build

IMAGE := marker-build:latest
OUTDIR := deb

build-image:
	if ! docker images --format '{{.Repository}}:{{.Tag}}' | grep -q "$(IMAGE)"
	then
		docker build -t $(IMAGE) .
	fi

clean-image:
	docker rmi $(IMAGE)

$(OUTDIR):
	mkdir $(OUTDIR)

env_guard:
	@if [ -z "${DEBFULLNAME}" ] || [ -z "${DEBEMAIL}" ]
	then
		echo "Some of environment variables DEBFULLNAME or DEBEMAIL is empty" 1>&2
		exit 1
	fi

build: $(OUTDIR) env_guard build-image
	docker run --rm -v $(PWD)/$(OUTDIR):/output -e DEBFULLNAME="${DEBFULLNAME}" -e DEBEMAIL="${DEBEMAIL}" $(IMAGE)

clean:
	rm -rf $(OUTDIR)
