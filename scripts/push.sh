#!/bin/bash
# This script syncs all remote branches and tags.
# Usage: ./push.sh

read -rp "Destination branch (leave empty to push all branches): " branch

if [ -z "$branch" ]; then
  git push --all
else
  git push origin "$branch"
fi

git push --tags

if [ $? -ne 0 ]; then
  echo "Push failed." >&2
  exit 1
fi

echo "Push completed successfully."
