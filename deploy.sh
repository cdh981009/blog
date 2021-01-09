#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Go to Public folder
cd public
shopt -s extglob
rm -r -- !(.git)
cd ..

# Build the project.
hugo

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="Rebuild on `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..

# blog 저장소 Commit & Push
git add .

msg="Rebuild on `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master