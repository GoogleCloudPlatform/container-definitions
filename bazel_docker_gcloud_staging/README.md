# Test Container

This Bazel project represents a container that serves for the container release
tools e2e tests.
The container in this project duplicates the prod version of the
[ubuntu1604_bazel_docker_gcloud](https://github.com/GoogleCloudPlatform/container-definitions/tree/master/ubuntu1604_bazel_docker_gcloud)
container.

The pull requests updating the dependency pins for this container will not be
merged allowing this e2e test case to always open a pull request which triggers
the build, test and push of the image every time the test is executed.
