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
- name: 'java-version'
  command: 'java'
  args: ['-version']
  # java outputs to stderr.
  expectedError: ["openjdk version \"1.8.*"]
- name: 'java11-version'
  command: '/usr/lib/jvm/{_JAVA_REVISION}/reduced/bin/java'
  args: ['-version']
  # java outputs to stderr.
  expectedError: ["openjdk version \"11.*"]
- name: 'check-openssl'
  command: 'openssl'
  args: ['version']
  expectedOutput: ['OpenSSL .*']

fileExistenceTests:
- name: 'OpenJDK'
  path: '/usr/lib/jvm/java-8-openjdk-amd64'
  shouldExist: true
- name: 'OpenJDK 11'
  path: '/usr/lib/jvm/{_JAVA_REVISION}'
  shouldExist: true
- name: 'OpenJDK 11 srcs'
  path: '/usr/src/jdk/{_SRC_REVISION}.zip'
  shouldExist: true

metadataTest:
  env:
    - key: 'JAVA_HOME'
      value: '/usr/lib/jvm/java-8-openjdk-amd64'
