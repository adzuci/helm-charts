#######################
Helm charts for edx.org
#######################

Charts are automatically published by GitHub Actions to https://github.com/edx/helm-repo/

Testing
*******

To preview changes:

.. code-block:: shell

    helm-charts $ brew install helm
    helm-charts $ helm dependency update django-ida
    helm-charts $ helm template django-ida -f input-file-here.yaml

To deploy changes locally:

#. Increment django-ida/Chart.yaml version.

#. Check `helm-repo <https://github.com/edx/helm-repo/>`__ is cloned into the parent directory.

#. Run:

    .. code-block:: shell

        helm-repo $ helm dependency update ../helm-charts/django-ida # download any dependencies the chart has
        helm-repo $ helm package ../helm-charts/django-ida # build the tgz file and copy it here
        helm-repo $ helm repo index . # create or update the index.yaml for repo

#. Push the changes to a helm-repo development branch.

#. In your edx-internal repo, choose an application under argocd/applications and open its Chart.yaml.

    #. Change the version to match the version in the first step.

    #. Change the repository by substituting ``master`` with the helm-repo development branch name.

#. Push those changes to a edx-internal development branch.

#. Sync the application in your local ArgoCD pointing to your edx-internal development branch via the web GUI or:

    .. code-block:: shell

        % argocd app sync development-app-name

#. Check development-app-name works correctly in your local ArgoCD.
