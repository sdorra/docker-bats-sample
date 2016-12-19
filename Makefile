IMAGE=docker-sample/hello-world
VERSION=latest
CONTAINER_NAME=hello_world

build:
	docker build -t "${IMAGE}:${VERSION}" .

run: build
	docker run -v "${PWD}/test:/test" --name "${CONTAINER_NAME}" -d "${IMAGE}:${VERSION}"

verify:
	@docker exec "${CONTAINER_NAME}" sh /test/bats.sh

test: run verify

clean:
	docker rm -f "${CONTAINER_NAME}"
