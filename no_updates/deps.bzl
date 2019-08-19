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

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file")
load("@io_bazel_rules_docker//container:container.bzl", "container_pull")
load(":revisions.bzl", "DEBS_TARBALL", "IMAGE")

def deps():
    excludes = native.existing_rules().keys()

    if "ubuntu1604" not in excludes:
        container_pull(
            name = "ubuntu1604",
            digest = IMAGE.sha256,
            registry = "gcr.io",
            repository = "asci-toolchain/container_release_tools_e2e_tests/no_updates/ubuntu1604",
        )

    if "image_debs" not in excludes:
        http_file(
            name = "image_debs",
            downloaded_file_path = DEBS_TARBALL.revision + "_image_debs.tar",
            sha256 = DEBS_TARBALL.sha256,
            urls = [
                "https://storage.googleapis.com/container_release_tools_e2e_tests/no_updates/debs/" + DEBS_TARBALL.revision + "_image_debs.tar",
            ],
        )
