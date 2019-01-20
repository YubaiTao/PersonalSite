#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="* Update site `date`."
if [ $# -eq 1 ]
  then msg="$1"
fi

# Push Hugo content
git add -A
git commit -m "$msg"
git push

# Build the project
hugo

cd public
git add -A

git commit -a -m "$msg"

git push

cd ..