# dokku-deploy-github-action
This action makes deployment to Dokku as easy as possible!

## Inputs
### ssh-private-key
The private ssh key used for Dokku deployments. Never use as plain text! Configure it as a secret in your repository by navigating to https://github.com/USERNAME/REPO/settings/secrets

**Required**

### dokku-user
The user to use for ssh. If not specified, "dokku" user will be used.

### dokku-host
The Dokku host to deploy to.

### app-name
The Dokku app name to be deployed.

### remote-branch
The branch to push on the remote repository. If not specified, "master" will be used.

## Example
Note: `actions/checkout` must preceed this action in order for the repository data to be exposed for the action.

```
steps:
  - uses: actions/checkout@master
  - id: deploy
    name: Deploy to dokku
    uses: idoberko2/dokku-deploy-github-action@master
    with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
        dokku-host: 'my-dokku-host.com'
        app-name: 'my-dokku-app'
```
