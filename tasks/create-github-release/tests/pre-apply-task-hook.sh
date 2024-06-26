#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Add mocks to the beginning of task step script
yq -i '.spec.steps[0].script = load_str("'$SCRIPT_DIR'/mocks.sh") + .spec.steps[0].script' $SCRIPT_DIR/../create-github-release.yaml

# Create a dummy github secret (and delete it first if it exists)
kubectl delete secret test-create-github-release-token --ignore-not-found
kubectl create secret generic test-create-github-release-token --from-literal=token=mytoken
