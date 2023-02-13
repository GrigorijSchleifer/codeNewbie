
# 01.02.2023

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

```bash
~ lazygit "commit message"
```

<br>

# 02.02.2023
####  Amazing and easy to use ressource to generate README profile for github

https://rahuldkjain.github.io/gh-profile-readme-generator/

#### Holy cow! This code when placed in vscodes settings.json will let you move lines vertically in normal mode
#### I searched for this for soo long ...

```json
 "vim.normalModeKeyBindingsNonRecursive": [
    {
        "before": ["J"],
        "commands": ["editor.action.moveLinesDownAction"]
    }, // moveLineDown
    {
        "before": ["K"],
        "commands": ["editor.action.moveLinesUpAction"]
    } // moveLineUp
],
```
# 03.02.23

```code
hostnamectl
```

```bash
# Show information about the host (server)
  Static hostname: vps40009.alfahosting-vps.de
         Icon name: computer-container
           Chassis: container
        Machine ID: ***
           Boot ID: ***
    Virtualization: openvz
  Operating System: Debian GNU/Linux 10 (buster)
            Kernel: Linux 4.19.0
      Architecture: x86-64

```


```code
SSH configuration on my blink app
```

```
Victor Geislinger - Setting up SSH keys for GitHub - Video

ssh-keygen -t ed25519 -C your-git-mail
eval "$(ssh-agent -s)"
touch ~/.ssh/config
...
```

# 04.02.23

```
Create a user on my remote server and install brew (not recommendet as root)
```

```bash
# following this tutorial
# https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/

# create a new user
createuser name_of_user

# add user to the sudoers group (root)
usermod -aG sudo name_of_user

# see where linux stores the passwords
vim ect/passwd
```
# 07.02.23

```bash
>> Run shell session as root
```

```bash
# -s flag tells sudo to run shell as root
sudo -s
```
<br>

```bash
Installing virtual environments on remote server 
```

```bash
# command to intall and upgrade the "pip" package manager to the latest version only for the current user
# -m: This option is used to run a module (pip in this case) as a script
# !!! Only ever use your system package manager to upgrade the system pip !!!
python3 -m pip install --user --upgrade pip

# installing virtualenv
python3 -m pip install --user virtualenv

# creating virtual environment for jekyll static web page development 
python3 -m virtualenv jekyll_env
```
# 10.02.23

```
Finding manuals to a certain terminal command by keyword lookup 
```

```bash
$ man -k 'keyword'

# when command is found and manual is open use /MANUALSECTION to open up this explicit section
```

# 13.02.23

```
Reverse search for terminal commands you have typed so far
```

```bash
# by pressing this again next command will be displayed
Control-r <...>
```


















