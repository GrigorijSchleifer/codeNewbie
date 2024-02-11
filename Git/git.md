# 10.02.24

> # Understanding Git Branches and Remotes:

If you are like me, you like the **contribution graph** because it gives you some motivation and highlights your work in a easy way. 

While I was trying to push some code changes in a new repository (created in IntellyJ) there was no green mark after I pushed the code. And I was wondering how this was possible. I had a feeling that this had something to do with branches and the git magic not flowing through me properly :)

I found a nice command to show the branch I was working on and to my surprise I had two branches `main` AND `master`. Somehow IntellyJ created both and placed me (checked out) on `master` as my HEAD branch. And HEAD is the currently active or "checked-out" branch. There can be many branches but only one HEAD.

```bash
# Command A: shows all available branches 
git branches

# Command B: changes into a specified branche
git checkout <branch-name>
```

And it showed that I was on `master` and all my commits did go to that `master` branch. This means that green contribution mark is "granted" if I commit to the `main` branch. But how? 

> Several branches with confusing names

Let's try to understand this mess. There are three names that I see in Git all the time and I can't keep apart. `remote`, `main`, and `origin/main`. 

`main` is like your workspace, where you make changes and `origin/main` is a remote tracking branch. It keeps track of the state of the `main` branch on the online repository (remote) named `origin`. It is not a local copy of the `main`branch.

> One Remote:

origin is the name given to the online repository (remote).
> Is origin/main Remote?

### No, origin/main is local. When you fetch changes from the online repository, it updates your local origin/main.

> 4 Example: Pull in Two Steps:


### Step One: Fetch the latest changes from the online repository's main and save them as origin/main locally.

bash

Copy code
git fetch origin main
Step Two: Merge the changes from your local origin/main into your local main.
bash
Copy code
git merge origin/main
Finally, push your changes from your local main back to the online repository.
bash
Copy code
git push origin main
5. More Examples:

Fetch multiple branches by name:
bash
Copy code
git fetch origin main stable oldstable
Merge multiple branches:
bash
Copy code
git merge origin/main hotfix-2275 hotfix-2276 hotfix-2290
6. Using a Different Name:

You can name your local branch differently from the remote. For example, create a local branch named alice that tracks origin/main:
bash
Copy code
git checkout -b alice --track origin/main
This is useful if you already have a local branch named main and need to work on a different change.

> Block A
>> Blcok B
>>> Block C
