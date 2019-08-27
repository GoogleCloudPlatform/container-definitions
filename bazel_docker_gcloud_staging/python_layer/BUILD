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
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
)

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

bzl_library(
    name = "lib",
    srcs = glob(["*.bzl"]),
)

download_pkgs(
    name = "python_debs",
    image_tar = "@ubuntu1604//image",
    packages = [
        "python-dev",
        "python-setuptools",
        "python3-dev",
        "software-properties-common",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":python_debs_metadata.csv",
)

# Clean up commands to run at the end of container generation to remove any
# build specific files.
PYTHON_CLEANUP_COMMANDS = (
    "find /usr/lib/python* -name __pycache__ -exec rm -rf {} +"
)

language_tool_layer(
    name = "python-ltl",
    base = "@fus_managed_ubuntu1604//image",
    installables_tar = "@ubuntu1604_python_debs//file",
    installation_cleanup_commands = PYTHON_CLEANUP_COMMANDS,
    symlinks = {
        "/usr/bin/python": "/usr/bin/python2.7",
    },
)
