#!/bin/bash

mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$1"
ssh-keyscan $3 >> ~/.ssh/known_hosts
git_repo="$2@$3:$4"
cd "$GITHUB_WORKSPACE"
git remote add deploy "$git_repo"
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git push deploy "$GITHUB_SHA:refs/heads/$5"
