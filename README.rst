#######################
Helm Charts for edx.org
#######################

This repository is primarily for hosting charts used to host edx.org-related Django services.  A `helm chart`_ is a collection of files that describe a related set of Kubernetes resources.  These files are a work in progress and may change at any time.  Some assumptions are currently made including the assumption that nginx-ingress and external-dns are available.  These assumptions may be abstacted out in the future.  Please see https://github.com/openedx/openedx-k8s-harmony for other Open edX related charts. 

Publishing
**********

Charts are automatically published by GitHub Actions to a private Helm repo for 2U consumption at https://github.com/edx/helm-repo.  This may change in the future.  Note other private 2U charts live in https://github.com/2uinc/helm-charts.

Charts
======

django-ida
----------

This chart is for Django services.  See `the changelog`_ for more details.



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

Contributions
*************

This repo is not currently accepting contributions from non-2U employees.

Reporting Security Issues
*************************

Please do not report security issues in public. Please email security@edx.org.

.. _the changelog: https://github.com/edx/helm-charts/blob/master/django-ida/CHANGELOG
.. _helm chart: https://helm.sh/docs/topics/charts
