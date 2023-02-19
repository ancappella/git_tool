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
git commit -m ${message}
git push


