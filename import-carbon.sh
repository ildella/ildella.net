#!/bin/bash
echo import "$1"
mv ~/Downloads/carbon.svg source/_drafts/"$1"/cover.svg || mv ~/Downloads/carbon.svg source/_posts/"$1"/cover.svg || exit
