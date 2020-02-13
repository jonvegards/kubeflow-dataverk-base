![](https://github.com/navikt/kubeflow-api/workflows/build%20and%20deploy/badge.svg)

# kubeflow-dataverk-base
Base docker images for notebook servers i kubeflow. 

Det finnes tre ulike imager:
1. kubeflow-dataverk-jupyterhub:<tag>
    - base image med jupyterhub miljø
2. kubeflow-dataverk-jupyterlab:<tag>
    - base image med jupyterlab miljø
3. kubeflow-dataverk-pipeline
    - base image for å kjøre schedulerte jupyter notebooks som en kubeflow pipeline

# Legge til pakker
Dersom det ønskes nye python pakker inn i baseimagene så kan man lage en pull request til dette repoet med ønsket pakke lagt til i requirements.txt
