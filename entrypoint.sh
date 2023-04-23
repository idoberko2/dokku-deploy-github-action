#!/bin/bash

SSH_PRIVATE_KEY=$1
DOKKU_USER=$2
DOKKU_HOST=$3
DOKKU_APP_NAME=$4
DOKKU_REMOTE_BRANCH=$5
GIT_PUSH_FLAGS=$6
SSH_PORT=$7
COMMIT="${8:-$GITHUB_SHA}"
MONGODB_URI=$9
PORT=$10

# Setup the SSH environment
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"
ssh-keyscan $DOKKU_HOST >> ~/.ssh/known_hosts

# Create .env file
rm -rf .env
echo "MONGODB_URI=$MONGODB_URI" >> .env
echo "PORT=$PORT" >> .env

# COMMIT .env file
git add .env
git commit -m "Updated .env file" --no-verify

# Setup the git environment
git_repo="$DOKKU_USER@$DOKKU_HOST:$DOKKU_APP_NAME"
cd "$GITHUB_WORKSPACE"
git remote add deploy "$git_repo"

# Prepare to push to Dokku git repository
REMOTE_REF="$COMMIT:refs/heads/$DOKKU_REMOTE_BRANCH"

GIT_COMMAND="git push deploy $REMOTE_REF $GIT_PUSH_FLAGS"
echo "GIT_COMMAND=$GIT_COMMAND"

# Push to Dokku git repository
GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p $SSH_PORT" $GIT_COMMAND
