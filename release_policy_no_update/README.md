# Test Container

This Bazel project represents a container that serves for the container release
tools e2e tests.
The container in this project tests the release policy feature. This container
has a GCR image dependency that is out of date. However, the release policy
indicates that no release is necessary, hence, an update is not expected.
