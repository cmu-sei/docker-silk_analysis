# source: https://jmkhael.io/makefiles-for-your-dockerfiles/
# Run in parallel via make -j2 see: https://stackoverflow.com/a/9220818

NS = docker.cc.cert.org/netsa-tools
export SOFTWARE_NAME = silk_analysis

export IMAGE_NAME += $(NS)/$(SOFTWARE_NAME)

export WORK_DIR = .

.PHONY: build test

build:
	docker build --build-arg http_proxy --build-arg https_proxy --build-arg no_proxy -t $(IMAGE_NAME):latest -f Dockerfile .

test:
	docker rm -f $(SOFTWARE_NAME)
	docker run --name=$(SOFTWARE_NAME) -td $(IMAGE_NAME)
	py.test --hosts='docker://$(SOFTWARE_NAME)'
	docker rm -f $(SOFTWARE_NAME)

default: build
