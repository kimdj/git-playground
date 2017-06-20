<!--- NOTE: in Markdown, include two whitespaces at the end of a line to signify a new line --->

###### Git Mantras
:octocat: says, "Commit early, commit often."  
:octocat: says, "Branch early, branch often."  
:octocat: says, "Branches are cheap."

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
echo "My new changes" >> changes.txt
```

Then, add the new file to the staging area.
```
git add changes.txt
```

Or, you can add all changes to the staging area.
```
git add .
```

Then, make a new commit with a short message stating the reason for the commit.
```
git commit -m "added modifications.txt"
```

Or, you can make a new commit with a long message.
```
git commit
```

You can also verify the new commit.
```
git log
```

## How do I undo the last commit?
This will simply undo the commit and keep the unstaged changes in your working tree.
```
git reset HEAD^
```

## I changed my mind. How do I redo the last commit?
```
git reset 'HEAD@{1}'
```

## How do I obliterate the last commit (along with the changes)?
```
git reset --hard HEAD^
```

## How do I obliterate the last 2 commits?
```
git reset --hard HEAD~2
```

## D'OH!!!  I totally screwed up and did a hard reset.  Can I fix it?
Yes!  First, look for the commit you want to go back to:
```
git reflog
```

Then, do a hard reset to that particular commit.
```
git reset --hard HEAD@{5}
```

##### :octocat: says, "Here's a tip":
You can stage all changes and commit at the same time using the following command:
```
git commit -a -m "My commit message"
```

## What is HEAD?
HEAD is the ref (reference, or symbolic name) for the commit that's currently checked out.  
You can think of it as a pointer to a commit.

## Detaching HEAD
Detaching HEAD just means attaching it to a commit instead of a branch.  

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
git branch dev
git branch test
```

Now, let's see which branch we're currently on (most likely the master branch).
```
git branch
```

Let's say we want to work on the dev branch.  That is, we want to make commits to the dev branch.  
First, we need to make sure to checkout the dev branch.
```
git checkout dev
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

## How do you delete a branch?
```
git branch -d branch_name
```

##### :octocat: says, "Here's a tip":
To create a new branch & check it out at the same time, use the following command:
```
git checkout -b new_branch
```

##### :octocat: says, "Here's a tip":
If you don't want your new branch to point to HEAD, you can specify a commit.  
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

Choosing whether to rebase or merge depends on a developer's preference.

## Git Merge Example
Let's do some work in a new branch, and then let's merge it into the master branch.  
  
First, let's create a new branch called hotFix.
```
git branch hotFix
```

Now, let's checkout the new branch.
```
git checkout hotFix
```

Let's make some changes to our project and make a new commit.
```
echo "My hotFix changes." >> changes.txt
git add changes.txt
git commit -m "added changes.txt"
```

Now, if you want to merge the hotFix branch into the master branch, you need to first checkout the master branch.
```
git checkout master
```

Then, you can merge the hotFix branch **into** the master branch.
```
git merge hotFix
```

Now, if you want to update master to point to hotFix, you need to checkout hotFix and merge master.
```
git checkout hotFix
git merge master
```

##### :octocat: says, "Here's a tip":
Just remember to first checkout a branch.  
Then merge A **into** the current branch.
```
git merge A
```

## Git Rebase Example
Let's do some work in a new branch, and then let's rebase our work **onto** the master branch.  
  
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

Now, if you want to rebase the bugFix branch **onto** the master branch, you need to first checkout the bugFix branch.
```
git checkout bugFix
```

Then, you can rebase the bugFix branch **onto** the master branch.
```
git rebase master
```

Now, if you want master to also point to bugFix, you need to checkout master and rebase bugFix.
```
git checkout master
git rebase bugFix
```

##### :octocat: says, "Here's a tip":
Just remember that the ordering of args is somewhat **counter-intuitive**.  
Think: Cut and Paste SOURCE "onto" DESTINATION
```
git rebase DESTINATION SOURCE
```

##### :octocat: says, "Here's a tip":
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
git checkout current_branch
git merge A
```

Rebase SOURCE branch "onto" DESTINATION branch
```
git rebase DESTINATION SOURCE
```

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



## What is a delta?
Delta encoding is a way of storing or transmitting data in the form of differences (**deltas**) between sequential data rather than complete files; more generally this is known as data differencing.  
Delta encoding is sometimes called delta compression, particularly where archival histories of changes are required (e.g., in revision control software).  
  
The differences are recorded in discrete files called "deltas" or "diffs". In situations where differences are small – for example, the change of a few words in a large document or the change of a few records in a large table – delta encoding greatly reduces data redundancy. Collections of unique deltas are substantially more space-efficient than their non-encoded equivalents.



###### Btw ... who created :octocat: (otherwise known as "octocat")?
Some British bloke that goes by the name of <a href="https://pando.com/2013/07/08/original-github-octocat-designer-simon-oxley-on-his-famous-creation-i-dont-remember-drawing-it/">Simon Oxley</a>