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
load(
    "//:revisions.bzl",
    "CLANG_DEBS_TARBALL",
    "CLANG_INSTALLER",
    "LIBCXX_INSTALLER",
)

def deps():
    """Download dependencies required to use this layer."""
    excludes = native.existing_rules().keys()

    # Clang
    if "ubuntu1604_clang_release" not in excludes:
        http_file(
            name = "ubuntu1604_clang_release",
            downloaded_file_path = "clang_r" + CLANG_INSTALLER.revision + ".tar.gz",
            sha256 = CLANG_INSTALLER.sha256,
            urls = ["https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/clang_r" + CLANG_INSTALLER.revision + ".tar.gz"],
        )

    # libcxx
    if "ubuntu1604_libcxx_release" not in excludes:
        http_file(
            name = "ubuntu1604_libcxx_release",
            downloaded_file_path = "libcxx-msan_r" + LIBCXX_INSTALLER.revision + ".tar.gz",
            sha256 = LIBCXX_INSTALLER.sha256,
            urls = ["https://storage.googleapis.com/clang-builds-stable/clang-ubuntu16_04/libcxx-msan_r" + LIBCXX_INSTALLER.revision + ".tar.gz"],
        )

    if "ubuntu1604_clang_debs" not in excludes:
        http_file(
            name = "ubuntu1604_clang_debs",
            downloaded_file_path = CLANG_DEBS_TARBALL.revision + "_clang_debs.tar",
            sha256 = CLANG_DEBS_TARBALL.sha256,
            urls = [
                "https://storage.googleapis.com/container_release_tools_e2e_tests/bazel_docker_gcloud_staging/clang/debs/" + CLANG_DEBS_TARBALL.revision + "_clang_debs.tar",
            ],
        )
