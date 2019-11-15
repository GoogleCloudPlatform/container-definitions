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
load(
    "@io_bazel_rules_docker//contrib/automatic_container_release:packages_metadata.bzl",
    "packages_metadata",
)
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
)
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

bzl_library(
    name = "lib",
    srcs = glob(["*.bzl"]),
)

download_pkgs(
    name = "python_rbe_debs",
    image_tar = "@ubuntu1604//image",
    packages = [
        "python-dev",
        "python-setuptools",
        "python3-dev",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":python_rbe_debs_metadata.csv",
)

container_run_and_extract(
    name = "python3_tar",
    commands = [
        "tar cvf /python.tar --mtime='1970-01-01' /opt/python3.6",
    ],
    extract_file = "/python.tar",
    image = "@ubuntu1604_python3//image",
)

# Clean up commands to run at the end of container generation to remove any
# build specific files.
PYTHON_CLEANUP_COMMANDS = (
    "find /usr/lib/python* -name __pycache__ -exec rm -rf {} +"
)

language_tool_layer(
    name = "python-rbe-ltl",
    base = "@ubuntu1604//image",
    env = {
        "PATH": "$$PATH:/opt/python3.6/bin",
    },
    installables_tar = "@ubuntu1604_python_rbe_debs//file",
    installation_cleanup_commands = PYTHON_CLEANUP_COMMANDS,
    symlinks = {
        "/opt/python3.6/bin/easy_install3": "/opt/python3.6/bin/easy_install-3.6",
        "/opt/python3.6/bin/pip3": "/opt/python3.6/bin/pip3.6",
        "/opt/python3.6/bin/python3": "/opt/python3.6/bin/python3.6",
        "/usr/bin/python": "/usr/bin/python2.7",
        "/usr/bin/python3": "/opt/python3.6/bin/python3.6",
    },
    tars = [":python3_tar/python.tar"],
)

container_test(
    name = "test",
    configs = [
        ":tests.yaml",
    ],
    image = ":python-rbe-ltl",
    verbose = True,
)
