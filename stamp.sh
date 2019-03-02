#!/bin/bash
echo timestamping "$1"
ots-cli.js s source/_posts/"$1".md
mv source/_posts/"$1".md.ots source/_posts/"$1"/