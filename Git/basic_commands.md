# Basics

Should be done on every repository (not sure why but ask Scott Chacon). Speeds things up. 

```bash
git maintenance start
```

Force pushing but with caution. It will not override someones edits. E.g. safe force push. 

```bash
git push --force-with-lease
```


Merging a branches. Check-out the branch you want to merge into. 

```bash
git merge <source-branch>
```

Tracking a remote branch locally. Will create a local branch that will track a romote branch

```bash
git branch --track <name-branch> <origin/branch-name>
```

Creating and switching to the newly created branch in one line

```bash
git checkout -b <branch name>
```

Skip adding changes in files (it looks like new files are added as well ... not sure why ...)

```bash
git commit -am "Your commit message"
```

List remote branches

```bash
git branch -r
```

Renaming the HEAD branch (Branch you switched == checked-out into)

```bash
git branch -m <new-brach-name>
```

Renaming a branch other then the HEAD (currently checked-out)

```bash
git branch -m <branch-name-to-rename> <new-brach-name>
```


> Changing name and email in global settings. This info is used to keep track of the author behind any changes made to a Git repository. 

```bash
git config --global user.name 'Boston Bruins'
git config --global user.email 'gobruins@some_address.edu'
```

```bash
# Check and list global Git configuration settings
git config --global --list
```

> Formats and displays commits, emphasizing essential information

```bash
# You can opt for the shorter 7-character commit hash instead of the longer identifier
git log --oneline
```

<img width="100%" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/a0c43741-0d1e-4a16-a423-de42ba08222b">

# 

