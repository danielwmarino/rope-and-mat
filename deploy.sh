#!/usr/bin/env bash
# Publish the Rope & Mat program to GitHub Pages.
# Put index.html (and README.md if you want it) in an empty folder, then run this from there.
# Requires the GitHub CLI: brew install gh && gh auth login

set -euo pipefail

REPO="rope-and-mat"          # change if you want a different repo name
VISIBILITY="--public"        # GitHub Pages needs public on a free account

git init -b main
git add .
git commit -m "The 6-Day Rope & Mat Program"

gh repo create "$REPO" $VISIBILITY --source=. --remote=origin --push

# Serve the repo root of main as a Pages site
gh api -X POST "repos/{owner}/$REPO/pages" \
  -f 'source[branch]=main' -f 'source[path]=/' >/dev/null 2>&1 \
  || gh api -X PUT "repos/{owner}/$REPO/pages" \
       -f 'source[branch]=main' -f 'source[path]=/'

USER=$(gh api user --jq .login)
echo
echo "Live in a minute or two at:"
echo "  https://${USER}.github.io/${REPO}/"
