# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

# Generate an intermediate image.
toolchain_container(
    name = "image_intermediate",
    base = "@ubuntu1604//image",
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop",
    language_layers = [
        "@layer_definitions//layers/ubuntu1604/clang:clang-ltl",
        "@layer_definitions//layers/ubuntu1604/java:java-ltl",
        "@layer_definitions//layers/ubuntu1604/java:java11-ltl",
        "@layer_definitions//layers/ubuntu1604/python:python-ltl",
        "@layer_definitions//layers/ubuntu1604/bazel:bazel-ltl",
        "@layer_definitions//layers/ubuntu1604/docker:docker-ltl",
    ],
)

# Set up `entrypoint` and cmd in the container. These cannot be set in the
# `toolchain_container` rule as they would be consumed by intermediate
# `container_image` rule in its implementation.
# TODO(xingao): enable setting things like `entrypoint` and `cmd` in
# `toolchain_container`.
container_image(
    name = "image",
    base = ":image_intermediate",
    cmd = None,
    entrypoint = ["/usr/local/bin/bazel"],
)

container_test(
    name = "image-test",
    configs = [
        ":tests.yaml",
        "@layer_definitions//layers/ubuntu1604/base:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/bazel:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/clang:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/docker:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/java:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/python:tests.yaml",
    ],
    image = ":image",
    verbose = True,
)
