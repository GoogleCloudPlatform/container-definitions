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

load("@base_images_docker//package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

UBUNTU_ENV = {
    "DEBIAN_FRONTEND": "noninteractive",
    "PATH": "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

container_image(
    name = "ubuntu1604_vanilla",
    env = UBUNTU_ENV,
    tars = ["@ubuntu1604_tar//file"],
)

download_pkgs(
    name = "debs",
    image_tar = ":ubuntu1604_vanilla.tar",
    packages = [
        "ca-certificates",
        "curl",
        "libc-bin",
        "netbase",
    ],
)
