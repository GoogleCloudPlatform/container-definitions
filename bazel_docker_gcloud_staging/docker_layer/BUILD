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

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@bazel_toolchains//rules/container:packages_metadata.bzl", "packages_metadata")
load("@io_bazel_rules_docker//docker/package_managers:apt_key.bzl", "add_apt_key")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
    "toolchain_container",
)

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

bzl_library(
    name = "lib",
    srcs = glob(["*.bzl"]),
)

# Downloading "docker-ce" requires "apt-transport-https" to be installed
# in the container. So create a prerequisite container first.
toolchain_container(
    name = "docker-prereq",
    base = "@ubuntu1604//image",
    packages = [
        "apt-transport-https",
        "ca-certificates",
        "curl",
    ],
)

add_apt_key(
    name = "docker-key-image",
    image = ":docker-prereq.tar",
    keys = [
        "@docker_gpg//file",
    ],
)

download_pkgs(
    name = "docker_debs",
    additional_repos = [
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable",
    ],
    image_tar = ":docker-key-image.tar",
    packages = [
        "docker-ce",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":docker_debs_metadata.csv",
)

language_tool_layer(
    name = "docker-ltl",
    base = "@fus_managed_ubuntu1604//image",
    installables_tar = "@ubuntu1604_docker_debs//file",
)
