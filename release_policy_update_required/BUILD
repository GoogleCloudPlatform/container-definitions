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

load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
	"@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl",
	"download_pkgs"
)
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

download_pkgs(
    name = "basic_debs",
    image_tar = "@ubuntu1604//image",
    packages = [
        "curl",
        "file",
        "git",
    ],
)

toolchain_container(
    name = "image",
    base = "@ubuntu1604//image",
    installables_tar = "@basic_debs//file",
)

container_test(
    name = "image_test",
    configs = [":tests.yaml"],
    image = ":image",
    verbose = True,
)
