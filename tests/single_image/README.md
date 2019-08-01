A dependency spec that tracks a single image on GCR at
gcr.io/asci-toolchain/dep-update-service-test

The sha256 digest in revisions.bzl file in this directory should always be
set to `sha256:b41c4f20c818952dbf231367122e8f3fbd2a40de9e9a8daa49fdfa6650cba238`
so that dependency update *always* thinks there's an update for this image.
