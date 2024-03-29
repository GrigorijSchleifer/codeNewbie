> ### **Contribution graph magic**

If you're anything like me, you appreciate the **contribution graph** for the motivation it provides and the visual representation of your work.

Recently, while attempting to push code changes to a new repository created in IntelliJ, I noticed there was no green mark on my contribution graph after the push. I found this puzzling and suspected it had something to do with branches.

To investigate, I used the `git branch` command to display the branch I was working on. To my surprise, I discovered two branches: `main` and `master`. IntelliJ had created both, with my `HEAD` branch checked out on `master`. (`HEAD` is the currently active or "checked-out" branch, and a repository can have many branches, but only one `HEAD`)

```bash
# displays all available branches 
git branch
```

I discovered that only contributions to the default branch are counted on the **contribution graph**. After changing my default branch to `master`, all my previous commits appeared on the graph.

<br>

<img width="100%" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/b6eaede1-86d4-4456-9099-9f9f8bc735fe">

<br>

> ### Detached HEAD state

It is possible to check out a specific commit directly using its hash string, which will place you in a 'detached HEAD state' by moving HEAD to the commit with the specified hash. Be cautious when making edits in this snapshot, as doing so will create a new branch named `detached`.

```bash
# this will 
git checkout <hash string of a specified commit>
```

```bash
# In a detached state "git log --oneline" will not list the most recent state of our repo
# To view all snapshots, both forward and backwardf from the detached HEAD, use the --all option.
git log --oneline --all
```

```bash
# Forcing the HEAD back to the main branch
git checkout main

# Checking back into the detached branch (no need to use the hash string associated with this newly created detached branch
git checkout detached
```

