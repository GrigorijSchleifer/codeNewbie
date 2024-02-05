# 16.07.2023



<details>
  <summary>Commiting like a lazy PRO</summary>
<br>
```bash
Tired of typing "git add ." "git commit -m ..." and "git push origin master"
    >> Add this code to your .zshrc and source the .zshrc file
```

```bash
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```