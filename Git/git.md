> # **Contribution graph magic**

If you're anything like me, you appreciate the **contribution graph** for the motivation it provides and the visual representation of your work.

Recently, while attempting to push code changes to a new repository created in IntelliJ, I noticed there was no green mark on my contribution graph after the push. I found this puzzling and suspected it had something to do with branches.

To investigate, I used the `git branch` command to display the branch I was working on. To my surprise, I discovered two branches: `main` and `master`. IntelliJ had created both, with my `HEAD` branch checked out on `master`. (`HEAD` is the currently active or "checked-out" branch, and a repository can have many branches, but only one `HEAD`)

```bash
# Command A: shows all available branches 
git branch
```
Every repository has a default branch and only contributions to the dafault branch are 
displayed in the **contribution graph**. So I changed my difault branch to `master` and it worked. All my previous commits showed up on the graph.
