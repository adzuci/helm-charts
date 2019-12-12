#! /usr/bin/env bash
cd ..
git checkout https://$GITHUB_ACCESS_TOKEN@github.com/edx/helm-repo
cd helm-repo
for chart in $(find ../helm-charts/ -name 'requirements.yaml'); do
  /tmp/helm dep update $(dirname ${chart})
  /tmp/helm package $(dirname ${chart})
done
/tmp/helm repo index .
git add .
git commit -a -m "$TRAVIS_COMMIT_MESSAGE" --author "Helm Build automation <admin@edx.org>"
git push
