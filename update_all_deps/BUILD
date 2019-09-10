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

load("@bazel_toolchains//rules/container:packages_metadata.bzl", "packages_metadata")
load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load(
    "@io_bazel_rules_docker//contrib/automatic_container_release:configs_test.bzl",
    "configs_test",
)
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
    "@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl",
    "download_pkgs"
)
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

# Target to generate a file managed by FUS with the content known in advance.
# The latest version of this file on GCS containes 'Hello world v2'.
# The 'image_test' target below tests the content of this file to confirm that
# FUS + DUS runs executed the expected flow.
genrule(
    name = "file",
    outs = ["file.txt"],
    cmd = "echo 'Hello world v3' > $@",
)

# Target to produce a tarball with basic debian packages. The produced tarball
# is managed by FUS and must be updated by DUS in order for the 'image' target
# to be buildable.
download_pkgs(
    name = "basic_debs",
    image_tar = "@ubuntu1604//image",
    packages = [
        "curl",
        "file",
        "git",
    ],
)

# Transform the packages metadata csv produced by download_pkgs into a YAML
# file.
packages_metadata(
    name = "metadata",
    metadata_csv = ":basic_debs_metadata.csv",
)

# Target pointing at a golang package tarball that is not managed by FUS.
# The pin to this tarball (specified in WORKSPACE) must be properly updated
# by DUS in order for the 'image' target to be buildable.
pkg_tar(
    name = "go_tar",
    package_dir = "/usr/local/",
    strip_prefix = ".",
    tags = ["manual"],
    deps = ["@go_release//file"],
)

toolchain_container(
    name = "image",
    base = "@fus_managed_ubuntu1604//image",
    files = ["@text_file//file"],
    env = {
        "GOPATH": "/go",
        "PATH": "$$PATH:/usr/local/go/bin",
    },
    tars = [":go_tar"],
    installables_tar = "@basic_debs//file",
)

container_test(
    name = "image_test",
    configs = [":tests.yaml"],
    image = ":image",
    verbose = True,
)

configs_test(
    name = "configs_test",
    checker_tag = "test",
    dependency_update_specs = ["deps_spec.yaml"],
    file_update_specs = ["file_updates.yaml"],
)

# Test to verify that pins to a GitHub repo were updated by DUS.
sh_test(
    name = "github_dep_update_test",
    srcs = ["github_dep_test.sh"],
    data = ["revisions.bzl"]
)
