#!/bin/bash

GITHUB_USER=yqlbu
GITHUB_REPO=vsphere-hub

flux bootstrap github \
  --owner=${GITHUB_USER} \
  --repository=${GITHUB_REPO} \
  --branch=master \
  --personal \
  --path=deploy/clusters/prod
