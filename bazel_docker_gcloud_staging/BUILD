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
    "@io_bazel_rules_docker//contrib/automatic_container_release:configs_test.bzl",
    "configs_test",
)
load("@io_bazel_rules_docker//contrib:repro_test.bzl", "container_repro_test")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

# Generate the container with Bazel, Docker and basic Gcloud installed.
toolchain_container(
    name = "image",
    base = "@fus_managed_ubuntu1604//image",
    cmd = [
        "/bin/sh",
        "-c",
        "/bin/bash",
    ],
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop",
    language_layers = [
        "//bazel_layer:bazel-ltl",
        "//clang_layer:clang-ltl",
        "//docker_layer:docker-ltl",
        "//gcloud_layer:gcloud-ltl",
        "//java_layer:java-ltl",
        "//java_layer:java11-ltl",
        "//python_layer:python-ltl",
    ],
)

container_test(
    name = "image_test",
    configs = [
        ":tests.yaml",
        "//base_layer:tests.yaml",
        "//bazel_layer:tests.yaml",
        "//clang_layer:tests.yaml",
        "//docker_layer:tests.yaml",
        "//gcloud_layer:tests.yaml",
        "//java_layer:tests.yaml",
        "//python_layer:tests.yaml",
    ],
    image = ":image",
    verbose = True,
)

container_repro_test(
    name = "img_repro_test",
    image = ":image",
    workspace_file = "//:WORKSPACE",
)

configs_test(
    name = "configs_test",
    dependency_update_specs = ["deps_spec.yaml"],
    file_update_specs = ["file_updates.yaml"],
)
