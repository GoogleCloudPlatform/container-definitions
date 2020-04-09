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
load(
    "@io_bazel_rules_docker//contrib/automatic_container_release:packages_metadata.bzl",
    "packages_metadata",
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

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "nsjail_pkgs_metadata",
    metadata_csv = ":download_nsjail_pkgs_metadata.csv",
)

# Produce the image with the debian packages needed to build nsjail installed.
install_pkgs(
    name = "nsjail_image_base",
    image_tar = "@ubuntu1604//image:image.tar",
    installables_tar = "@nsjail_debs//file:packages.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "nsjail_image_base_output",
)

# Build nsjail.
container_run_and_extract(
    name = "nsjail_image",
    commands = [
        "git clone https://github.com/google/nsjail.git",
        # checkout the commit of the latest 2.9 release
        "cd nsjail && git checkout 3612c2a0b855a0a3ec57c7bb63c1443d0c944e8f",
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
        "lib32gcc1",
        "libc6-i386",
        "libcap2",
        "libnl-route-3-200",
        "libprotobuf9v5",
        "uidmap",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "chromium_rbe_pkgs_metadata",
    metadata_csv = ":download_chromium_rbe_pkgs_metadata.csv",
)

# Produce the image with the debian packages needed for the final RBE Goma
# image installed.
install_pkgs(
    name = "chromium_image_rbe_base",
    image_tar = "@ubuntu1604//image:image.tar",
    installables_tar = "@chromium_rbe_debs//file:packages.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/docker-gzip-indexes",
    output_image_name = "chromium_image_rbe_base_output",
)

# Build the chromium image by installing python, docker & nsjail.
toolchain_container(
    name = "image",
    base = ":chromium_image_rbe_base",
    # Specifies the directory the files specified to the "files"
    # attribute will be installed in.
    directory = "/bin",
    env = {
        "DEBIAN_FRONTEND": "noninteractive",
    },
    files = [":nsjail_image/nsjail/nsjail"],
    # Remove non-deterministic files.
    installation_cleanup_commands = "rm -f /etc/init.d/.depend.boot /etc/init.d/.depend.start /etc/init.d/.depend.stop",
    language_layers = [
        "@layer_definitions//layers/ubuntu1604/docker:docker-ltl",
        "@layer_definitions//layers/ubuntu1604/python:python-ltl",
    ],
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

configs_test(
    name = "configs_test",
    dependency_update_specs = [
        "deps_spec.yaml",
    ],
    file_update_specs = [
        "file_updates.yaml",
    ],
)
