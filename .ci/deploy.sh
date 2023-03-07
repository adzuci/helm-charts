#! /usr/bin/env bash
cd ..
git clone https://edx-deployment:${GITHUB_ACCESS_TOKEN}@github.com/edx/helm-repo
cd helm-repo
for chart in $(find ../helm-charts/ -name 'Chart.yaml'); do
  /tmp/helm dep update $(dirname ${chart})
  /tmp/helm package $(dirname ${chart})
done

# Print warning if we detect existing charts that would be overwritten
if git status --porcelain | grep -E '^(M.|.M)'; then
    echo "WARNING: Not overwriting the following chart(s) that already exist in the repo"
    echo "WARNING: Please update the version(s) in Chart.yaml to upload new versions"
    git status --porcelain | grep -E '^(M.|.M)' | awk '{print $2}'
fi

# Checkout existing files showing up as modified to prevent overwriting existing versions
git checkout $(git status --porcelain | grep -E '^(M.|.M)' | awk '{print $2}')

/tmp/helm repo index .
git config --global user.email "admin@edx.org"
git config --global user.name "Helm Build automation"
git add .
git commit -a -m "$COMMIT_MESSAGE"
git push
