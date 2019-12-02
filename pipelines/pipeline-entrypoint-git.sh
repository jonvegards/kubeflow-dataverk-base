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
DATAPACKAGE_NAME=$2
NOTEBOOK_NAME=$3
SETTINGS_REPO=$4

GH_USER=$(cat ${VKS_SECRET_DEST_PATH}/GITHUB_USER)
GH_TOKEN=$(cat ${VKS_SECRET_DEST_PATH}/GITHUB_TOKEN)

git clone https://${GH_USER}:${GH_TOKEN}@github.com/${GIT_REPO} datapackages
git clone https://${GH_USER}:${GH_TOKEN}@github.com/${SETTINGS_REPO} settings

cp settings/settings.json datapackages/${DATAPACKAGE_NAME}/settings.json
cd datapackages/${DATAPACKAGE_NAME}

papermill "${NOTEBOOK_NAME}" output.ipynb

# todo: store output notebook
