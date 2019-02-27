#!/bin/bash
workdir=`pwd`
cd $workdir
if [ $# -eq 0 ]; then
  branchs=`git branch | sed 's/\*//g'`
else
  branchs=`git branch | grep "$1" | sed 's/\*//g'`
fi
for branch in $branchs
do
  if [ $branch == master ] || [ $branch == trunk ];
  then
    continue
  elif [[ $branch == release/* ]]; then
    git br -D $branch
  else
    git tag archive/$branch $branch
    git br -D $branch || git tag -d archive/$branch
  fi
done

exit 0
