#!/bin/sh
set -e

[ -z "${INPUT_GIT_TOKEN_HOLDER}" ] && {
    echo 'Missing input git_token_holder.';
    exit 1;
};
[ -z "${INPUT_GIT_TOKEN}" ] && {
    echo 'Missing input "git_token: ${{ secrets.GIT_TOKEN }}".';
    exit 1;
};

REPOSITORY_URL=${INPUT_REPOSITORY_URL}
[ -z "${INPUT_REPOSITORY_URL}" ] && {
    echo 'Missing input repository_URL url.';
    exit 1;
};

[ -z "${INPUT_PUSH_DIR}" ] && {
    echo 'Missing input push_dir.';
    exit 1;
};

[ -z "${INPUT_COMMIT_USER}" ] && {
    echo 'Missing input user to commit.';
    exit 1;
};

[ -z "${INPUT_COMMIT_EMAIL}" ] && {
    echo 'Missing input email of the user to commit.';
    exit 1;
};
git config --global user.email ${INPUT_COMMIT_EMAIL}
git config --global user.name ${INPUT_COMMIT_USER}

commit_msg="${INPUT_COMMIT_MESSAGE}"
[ -z "${commit_msg}" ] && {
    commit_msg="Deploy sha"
    # commit_msg="Deploy ${{ github.sha }}"
};

remote_repo="https://${INPUT_GIT_TOKEN_HOLDER}:${INPUT_GIT_TOKEN}@${INPUT_REPOSITORY_URL}"

tmp_path="/tmp/git_push$RANDOM"
mkdir -p $tmp_path
cp -r "${INPUT_PUSH_DIR}" $tmp_path
cd $tmp_path

KEEP_HISTORY=${INPUT_KEEP_HISTORY:-false}
if ${INPUT_KEEP_HISTORY}; then
    tmp_path_dest="/tmp/dest$RANDOM"
    git clone --depth 1 $remote_repo -b $INPUT_BRANCH $tmp_path_dest
    cp -r "$tmp_path_dest/.git/" "$tmp_path/.git/"
    git add .
    git commit -m "${commit_msg}"
    git push -f origin HEAD:${INPUT_BRANCH}
else
    git init
    git remote add origin $remote_repo
    git add .
    git commit -m "${commit_msg}"
    git push -f origin $INPUT_BRANCH
fi
