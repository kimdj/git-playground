###### Git Mantras:
:octocat: says, "Commit early, commit often."
:octocat: says, "Branches are cheap."

# Git Playground

This repository is used to practice git commands.  Feel free to experiment, and don't worry about breaking things.  That's what this repo's for!

## What is a commit?
A commit is a snapshot of all the files in your project.

## How do you make a new commit?
First, make some modifications to your project:
```
echo "My new modifications" >> modifications.txt
```

Then, add the new file to the staging area:
```
git add modifications.txt
```

Or, you can add all changes to the staging area:
```
git add .
```

Then, make a new commit with a commit message:
```
git commit -m "added modifications.txt"
```

Verify the new commit:
```
git log
```

## What are branches?
Branches are just pointers to specific commits.
When a branch points to a particular commit, it will include the commit itself plus all of it's parent commits (or ancestors).

## Branch example:
Let's say we have two branches that diverge: dev and test.
And let's say we want to work on the dev branch only.  That is, we want to include all the dev branch commits.

First, we need to make sure to checkout the dev branch:
```
git checkout dev
```

Let's verify that we're on the test branch:
```
git branch
```

Now, let's create another branch called newFeatures:
```
git branch newFeatures
```

And let's checkout this new branch:
```
git checkout newFeatures
```

Now, when we make a new commit, it will be included in the new branch:
```
echo "My new features." >> newFeatures.txt
git add newFeatures.txt
git commit -m "adding newFeatures.txt"
```

Notice how the new changes were recorded on the new branch (newFeatures) ...
```
git checkout newFeatures
git log
```

... but not on the previous branch (dev):
```
git checkout dev
git log
```

To create a new branch & check it out at the same time:
```
git checkout -b new_branch
```

## How do you combine work from two different branches?
There are two methods: merge and rebase.

Merging creates a special commit that has two unique parents.  Merging essentially converges two branches into a single branch.
Rebasing copies a sequence of commits and places them on top of another commit.  This gives it a sequential look (rebase) instead of a divergent/convergent look (merge).


### Git Merge:
Let's create a new branch called hotFix branch ...
```
git branch hotFix
```

... and let's checkout the new branch:
```
git checkout hotFix
```

Let's make some changes to our project and make a new commit:
```
echo "My changes." >> changes.txt
git add changes.txt
git commit -m "added changes.txt"
```

Now, if you want to merge the hotFix branch onto the master branch, you need to first checkout the master branch:
```
git checkout master
```

Then, you can merge the hotFix branch onto the master branch:
```
git merge hotFix
```

Now, if you want hotFix to also point to master, you need to checkout hotFix and merge master:
```
git checkout hotFix
git merge master
```

Here's a tip:
Merge master onto current branch
```
git merge master
```

### Git Rebase:
Let's create a new branch called bugFix branch ...
```
git branch bugFix
```

... and let's checkout the new branch:
```
git checkout bugFix
```

Let's make some changes to our project and make a new commit:
```
echo "My changes." >> changes.txt
git add changes.txt
git commit -m "added changes.txt"
```

Now, if you want to rebase the bugFix branch onto the master branch, you need to first checkout the bugFix branch:
```
git checkout bugFix
```

Then, you can rebase the bugFix branch onto the master branch:
```
git rebase master
```

Now, if you want master to also point to bugFix, you need to checkout master and rebase bugFix:
```
git checkout master
git rebase bugFix
```

Here's a tip:
Rebase current branch onto master
```
git rebase master
```

## What is HEAD?
HEAD is the symbolic name for the currently checkout commit.

## Detaching HEAD:
Detaching HEAD just means attaching it to a commit instead of a branch (remember: a branch is just a pointer to a commit).

## How do you move around in the source tree?
You can make a branch point to any commit using the following command:
```
git branch -f <source> <destination>
```

## What is Git Cherry-pick?
It let's you copy a series of commits below your current location (HEAD).

# Cherry-pick Example:
Let's say you have commits A_hash, B_hash and C_hash in branches A, B and C, respectively.  And let's say you want to combine the three commits into a new D branch.
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
But if you want to keep these staged changes, use the --soft flag:
```
git reset --soft HEAD~1
```
Then, if you want to unstage these change, use the following command:
```
git reset HEAD
```
But let's say you want to completely scrap the last three commits.
You can do so by doing a reset to HEAD~4 (or to that particular SHA-1):
```
git reset --hard HEAD~4
```

## What are tags?
Branches are cool and all, but they're essentially just pointers.
And because pointers are mutable (meaning that they may not consistently point to the same place), we need a way to permanently mark historical points in our project's history.

Tags can be used to mark certain commits as "milestones" that you can then reference like a branch.

Let's say you want to mark your last commit as VERSION_1.  Just use the following command:
```
git tag VERSION_1 HEAD
```


