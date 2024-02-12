# 10.02.24

> # Understanding Git Branches and Remotes:

If you are like me, you like the **contribution graph** because it gives you some motivation and highlights your work visually. 

While I was trying to push some code changes in a new repository (created in IntellyJ) there was no green mark after I pushed the code. And I was wondering how this was possible. I had a feeling that this had something to do with branches and the git magic not flowing through me properly :)

I found a nice command to show the branch I was working on and to my surprise I had two branches `main` AND `master`. Somehow IntellyJ created both and placed me (checked out) on `master` as my HEAD branch. And HEAD is the currently active or "checked-out" branch. There can be many branches but only one HEAD.

```bash
# Command A: shows all available branches 
git branches
```
Every repository has a default branch and only contributions to the dafault branch are 
displayed in the **contribution graph**. So I changed my difault branch to `master` and it worked. All my previous commits showed up on the graph.
