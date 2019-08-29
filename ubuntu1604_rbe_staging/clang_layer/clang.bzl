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

clang_env = {
    "ASAN_SYMBOLIZER_PATH": "/usr/local/bin/llvm-symbolizer",
    "CC": "/usr/local/bin/clang",
    "GCOV": "/dev/null",
    "LD_LIBRARY_PATH": "/usr/local/lib",
    "MSAN_SYMBOLIZER_PATH": "/usr/local/bin/llvm-symbolizer",
    "TSAN_SYMBOLIZER_PATH": "/usr/local/bin/llvm-symbolizer",
    "UBSAN_SYMBOLIZER_PATH": "/usr/local/bin/llvm-symbolizer",
}
