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

schemaVersion: "2.0.0"

commandTests:
- name: 'clang-version'
  command: 'clang'
  args: ['--version']
  expectedOutput: ['clang version 10.0.0 [(]trunk {_CLANG_REVISION}[)]']

fileExistenceTests:
- name: 'Clang'
  path: '/usr/local/bin/clang'
  shouldExist: true
- name: 'libcxx-header'
  path: '/usr/local/include/c++/v1'
  shouldExist: true
- name: 'libcxx-lib'
  path: '/usr/local/lib/libc++.a'
  shouldExist: true
- name: 'llvm-symbolizer'
  path: '/usr/local/bin/llvm-symbolizer'
  shouldExist: true
- name: 'sanitizer'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer'
  shouldExist: true
- name: 'sanitizer-allocator'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/allocator_interface.h'
  shouldExist: true
- name: 'sanitizer-asan'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/asan_interface.h'
  shouldExist: true
- name: 'sanitizer-common_defs'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/common_interface_defs.h'
  shouldExist: true
- name: 'sanitizer-coverage'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/coverage_interface.h'
  shouldExist: true
- name: 'sanitizer-dfsan'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/dfsan_interface.h'
  shouldExist: true
- name: 'sanitizer-linux_syscall_hooks'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/linux_syscall_hooks.h'
  shouldExist: true
- name: 'sanitizer-lsan'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/lsan_interface.h'
  shouldExist: true
- name: 'sanitizer-msan'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/msan_interface.h'
  shouldExist: true
- name: 'sanitizer-tsan_atomic'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/tsan_interface_atomic.h'
  shouldExist: true
- name: 'sanitizer-tsan'
  path: '/usr/local/lib/clang/10.0.0/include/sanitizer/tsan_interface.h'
  shouldExist: true

metadataTest:
  env:
    - key: 'CC'
      value: '/usr/local/bin/clang'
    - key: 'GCOV'
      value: '/dev/null'
