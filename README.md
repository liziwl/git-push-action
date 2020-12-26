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
    - name: Push dir to Git
      uses: liziwl/git-push-action@master
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

| name | value | default | required | description |
|-|-|-|-|-|
| git_token_holder | string |  | Y | Username of token holder |
| git_token | string |  | Y | Token for the destination repo. Can be passed in using $\{{ secrets.GIT_TOKEN }} |
| repository_url | boolean |  | Y | Repository URL after "https://", like "github.com/USER_NAME/REPO_NAME.git" |
| push_dir | string |  | Y | Directory to push |
| commit_user | string |  | Y | User to commit |
| commit_email | string |  | Y | Email of the user to commit |
| branch | string | 'master' |  | Destination branch to push changes |
| keep_history | boolean | false |  | Keep commit history |
| commit_message | string | "Deploy ${{ github.sha }}" |  | Commit messgae |