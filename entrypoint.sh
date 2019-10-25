#!/bin/sh -l

export SSH_PRIVATE_KEY=$1
git-push dokku@$2:$3
