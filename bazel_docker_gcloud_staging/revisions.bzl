# Copyright 2019 Google LLC
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

# This file contains invalid pointers to all pins to ensure that only after a
# proper run of FUS + DUS, the targets depending on these pins become
# buildable. For this test scenario, the checked in version of this file is
# always expected to be in this state, so that the final image depending on all
# these pins can only be built after FUS + DUS execute as expected.

IMAGE = struct(
    sha256 = "invalid sha256 to be updated by DUS",
)

BAZEL_INSTALLER = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

BAZEL_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

CLANG_INSTALLER = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

LIBCXX_INSTALLER = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

CLANG_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

DOCKER_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

GCLOUD_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

JAVA_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

CACERTS = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)

PYTHON_DEBS_TARBALL = struct(
    revision = "invalid revision to be replaced by DUS",
    sha256 = "invalid sha256 to be replaced by DUS",
)
