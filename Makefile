IMAGE=docker-sample/hello-world
VERSION=latest
CONTAINER_NAME=hello_world

BATS_DIR=/tmp/bats
BATS_URL=https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz

build:
	docker build -t "${IMAGE}:${VERSION}" .

run: build
	docker run --name "${CONTAINER_NAME}" -d "${IMAGE}:${VERSION}"

prepare-for-tests:
	@docker exec "${CONTAINER_NAME}" rm -rf /tmp/tests || 0
	@docker cp "test/bats" "${CONTAINER_NAME}:/tmp/tests"
	@docker cp "test/bats.sh" "${CONTAINER_NAME}:/tmp/run_tests.sh"

verify: prepare-for-tests
	@docker exec "${CONTAINER_NAME}" sh /tmp/run_tests.sh

test: run verify

clean:
	docker rm -f "${CONTAINER_NAME}"
