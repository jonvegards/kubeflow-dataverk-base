#!/bin/sh
set -e

export APPLICATION_NAME=$(cat "${K8S_SERVICEACCOUNT_PATH}/namespace")
export KF_TEAM_NAME=$(cat "${K8S_SERVICEACCOUNT_PATH}/namespace")

jupyter lab --notebook-dir=/home/${NB_USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
