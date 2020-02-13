import kfp.dsl as dsl


# a single-op pipeline that runs the dataverk notebook
@dsl.pipeline(name='Test', description='Execute test ml pipeline')
def notebook_pipeline(github_repo=dsl.PipelineParam('github-repo'),
                      notebook_name=dsl.PipelineParam('notebook-name')):

    notebookop = dsl.ContainerOp(
      name='execute_notebook',
      image='docker.pkg.github.com/navikt/kubeflow-dataverk-base/kubeflow-dataverk-pipeline:2020-02-13--pipeline0.2.5',
      arguments=[
        github_repo,
        notebook_name
      ]
    )
