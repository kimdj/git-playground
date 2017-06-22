<!--- NOTE: in Markdown, include two whitespaces at the end of a line to signify a new line --->

###### Git Mantras
:octocat: says, "Commit early, commit often."  
:octocat: says, "Branch early, branch often."  
:octocat: says, "Branches are cheap."
:octocat: says, "When in doubt, revert."

  
#### Useful Links
http://learngitbranching.js.org  
https://www.atlassian.com/git/tutorials/what-is-version-control  
http://csci221.artifice.cc/lecture/collaboration-with-git.html  
https://www.youtube.com/watch?v=3a2x1iJFJWc (high-level overview of a Git Workflow)  
https://www.derekgourlay.com/blog/git-when-to-merge-vs-when-to-rebase/  

# Git Playground
This repository is used to practice git commands.  Feel free to experiment, and don't worry about breaking things.  
That's what this repo's for!

## Git Workflow
Before we get started, take a quick look at the git workflow:  
  
![Git Workflow](http://csci221.artifice.cc/images/simple_git_daily_workflow.png)  
  
Don't worry if you haven't got a clue what this flowchart means.  
Detailed explanations will be given below.

## What is a commit?
A commit is a snapshot of all the files in your project.  
  
Every commit object has a unique SHA-1 (Secure Hash Algorithm 1, a cryptographic hash function) that is generated based on the information it represents. You can refer to a commit by the first four characters of it's SHA-1.  
For more details, visit: https://tinyurl.com/zar8dkn

## How do I make a new commit?
First, make some changes to your project.
```
$ echo "My new changes" >> changes.txt
$ ls -lash
 8 -rw-r--r--   1 macbookpro  staff    12B Jun 20 13:51 changes.txt
```

Then, add the new file to the staging area.
```
$ git add changes.txt
```

Or, you can add all changes to the staging area.
```
$ git add .
```

Then, make a new commit with a short message stating the reason for the commit.
```
$ git commit -m "added changes.txt"
[master 05c3272] added changes.txt
 1 file changed, 1 insertion(+)
 create mode 100644 changes.txt
```

Or, you can make a new commit with a long message.  
A text editor (vim) will launch and prompt you for a commit message.
```
$ git commit
```

You can also verify the new commit.
```
$ git log
Author: David Kim <kim.david.j@gmail.com>
Date:   Tue Jun 20 14:11:29 2017 -0700

    added changes.txt

commit 73f4c091a231db91af5f9fa3d5ccb89b3e161892
Author: David Kim <kim.david.j@gmail.com>
Date:   Tue Jun 20 14:06:36 2017 -0700

    Initial commit
```

## How do I undo the last commit?
This will simply undo the commit and keep the unstaged changes in your working tree.
```
$ git reset HEAD^
```
Note: git reset is essentially the opposite of git add.  
To stage changes:
```
$ git add file1 file2
```

To unstage changes:
```
$ git reset HEAD file1 file2
```
  
Alternatively, if you want to undo the commit and keep the staged changes, do:
```
$ git reset --soft HEAD^
```

## Well, that was really confusing ... would you PLEASE throw me a bone?!  

![Git Stages](https://ducquoc.files.wordpress.com/2013/08/git_data_transport_new.png?w=640)
  
## I changed my mind. How do I redo the last commit?
```
$ git reset HEAD@{1}
```

## How do I obliterate the last commit (along with the changes)?
```
$ git reset --hard HEAD^
HEAD is now at 73f4c09 Initial commit
```

## How do I obliterate the last 2 commits?
```
$ git reset --hard HEAD~2
HEAD is now at 73f4c09 Initial commit
```

## D'OH!!!  I totally screwed up and did a hard reset.  Can I fix it?
Yes!  First, look for the commit you want to go back to:
```
$ git reflog
73f4c09 HEAD@{0}: reset: moving to HEAD~2
dd4ba9c HEAD@{1}: commit: added foo.txt
8d7357e HEAD@{2}: commit: added foo.txt
```

Then, do a hard reset to that particular commit.
```
$ git reset --hard HEAD@{1}
```

## What is HEAD?
HEAD is the ref (reference, or symbolic name) for the commit that's currently checked out.  
You can think of it as a pointer to a commit.

## Detaching HEAD
Detaching HEAD just means attaching it to a commit instead of a branch.  

## What is origin?
It is an alias, or reference, to a url of a particular remote repository on your system.  
So, as an example:  
  
The following command says to push your local master branch to origin's master branch.
```
git push origin master:master
```
It's basically doing this:
```
git push git@github.com:git/git.git master:master
```
In other words, origin is resolved into its url.

## What are branches?
Branches are just pointers to specific commits.  
Remember: HEAD is also just a pointer to a commit.  
  
When a branch points to a particular commit, it will include the commit itself plus all of it's parent commits (or ancestors).  
The default branch name in Git is: master.

### Git Branch Example
When you create a new branch, the new branch will point to whatever commit you're currently on.  
In other words, your new branch will point to HEAD.  
  
Let's create two branches: dev and test.
```
$ git branch dev
$ git branch test
```

Now, let's see which branch we're currently on (most likely the master branch).
```
$ git branch
  dev
* master
  test
```

Let's say we want to work on the dev branch.  That is, we want to make commits to the dev branch.  
First, we need to make sure to checkout the dev branch.
```
$ git checkout dev
Switched to branch 'dev'
```

Now, when we make a new commit, it will be included in the new branch.
```
$ echo "My new features." >> new_features.txt
$ git add new_features.txt
$ git commit -m "adding new_features.txt"
[dev 495ab90] added new_features.txt
 1 file changed, 1 insertion(+)
 create mode 100644 new_features.txt
```

Notice how the new changes were recorded on the dev branch ...
```
$ git log
commit 495ab9051d26476262033795b6d2f3a2050a9c91
Author: David Kim <kim.david.j@gmail.com>
Date:   Tue Jun 20 14:08:14 2017 -0700

    added new_features.txt

commit 73f4c091a231db91af5f9fa3d5ccb89b3e161892
Author: David Kim <kim.david.j@gmail.com>
Date:   Tue Jun 20 14:06:36 2017 -0700

    Initial commit
```

... but not on the master branch.
```
$ git checkout master
$ git log
commit 73f4c091a231db91af5f9fa3d5ccb89b3e161892
Author: David Kim <kim.david.j@gmail.com>
Date:   Tue Jun 20 14:06:36 2017 -0700

    Initial commit
```

## How do you delete a branch?
```
$ git branch -d test
Deleted branch test (was 73f4c09).
```

##### :octocat: says, "Here's a tip":
To create a new branch & check it out at the same time, use the following command:
```
$ git checkout -b test
Switched to a new branch 'test'
```

##### :octocat: says, "Here's a tip":
To list all branches including remote branches, use the following command:
```
git branch -a
  bar
  dev
  foo
* master
  new_feature
  test
  remotes/origin/HEAD -> origin/master
  remotes/origin/bar
  remotes/origin/dev
  remotes/origin/foo
  remotes/origin/master
  remotes/origin/new_feature
  remotes/origin/test
```

##### :octocat: says, "Here's a tip":
If you don't want your new branch to point to HEAD, you can specify a commit.  
To branch from a particular commit, use the following command:
```
$ git branch dev HEAD~3
$ git branch test 27cd
```

## How do you combine work from two different branches?
There are two methods: merge and rebase.  
  
Merging creates a special commit that has two unique parents.  Merging essentially converges two branches into a single commit.  
  
Rebasing copies a sequence of commits and places them on top of another commit.  This gives it a sequential look (rebase) instead of a divergent/convergent look (merge).

Rebasing makes your commit tree look very clean since everything is in a straight line.  
But it also modifies the history of the commit tree.

Merging preserves history.  
But it can also make your commit tree look very complex, and confusing.

Choosing whether to rebase or merge depends on a developer's preference.

## Git Merge Example
Let's do some work in a new branch, and then let's merge it into the master branch.  
  
First, let's create a new branch called hotFix.
```
$ git branch hotFix
```

Now, let's checkout the new branch.
```
$ git checkout hotFix
Switched to branch 'hotFix'
```

Let's make some changes to our project and make a new commit.
```
echo "My hotFix changes." >> changes.txt
$ git add changes.txt
$ git commit -m "added changes.txt"
[hotFix fa6d294] added changes.txt
 1 file changed, 1 insertion(+)
 create mode 100644 changes.txt
```

Now, if you want to merge the hotFix branch into the master branch, you need to first checkout the master branch.
```
$ git checkout master
Switched to branch 'master'
```

Then, you can merge the hotFix branch **into** the master branch.
```
$ git merge hotFix
Updating 73f4c09..fa6d294
Fast-forward
 changes.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 changes.txt
```

Now, if you want to update master to point to hotFix, you need to checkout hotFix and merge master.
```
$ git checkout hotFix
$ git merge master
```

##### :octocat: says, "Here's a tip":
Just remember to first checkout a branch.  
Then merge dev **into** the current branch.
```
$ git checkout master
$ git merge dev
```

## Git Rebase Example
Let's do some work in a new branch, and then let's rebase our work **onto** the master branch.  
  
Let's create a new branch called bugFix ...
```
$ git branch bugFix
```

... and let's checkout the new branch.
```
$ git checkout bugFix
Switched to branch 'bugFix'
```

Let's make some changes to our project and make a new commit.
```
$ echo "My bugFix changes." >> bugFixChanges.txt
$ git add bugFixChanges.txt
$ git commit -m "added bugFixChanges.txt"
[bugFix 3851f35] added bugFixChanges.txt
 1 file changed, 1 insertion(+)
 create mode 100644 bugFixChanges.txt
```

Now, if you want to rebase the bugFix branch **onto** the master branch, you need to first checkout the bugFix branch.  
```
$ git checkout bugFix
Already on 'bugFix'
```
But since we're already on the bugFix branch, we're good to go!  
  
Then, you can rebase the bugFix branch **onto** the master branch.
```
$ git rebase master
```

Now, if you want master to also point to bugFix, you need to checkout master and rebase bugFix.
```
$ git checkout master
$ git rebase bugFix
```

Or as a shortcut, you can just make master point to bugFix:
```
$ git branch -f master bugFix
```

##### :octocat: says, "Here's a tip":
Just remember that the ordering of args is somewhat **counter-intuitive**.  
Think: Cut and Paste SOURCE "onto" DESTINATION
```
$ git rebase DESTINATION SOURCE
```

##### :octocat: says, "Here's a tip":
Think: The ordering of arguments for rebase is the "opposite" of merge
```
$ git merge SOURCE
$ git rebase DESTINATION
$ git rebase DESTINATION SOURCE
```

## Git Merge and Rebase Tips
Remembering how to merge and rebase may be difficult at first, but practice makes perfect.  
And the following tips will help you remember how to use git merge and rebase:

To merge SOURCE **into** DESTINATION:
```
$ git checkout SOURCE
$ git merge DESTINATION
```

To rebase SOURCE **onto** DESTINATION:
```
$ git rebase DESTINATION SOURCE
```

## How do you move around in the source tree?
You can make a branch point to any commit using the following command:
```
$ git branch -f <source> <destination>
```

## How do you reverse/undo changes in Git?
There are two primary ways to undo changes in Git: reset and revert.  
  
Bottom line: git revert is the "safe" way to undo changes; git reset is the dangerous method.  
This is because git revert maintains history whereas git reset modifies history.  
  
Git Reset Example:
```
$ git reset --soft HEAD^
```

Git Revert Example:
```
$ git revert HEAD
```

##### :octocat: says, "Here's a tip":
When in doubt, revert!

## What is Git Cherry-Pick?
It let's you copy a series of commits, and paste them below your current location (HEAD).

## Cherry-Pick Example
Let's say you have commits aa78, bb78 and cc78 in branches A, B and C, respectively.  
And let's say you want to combine the three commits into a new D branch.  
You can do so using the following command:
```
$ git checkout -b D
$ git cherry-pick aa78 bb78 cc78
```
Note: Order matters.

## How do you undo your last commit?
If you want to discard these changes, use the following command:
```
$ git reset --hard HEAD~1
```

But if you want to keep these staged changes, use the --soft flag.
```
$ git reset --soft HEAD~1
```

Then, if you want to unstage these change, use the following command:
```
$ git reset HEAD
```

But let's say you want to completely scrap the last three commits.  
You can do so by doing a reset to HEAD~4 (or to that particular SHA-1).
```
$ git reset --hard HEAD~4
```

## What are tags?
Branches are cool and all, but they're essentially just pointers.  
And because pointers are mutable (meaning that they may not consistently point to the same place), we need a way to permanently mark historical points in our project's history.  
  
Tags can be used to mark certain commits as "milestones" that you can then reference like a branch.  
  
Let's say you want to mark your last commit as VERSION_1.  Just use the following command:
```
$ git tag VERSION_1
```
Or, let's say you want to mark the 2nd to the last commit as VERSION_1.
```
$ git tag VERSION_1 HEAD~2
```



## What is a delta?
Delta encoding is a way of storing or transmitting data in the form of differences (**deltas**) between sequential data rather than complete files; more generally this is known as data differencing.  
Delta encoding is sometimes called delta compression, particularly where archival histories of changes are required (e.g., in revision control software).  
  
The differences are recorded in discrete files called "deltas" or "diffs". In situations where differences are small – for example, the change of a few words in a large document or the change of a few records in a large table – delta encoding greatly reduces data redundancy. Collections of unique deltas are substantially more space-efficient than their non-encoded equivalents.

## Here are some cool git commands:
Display the commit history.
```
git log --oneline --decorate --all --graph
```

Allows you to review each of the changes you made, and then decide what to stage/unstage.
```
git add -p
git reset -p
```

Messed up your merge/rebase? ABORT!
```
git merge --abort
git rebase --abort
```

Forgot to add a little something in your last commit?  Use:
```
git commit --amend --no-edit
```

Consider making your first commit an empty commit.  
(now you can rebase your "first" commit)
```
git init myNewProject
git commit -m "initial commit" --allow-empty
```

Want to stash all file in your working tree?  
(stash ignored, untracked, and tracked files):
```
git stash --all
```

Want to get the gist of git status?  Use:
```
git status --short --branch
```

Want to see which remote repos you're tracking (including the remote urls)?  Use:
```
git remote -v
```

Want to change your remote's URL?  Use:
```
git remote set-url origin https://username@hostname/username/repository.git
```

## My Git Script
I use this bash script to load my aliases on an unfamiliar system.
```
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
```

###### Btw ... who created :octocat: (otherwise known as "octocat")?
Some British bloke that goes by the name of <a href="https://pando.com/2013/07/08/original-github-octocat-designer-simon-oxley-on-his-famous-creation-i-dont-remember-drawing-it/">Simon Oxley</a>
