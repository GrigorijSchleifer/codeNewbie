# Basics

Changing name and email in global settings. This info is used to keep track of the author behind any changes made to a Git repository. 

```bash
git config --global user.name 'Boston Bruins'
git config --global user.email 'gobruins@some_address.edu'
```

# this is not staged yet
# after screwing up and not staging ...


```bash
# Check and list global Git configuration settings
git config --global --list
```


```bash
# Formats and displays commits, emphasizing essential information
# Commits hashes are represented by the first 7-character
# You can use the first 7 characters of the hash instead of the full identifier
git log --oneline
```