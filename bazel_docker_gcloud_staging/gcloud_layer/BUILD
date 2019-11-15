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
load("@io_bazel_rules_docker//docker/package_managers:apt_key.bzl", "add_apt_key")
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

add_apt_key(
    name = "gcloud-key-image",
    image = "@ubuntu1604//image",
    keys = [
        "@gcloud_gpg//file",
    ],
)

download_pkgs(
    name = "gcloud_debs",
    additional_repos = [
        "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main",
    ],
    image_tar = ":gcloud-key-image.tar",
    packages = [
        "google-cloud-sdk",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":gcloud_debs_metadata.csv",
)

language_tool_layer(
    name = "gcloud-ltl",
    base = "@fus_managed_ubuntu1604//image",
    installables_tar = "@ubuntu1604_gcloud_debs//file",
)
