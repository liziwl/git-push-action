# GitHub Action for Git Push to any repository

## Usage

### Example Workflow file

An example workflow to authenticate with GitHub Platform:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
      with:
        persist-credentials: false # otherwise, the token used is the GITHUB_TOKEN, instead of your personal token
        fetch-depth: 0 # otherwise, you will failed to push refs to dest repo
    - name: Create local changes
      run: |
        ...
    - name: Push changes
      uses: liziwl/github-push-action@master
      with:
        git_token_holder: 'token_holder_username'
        git_token: '${{ secrets.GIT_TOKEN }}'
        commit_user: 'commit_username'
        commit_email: 'commit_email'
        push_dir: 'a_dir'
        repository_url: 'Repository https clone URL after "https://"'
        # keep_history: false # default false, not keep history
        # branch: master # default master
        # commit_message: 'Psuh by action bot' # default "Deploy ${{ github.sha }}"
```

### Inputs

| name | value | default | description |
| ---- | ----- | ------- | ----------- |
| git_token_holder | string | | Token for the repo. Can be passed in using `${{ secrets.GITHUB_TOKEN }}`. |
| git_token | string | | Destination branch to push changes. Can be passed in using `${{ github.ref }}`. |
| repository_url | boolean | false | Determines if force push is used. |
| push_dir | boolean | false | Determines if `--tags` is used. |
| commit_user | string | '.' | Directory to change to before pushing. |
| commit_email | string | '' | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.  |
| branch | string | '' | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.  |
| keep_history | string | '' | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.  |
| commit_message | string | '' | Repository name. Default or empty repository name represents current github repository. If you want to push to other repository, you should make a [personal access token](https://github.com/settings/tokens) and use it as the `github_token` input.  |
