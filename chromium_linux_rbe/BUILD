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
    "@io_bazel_rules_docker//container:container.bzl",
    "container_image",
)
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl",
    "download_pkgs",
)
load(
    "@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl",
    "install_pkgs",
)
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)
load(
    "@io_bazel_rules_docker//docker/util:run.bzl",
    "container_run_and_extract",
)
load(":revisions.bzl", "GOOGLE_NSJAIL")

# Download the packages needed to build nsjail.
download_pkgs(
    name = "download_nsjail_pkgs",
    image_tar = "@ubuntu1604//image:image.tar",
    packages = [
        "autoconf",
        "bison",
        "ca-certificates",
        "flex",
        "g++",
        "gcc",
        "git",
        "libnl-route-3-dev",
        "libprotobuf-dev",
        "libtool",
        "make",
        "pkg-config",
        "protobuf-compiler",
    ],
)

# Produce the image with the debian packages needed to build nsjail installed.
install_pkgs(
    name = "nsjail_image_base",
    image_tar = "@ubuntu1604//image:image.tar",
    # TODO: Download this from FUS managed GCS bucket.
    installables_tar = ":download_nsjail_pkgs.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "nsjail_image_base_output",
)

# Build nsjail.
container_run_and_extract(
    name = "nsjail_image",
    commands = [
        "git clone https://github.com/google/nsjail.git",
        "cd nsjail && git checkout {}".format(GOOGLE_NSJAIL.commit),
        "make",
    ],
    docker_run_flags = ["--privileged"],
    extract_file = "/nsjail/nsjail",
    image = ":nsjail_image_base.tar",
)

# Download the packages needed to build the chromium RBE image.
download_pkgs(
    name = "download_chromium_rbe_pkgs",
    image_tar = "@ubuntu1604//image:image.tar",
    packages = [
        "libcap2",
        "libnl-route-3-200",
        "libprotobuf9v5",
        "uidmap",
    ],
)

# Produce the image with the debian packages needed for the final RBE Goma
# image installed.
install_pkgs(
    name = "chromium_image_rbe_base",
    image_tar = "@ubuntu1604//image:image.tar",
    # TODO: Download this from FUS managed GCS bucket.
    installables_tar = ":download_chromium_rbe_pkgs.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/docker-gzip-indexes",
    output_image_name = "chromium_image_rbe_base_output",
)

# Install docker in the Chromium RBE image.
toolchain_container(
    name = "chromium_image_with_docker",
    base = ":chromium_image_rbe_base",
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop",
    language_layers = [
        "@layer_definitions//layers/ubuntu1604/docker:docker-ltl",
        "@layer_definitions//layers/ubuntu1604/python:python-ltl",
    ],
)

# Package the nsjail binary into the chromium RBE image that has all debian
# packages need for the RBE image already installed.
container_image(
    name = "image",
    base = ":chromium_image_with_docker",
    directory = "/bin",
    env = {
        "DEBIAN_FRONTEND": "noninteractive",
    },
    files = [":nsjail_image/nsjail/nsjail"],
)

# Basic structure tests for the Chromium RBE image.
container_test(
    name = "image-test",
    configs = [
        ":tests.yaml",
    ],
    image = ":image",
    verbose = True,
)
