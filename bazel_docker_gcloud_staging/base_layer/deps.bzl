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

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")
load("//:revisions.bzl", "IMAGE")

def deps():
    """Download dependencies required to use this layer."""
    excludes = native.existing_rules().keys()

    if "fus_managed_ubuntu1604" not in excludes:
        container_pull(
            name = "fus_managed_ubuntu1604",
            digest = IMAGE.sha256,
            registry = "gcr.io",
            repository = "gcp-runtimes/ubuntu_16_0_4",
        )
