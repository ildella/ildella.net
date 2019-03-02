#!/bin/bash
echo timestamping "$1"
hexo publish post "$1"
ots-cli.js s source/_posts/"$1".md
mv source/_posts/"$1".md.ots source/_posts/"$1"/
git commit -m source/_posts/"$1"* "publishing $1"
git push origin master