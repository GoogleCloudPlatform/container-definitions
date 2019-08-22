# Test Container

This Bazel project represents a container that serves for the container release
tools e2e tests.
The container in this project tests all the types of supported dependencies
that need to be successfully updated. The image being built depends on a GCR
image, a GitHub repository, a GCS file not managed by file update service and
two GCS files managed by file update service one of which is a generic file and
the other is a file that supports metadata generation.
