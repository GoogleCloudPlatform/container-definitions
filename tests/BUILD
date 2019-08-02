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

# These targets will be used to do integration tests on the file update service.
# 1. file_with_0 will test the scenario where the file being watched by FUS
#    doesn't exist on GCS and needs to be uploaded to GCS.
# 2. file_with_1 will test the scenario where the file exists on GCS and has
#    the same contents as generated file.
# 3. file_with_2 with test the scenario where the file exists on GCS but the
#    generated file differs and needs to be uploaded to GCS.

genrule(
    name = "file_with_0",
    outs = ["file_with_0.txt"],
    cmd = "echo 0 > $@",
)

genrule(
    name = "file_with_1",
    outs = ["file_with_1.txt"],
    cmd = "echo 1 > $@",
)

genrule(
    name = "file_with_2",
    outs = ["file_with_2.txt"],
    cmd = "echo 2 > $@",
)
