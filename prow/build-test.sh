#!/bin/bash

# Copyright 2017 Istio Authors

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at

#       http://www.apache.org/licenses/LICENSE-2.0

#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.


##################################
# Presubmit for test-infra repo. #
##################################

function cleanup {
  if [[ -n "${ARTIFACTS}" ]]; then
    mkdir -p "${ARTIFACTS}/bazel-testlogs" || true
    cp "$(bazel info bazel-testlogs)"/* "${ARTIFACTS}/bazel-testlogs/" || true
  fi
}

trap cleanup exit

# Exit immediately for non zero status
set -e
# Check unset variables
set -u
# Print commands
set -x

echo "=== Building ==="
bazel build //...

echo "=== Testing ==="
bazel test //...
