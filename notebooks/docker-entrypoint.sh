BUCKET_ENDPOINT_FILE=${VKS_SECRET_DEST_PATH}/DATAVERK_BUCKET_ENDPOINT

if test -f "$BUCKET_ENDPOINT_FILE"; then
    export DATAVERK_BUCKET_ENDPOINT=$(cat $BUCKET_ENDPOINT_FILE)
fi

export EDITOR='nano'
#export DATAVERK_SETTINGS_PATH='/home/jovyan'

jupyter notebook --notebook-dir=/home/${NB_USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
