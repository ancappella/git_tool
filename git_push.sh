#!/bin/bash

set -e

branch=$(git rev-parse --abbrev-ref HEAD)

target="staging"
while getopts ":f:b:m:t" opt; do
  case $opt in
  f)
    file=$OPTARG
    echo ${file}
    ;;
  b)
    branch=$OPTARG
    echo ${branch}
    ;;
  m)
    message=$OPTARG
    echo ${message}
    ;;
  t)
    target=$OPTARG
    echo ${target}
    ;;
  *)
    echo "未知参数"
    exit 1
    ;;
esac
done

git checkout ${branch}
git status
if [ ${file} ]; then
  git add ${file}
else
  git add .
fi
if [ ${message} ]; then
  git commit -m ${message}
else
  git commit -m ""
fi

git push

git pull

git merge --no-ff commit --log origin/main -m "git merge origin/main"
git merge --no-of commit --log ${branch} -m "merge ${branch}"

git push
echo "切回开发分支"
git checkout ${branch}