## 31.03.24

Showing your PATH in a nice way

```bash
echo $PATH | sed 's/:/\n/g' | uniq -c
```

Showing all shells installed on the machine

```bash
cat /etc/shells
```

Show the default shell for the user

```bash
echo $SHELL
```


> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/VIM">VIM</a>
## 16.07.2023
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