#!/usr/bin/env bats

@test "webserver is running" {
  ps -ef | grep nginx | grep -v grep
}

@test "webserver response with 'Hello World'" {
  curl -s localhost | grep 'Hello World'
}
