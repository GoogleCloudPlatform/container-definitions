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

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load(
	"@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl",
	"download_pkgs"
)
load(
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "toolchain_container",
)

genrule(
    name = "file",
    outs = ["file.txt"],
    cmd = "echo 'Hello world v3' > $@",
)

download_pkgs(
    name = "basic_debs",
    image_tar = "@fus_managed_ubuntu1604//image",
    packages = [
        "curl",
        "file",
        "git",
    ],
)

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
