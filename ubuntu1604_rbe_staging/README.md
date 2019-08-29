# Test Container

This Bazel project represents a container that serves for the container release
tools e2e tests.
The container in this project duplicates the prod version of the
[ubuntu1604_rbe](https://github.com/GoogleCloudPlatform/container-definitions/tree/master/ubuntu1604_rbe)
container.

The pull requests updating the dependency pins for this container will always
be merged allowing this e2e test case to replicate the prod version as much as
possible.
