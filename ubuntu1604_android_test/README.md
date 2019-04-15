Targets under this folder build an Ubuntu1604 based image that contains
the toolchain required to run Bazel tests for the
[Android testing](https://github.com/googlesamples/android-testing) project.

This toolchain includes Debian packages and shared libraries necessary to run
Android emulator tests. This toolchain also includes compilers/interpreters/runtimes
for the following languages: C++ (Clang), Java 8, Java 11 and Python 2.

In addition, it includes the following tools: binutils, curl, ed, file, git,
openssh client, wget, zip. Note that this container does not include Bazel.

Also note that this image does not include the Android SDK and Android NDK,
which may be required and must be installed/configured separately.

This image is not currently published, but can be built by users on demand.

This image is still in the experimental state and its content may change in the
near future.
