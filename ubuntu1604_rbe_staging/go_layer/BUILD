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
    "@io_bazel_rules_docker//docker/toolchain_container:toolchain_container.bzl",
    "language_tool_layer",
)
load("//:revisions.bzl", "GO_INSTALLER")

licenses(["notice"])  # Apache 2.0

package(default_visibility = ["//visibility:public"])

exports_files(glob(["*.yaml"]))

pkg_tar(
    name = "go_tar",
    package_dir = "/usr/local/",
    strip_prefix = ".",
    tags = ["manual"],
    deps = ["@go_release//file"],
)

language_tool_layer(
    name = "go-ltl",
    base = "@ubuntu1604//image",
    env = {
        "GOPATH": "/go",
        "PATH": "$$PATH:/usr/local/go/bin",
    },
    tars = [":go_tar"],
)

# Used by tests only.
genrule(
    name = "generate_go_yaml",
    srcs = ["tests.yaml.tpl"],
    outs = ["tests.yaml"],
    cmd = "sed 's|{_GO_REVISION}|" + GO_INSTALLER.revision + "|' <$< >$@",
)

container_test(
    name = "test",
    configs = [
        ":tests.yaml",
    ],
    image = ":go-ltl",
    verbose = True,
)
