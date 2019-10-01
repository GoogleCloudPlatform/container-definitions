Targets under this folder build images that are ubuntu1604 based and contain the
toolchain necessary to run many Bazel builds. This toolchain includes
compilers/interpreters/runtimes for the following languages: C++ (Clang), Java,
Python 2, Python 3, Go. It also includes the following tools: binutils, curl,
ed, file, git, openssh client, wget, zip. Note this container does not include Bazel.

This image is published at https://console.cloud.google.com/marketplace/details/google/rbe-ubuntu16-04.
