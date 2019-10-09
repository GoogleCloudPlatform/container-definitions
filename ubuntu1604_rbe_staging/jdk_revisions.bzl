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

# This file is temporarily created here by hand while we resolve issues
# with the gcs bucket for the OpenJDK packages
# TODO(nlopezgi): move these back to revisions.bzl

OPENJDK_INSTALLER = struct(
    revision = "11.29.3-ca-jdk11.0.2/zulu11.29.3-ca-jdk11.0.2-linux_x64-allmodules-90755145cb6e6418584d8603cd5fa9afbb30aecc-1549209950",
    sha256 = "460d8a4f0c0204160b48086e341b22943c9cca471b195340e75b38ae9eb33c1c",
)

OPENJDK_SRC = struct(
    revision = "11.31.11-ca-jdk11.0.3/zsrc11.31.11-jdk11.0.3",
    sha256 = "65afc25dd914a094e25b1f804160bb20849f923d9a4b7d989f885558922e8182",
)

