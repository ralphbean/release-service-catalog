# publish-pyxis-repository

Tekton task to mark all repositories in the mapped snapshot as published in Pyxis.
This is currently only meant to be used in the rh-push-to-registry-redhat-io pipeline,
so it will convert the values to the ones used for registry.redhat.io releases.
E.g. repository "quay.io/redhat-prod/my-product----my-image" will be converted to use
registry "registry.access.redhat.com" and repository "my-product/my-image" to identify
the right Container Registry object in Pyxis. The task also optionally
marks the repositories as source_container_image_enabled true if pushSourceContainer
is true in the data JSON. 


## Parameters

| Name         | Description                                                                                       | Optional | Default value      |
|--------------|---------------------------------------------------------------------------------------------------|----------|--------------------|
| server       | The server type to use. Options are 'production' and 'stage'                                      | Yes      | production         |
| pyxisSecret  | The kubernetes secret to use to authenticate to Pyxis. It needs to contain two keys: key and cert | No       | -                  |
| snapshotPath | Path to the JSON string of the mapped Snapshot spec in the data workspace                         | Yes      | snapshot_spec.json |
| dataPath     | Path to the JSON string of the merged data to use in the data workspace                           | Yes      | data.json          |

## Changes in 0.2.0
* If a data JSON is provided and images.pushSourceContainer is set to true inside it, a call is made
  to mark the repository as source_container_image_enabled true

## Changes since 0.0.2
* Updated hacbs-release/release-utils image to reference redhat-appstudio/release-service-utils image instead

## Changes since 0.0.1

* Minor change to logging to provide more context about the pyxis repo request on failure
