# Test Container

This Bazel project represents a container that serves for the container release
tools e2e tests.
The container in this project tests the release policy feature. This container
has a GCS file dependency being updated by a file update service. After the GCS
file is updated, the dependency update service determines that a newer file is
available and updates it because the release policy indicates that a release is
necessary.
