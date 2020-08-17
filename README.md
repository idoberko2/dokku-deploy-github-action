# dokku-deploy-github-action

This action makes deployment to Dokku as easy as possible!

## Inputs

### ssh-private-key

The private ssh key used for Dokku deployments. Never use as plain text! Configure it as a secret in your repository by navigating to https://github.com/USERNAME/REPO/settings/secrets

- Your private key must *not* have a passphrase

**Required**

### dokku-user

The user to use for ssh. If not specified, "dokku" user will be used.

### dokku-host

The Dokku host to deploy to.

### app-name

The Dokku app name to be deployed.

### remote-branch

The branch to push on the remote repository. If not specified, `master` will be used.

### git-push-flags

You may set additional flags that will be passed to the `git push` command. You might want to set this parameter to `--force` if you're pushing to Dokku from other places and encounter the following error:
```
error: failed to push some refs to 'dokku@mydokkuhost.com:mydokkurepo'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

## Example

Note: `actions/checkout` must preceed this action in order for the repository data to be exposed for the action.
It is recommended to pass `actions/checkout` the `fetch-depth: 0` parameter to avoid errors such as `shallow update not allowed`

```
steps:
  - uses: actions/checkout@v2
    with:
        fetch-depth: 0
  - id: deploy
    name: Deploy to dokku
    uses: idoberko2/dokku-deploy-github-action@v1
    with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
        dokku-host: 'my-dokku-host.com'
        app-name: 'my-dokku-app'
```
