Targets under this folder build images that are ubuntu1604 based and contain the
toolchain necessary to run Bazel builds and tests for the
[Angular](https://github.com/angular/angular) project.

This toolchain includes Debian packages and shared libraries necessary to run
Angular web tests. This toolchain also includes compilers/interpreters/runtimes
for the following languages: C++ (Clang), Python 2, Python 3.

In addition, it includes the following tools: binutils, curl, ed, file, git,
openssh client, wget, zip. Note this container does not include Bazel.

The image will be published soon. For now, it can be built on demand by users.
