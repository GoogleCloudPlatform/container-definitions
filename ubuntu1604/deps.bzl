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

load("@bazel_toolchains//rules:gcs.bzl", "gcs_file")
load(":revisions.bzl", "DEBS_TARBALL", "UBUNTU1604_TAR")

def deps():
    """Download dependencies required to use this layer."""
    excludes = native.existing_rules().keys()

    # Base Ubuntu1604 tarball.
    if "ubuntu1604_tar" not in excludes:
        gcs_file(
            name = "ubuntu1604_tar",
            bucket = "gs://ubuntu_tar/" + UBUNTU1604_TAR.revision,
            file = "ubuntu-xenial-core-cloudimg-amd64-root.tar.gz",
            sha256 = UBUNTU1604_TAR.sha256,
        )

    if "ubuntu1604_debs" not in excludes:
        gcs_file(
            name = "ubuntu1604_debs",
            bucket = "gs://container-deps/ubuntu1604/debs",
            file = "%s_debs.tar" % DEBS_TARBALL.revision,
            sha256 = DEBS_TARBALL.sha256,
        )
