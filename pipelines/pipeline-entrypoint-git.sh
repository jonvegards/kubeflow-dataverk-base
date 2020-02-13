#!/bin/bash
set -e

function cleanup() {
    ARG=$?
    cd ..
    rm -rf datapackages
    exit $ARG
}

trap cleanup EXIT

GIT_REPO=$1
NOTEBOOK_NAME=$2

GH_USER=$(cat ${VKS_SECRET_DEST_PATH}/GITHUB_USER)
GH_TOKEN=$(cat ${VKS_SECRET_DEST_PATH}/GITHUB_TOKEN)

git clone https://${GH_USER}:${GH_TOKEN}@github.com/${GIT_REPO} datapackages

cd datapackages

papermill "${NOTEBOOK_NAME}" output.ipynb
