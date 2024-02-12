# Basics

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

```bash
# this will revert back to the project's state before "class files deleted" commit
git checkout bf6887f
```
#

* This will bring you into a "detached HEAD state" :)
* Be careful not to make any edits in this snapshot, doing so will force a new branch

# 

```bash
# "git log --oneline" will not list the most recent state of our repo
# To view all snapshots, both forward and backward, use the --all option.
git log --oneline --all
```

