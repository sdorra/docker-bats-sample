#!/bin/sh -e
BATS_DIR="/tmp/bats"
BATS_BIN="${BATS_DIR}/bin/bats"
BATS_URL="https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz"

TEST_DIR="/test/bats"

# install required dependencies

if ! which bash > /dev/null 2>&1; then
  apk --update add bash  > /dev/null 2>&1
fi

if ! which curl > /dev/null 2>&1; then
  apk --update add curl ca-certificates  > /dev/null 2>&1
fi

if [ ! -f "/usr/bin/tar" ]; then
  apk --update add tar  > /dev/null 2>&1
fi

if [ ! -d "${BATS_DIR}" ]; then
  mkdir "${BATS_DIR}"  > /dev/null 2>&1
fi

# install bats

if [ ! -f "${BATS_BIN}" ]; then
  cd "${BATS_DIR}" && curl -sL "${BATS_URL}"  | tar --strip-components=1 -xz  > /dev/null 2>&1
fi

# run tests

echo "running tests ..."
echo ""

"${BATS_BIN}" "${TEST_DIR}"
