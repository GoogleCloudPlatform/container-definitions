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

load(
    "@bazel_toolchains//rules/container:docker_toolchains.bzl",
    "toolchain_container",
)
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

toolchain_container(
    name = "image",
    base = "@ubuntu1604//image",
    cmd = [
        "/bin/sh",
        "-c",
        "/bin/bash",
    ],
    env = {
        "LANG": "C.UTF-8",
        "LANGUAGE": "C.UTF-8",
        "LC_ALL": "C.UTF-8",
        "PATH": "$$PATH:/opt/python3.6/bin",
    },
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop",
    language_layers = [
        "@layer_definitions//layers/ubuntu1604/clang:clang-ltl",
        "@layer_definitions//layers/ubuntu1604/java:java-ltl",
        "@layer_definitions//layers/ubuntu1604/java:java11-ltl",
        "@layer_definitions//layers/ubuntu1604/python_rbe:python-rbe-ltl",
        "@layer_definitions//layers/ubuntu1604/rbe_tools:rbe-tools-ltl",
        "@layer_definitions//layers/ubuntu1604/webtest:webtest-ltl",
    ],
)

container_test(
    name = "image-test",
    configs = [
        ":tests.yaml",
        "@layer_definitions//layers/ubuntu1604/base:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/clang:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/java:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/python_rbe:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/rbe_tools:tests.yaml",
        "@layer_definitions//layers/ubuntu1604/webtest:tests.yaml",
    ],
    image = ":image",
    verbose = True,
)
