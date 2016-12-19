#!/bin/sh -e
# installs bats with all required dependencies
# and executes bats tests.

# variables for bats installation
BATS_DIR="/tmp/bats"
BATS_BIN="${BATS_DIR}/bin/bats"
BATS_URL="https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz"

# tests locations
TEST_DIR="/test/bats"

# install required dependencies
install_dependencies() {
  if ! which bash; then
    apk --update add bash
  fi

  if ! which curl; then
    apk --update add curl ca-certificates
  fi

  if [ ! -f "/usr/bin/tar" ]; then
    apk --update add tar
  fi

  if [ ! -d "${BATS_DIR}" ]; then
    mkdir "${BATS_DIR}"
  fi
}

# install bats with curl
install_bats() {
  if [ ! -f "${BATS_BIN}" ]; then
    cd "${BATS_DIR}" && curl -sL "${BATS_URL}"  | tar --strip-components=1 -xz
  fi
}

# installation
install_dependencies > /dev/null 2>&1
install_bats > /dev/null 2>&1

# run tests
echo "running tests ..."
echo ""

"${BATS_BIN}" "${TEST_DIR}"
