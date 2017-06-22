#!/bin/bash
# Copyright (C) 2017 David Kim - All Rights Reserved
# Permission to copy and modify is granted under the MIT License.
# Last revised 6/21/2017
#
# Import/Remove my git aliases

if [ $# -eq 0 ]; then  # case: no arg exists

        # import my git aliases

        alias git-init='git init; git commit -m "initial commit" --allow-empty'
        alias git-log='git log --oneline --decorate --all --graph'
        alias git-status='git status --short --branch'
        alias git-push='git push --force-with-lease'

else  # case: an arg exists

        # remove my git aliases

        unalias git-init
        unalias git-log
        unalias git-status
        unalias git-push

fi
