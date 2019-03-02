#!/bin/bash
echo import "$1"
mv ~/Downloads/carbon.png source/_drafts/"$1"/cover.png || mv ~/Downloads/carbon.png source/_posts/"$1"/cover.png || exit
