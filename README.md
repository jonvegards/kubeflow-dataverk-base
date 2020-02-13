![](https://github.com/navikt/kubeflow-api/workflows/build%20and%20deploy/badge.svg)

# kubeflow-dataverk-base
Base docker image for jupyterhub servers in kubeflow

# Getting-started guide for kubeflow

## Opprett eget kubeflow namespace
```
1. Gå til https://kubeflow.adeo.no
2. Logg inn med LDAP
3. Klikk "Start Setup"
4. Under "Namespace Name", skriv teamnavn
5. Trykk "Finish"
```

## (optional) Opprett vault område for kubeflow namespacet
Følg stegene under "Nytt team/namespace" og "Nye hemmeligheter i Vault" i https://github.com/navikt/naisflow/blob/master/README.md.

## (optional) Secrets
```
1. Gå til https://vault.adeo.no
2. Gå til pathen kv/prod/kubeflow
3. Trykk "Create secret" og under "Path for this secret" skriv <teamnavn>/<teamnavn>
4. Legg inn key-value secrets her, f.eks.  
      key: DVH_CONNECTION_STRING
      value: oracle://<user>:<password>@<host>:<port>/<service_name>
```

## Opprett jupyter notebook server
```
1. Gå til https://kubeflow.adeo.no
2. Gå til "Notebook servers" i menyen til venstre
3. Klikk "+ NEW SERVER"
4. Huk av for "Custom image" og skriv inn docker.pkg.github.com/navikt/kubeflow-dataverk-base/kubeflow-dataverk-base:<version>
    - Erstatt <version> med seneste tag av dockerimaget (finnes på https://github.com/navikt/kubeflow-dataverk-base/packages/48749)
5. Antall CPU'er og minne for notebook-serveren kan spesifiseres. Oppfordrer til å bruke default-oppsettet her (0.5 cpu, 1.0Gi), dette kan også endres senere ved behov.
6. Trykk launch
```

## (optional) Legg til contributors
Namespacet som opprettes i "Opprett eget kubeflow namespace" er i utgangspunktet personlig. Dersom man ønsker å samarbeide med andre i kubeflow-namespacet kan man gjøre følgende:
```
1. Fra https://kubeflow.adeo.no, gå til "Manage Contributors" i menyen til venstre
2. Legg til nav-eposten til brukeren du ønsker å invitere (f.eks. Ola.Nordmann@nav.no)
```

## Create kubeflow pipeline
### Install conversion tool:
```
latest_version=$(curl --silent https://api.github.com/repos/kubeflow/pipelines/releases/latest | jq -r .tag_name)
pip install https://storage.googleapis.com/ml-pipeline/release/${latest_version}/kfp.tar.gz --upgrade
```

### Create kubeflow pipeline
```
dsl-compile --py [path/to/python/file] --output [path/to/output/tar.gz]
```

### pipeline.py example
```python
import kfp.dsl as dsl


# a single-op pipeline that runs the dataverk notebook
@dsl.pipeline(name='DataverkPipeline', description='Execute dataverk notebook')
def notebook_pipeline(github_repo=dsl.PipelineParam('github-repo'),
                      datapackage_name=dsl.PipelineParam('datapackage-name'),
                      notebook_name=dsl.PipelineParam('notebook-name'),
                      settings_repo=dsl.PipelineParam('settings-repo')):

    notebookop = dsl.ContainerOp(
      name='execute_notebook',
      image='docker.pkg.github.com/navikt/kubeflow-dataverk-base/kubeflow-dataverk-pipeline:2019-11-15-4c1e814',
      arguments=[
        github_repo,
        datapackage_name,
        notebook_name,
        settings_repo
      ]
    )
```