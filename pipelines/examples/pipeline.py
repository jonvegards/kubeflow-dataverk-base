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
