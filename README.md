<!--- NOTE: in Markdown, include two whitespaces at the end of a line to signify a new line --->

###### Git Mantras
:octocat: says, "Commit early, commit often."  
:octocat: says, "Branches are cheap."

#### Useful Links
http://learngitbranching.js.org  
https://www.atlassian.com/git/tutorials/what-is-version-control
https://www.youtube.com/watch?v=3a2x1iJFJWc (high-level overview of a Git Workflow)

# Git Playground

This repository is used to practice git commands.  Feel free to experiment, and don't worry about breaking things.  
That's what this repo's for!

## What is a commit?
A commit is a snapshot of all the files in your project.  
Every commit object has a unique SHA-1 hash that is generated based on the information it represents.  
For more details, visit: https://tinyurl.com/zar8dkn

## How do you make a new commit?
First, make some modifications to your project.
```
echo "My new modifications" >> modifications.txt
```

Then, add the new file to the staging area.
```
git add modifications.txt
```

Or, you can add all changes to the staging area.
```
git add .
```

Then, make a new commit with a message stating the reason for the commit.
```
git commit -m "added modifications.txt"
```

Verify the new commit.
```
git log
```

##### Here's a tip:
You can stage all changes and commit at the same time using the following command:
```
git commit -a -m "My commit message"
```

## What are branches?
Branches are just pointers to specific commits.  
When a branch points to a particular commit, it will include the commit itself plus all of it's parent commits (or ancestors).  
The default branch name in Git is: master.

### Branch Example
Let's create two branches: dev and test.
```
git branch dev
git branch test
```

Now, let's see which which branch we're currently on.
```
git branch
```

Let's say we want to work on the dev branch.  That is, we want to make commits to the dev branch.  
First, we need to make sure to checkout the dev branch.
```
git checkout dev
```

Let's verify that we're on the dev branch.
```
git branch
```

Now, when we make a new commit, it will be included in the new branch.
```
echo "My new features." >> newFeatures.txt
git add newFeatures.txt
git commit -m "adding newFeatures.txt"
```

Notice how the new changes were recorded on the dev branch ...
```
git log
```

... but not on the master branch.
```
git checkout master
git log
```

##### Here's a tip:
To create a new branch & check it out at the same time, use the following command:
```
git checkout -b new_branch
```

##### Here's a tip:
To branch from a particular commit, use the following command:
```
git branch dev HEAD~3
git branch test 27cd
```

## How do you combine work from two different branches?
There are two methods: merge and rebase.  
  
Merging creates a special commit that has two unique parents.  Merging essentially converges two branches into a single branch.  
Rebasing copies a sequence of commits and places them on top of another commit.  This gives it a sequential look (rebase) instead of a divergent/convergent look (merge).

Rebasing makes your commit tree look very clean since everything is in a straight line.  
But it also modifies the history of the commit tree.

Merging preserves history.  
But it can also make your commit tree look very complex, and confusing.

Choosing whether to rebase or merge is left to the developer's preference.

## Git Merge
Let's create a new branch called hotFix.
```
git branch hotFix
```

And let's checkout the new branch.
```
git checkout hotFix
```

Let's make some changes to our project and make a new commit.
```
echo "My hotFix changes." >> changes.txt
git add changes.txt
git commit -m "added changes.txt"
```

Now, if you want to merge the hotFix branch onto the master branch, you need to first checkout the master branch.
```
git checkout master
```

Then, you can merge the hotFix branch onto the master branch.
```
git merge hotFix
```

Now, if you want to update master to point to hotFix, you need to checkout hotFix and merge master.
```
git checkout hotFix
git merge master
```

##### Here's a tip:
Remember that git merge will merge A onto the current branch.
```
git merge A
```

## Git Rebase
Let's create a new branch called bugFix ...
```
git branch bugFix
```

... and let's checkout the new branch.
```
git checkout bugFix
```

Let's make some changes to our project and make a new commit.
```
echo "My changes." >> changes.txt
git add changes.txt
git commit -m "added changes.txt"
```

Now, if you want to rebase the bugFix branch onto the master branch, you need to first checkout the bugFix branch.
```
git checkout bugFix
```

Then, you can rebase the bugFix branch onto the master branch.
```
git rebase master
```

Now, if you want master to also point to bugFix, you need to checkout master and rebase bugFix.
```
git checkout master
git rebase bugFix
```

##### Here's a tip:
Think: Cut and Paste current branch "onto" master
```
git rebase master
```

##### Here's a tip:
Think: Cut and Paste SOURCE "onto" DESTINATION
```
git rebase DESTINATION SOURCE
```

##### Here's a tip:
Think: The ordering of arguments for rebase is the "opposite" of merge
```
git merge SOURCE
git rebase DESTINATION
git rebase DESTINATION SOURCE
```

## Git Merge and Rebase
Remembering how to merge and rebase may be difficult at first, but practice makes perfect.  
And this tip will help you remember how to use git merge and rebase:

Merge A "into" current branch  
```
git merge A
```
Rebase current branch "onto" A

```
git rebase A
```

## What is HEAD?
HEAD is the symbolic name for the currently checkout commit.

## Detaching HEAD
Detaching HEAD just means attaching it to a commit instead of a branch (remember: a branch is just a pointer to a commit).

## How do you move around in the source tree?
You can make a branch point to any commit using the following command:
```
git branch -f <source> <destination>
```

## What is Git Cherry-pick?
It let's you copy a series of commits below your current location (HEAD).

## Cherry-pick Example
Let's say you have commits A_hash, B_hash and C_hash in branches A, B and C, respectively.   And let's say you want to combine the three commits into a new D branch.  
You can do so using the following command:
```
git checkout -b D
git cherry-pick A_hash B_hash C_hash
```

## How do you undo your last commit?
If you want to discard these changes, use the following command:
```
git reset --hard HEAD~1
```

But if you want to keep these staged changes, use the --soft flag.
```
git reset --soft HEAD~1
```

Then, if you want to unstage these change, use the following command:
```
git reset HEAD
```

But let's say you want to completely scrap the last three commits.  
You can do so by doing a reset to HEAD~4 (or to that particular SHA-1).
```
git reset --hard HEAD~4
```

## What are tags?
Branches are cool and all, but they're essentially just pointers.  
And because pointers are mutable (meaning that they may not consistently point to the same place), we need a way to permanently mark historical points in our project's history.  
  
Tags can be used to mark certain commits as "milestones" that you can then reference like a branch.  
  
Let's say you want to mark your last commit as VERSION_1.  Just use the following command:
```
git tag VERSION_1
```
Or, let's say you want to mark the 2nd to the last commit as VERSION_1.
```
git tag VERSION_1 HEAD~2
```



