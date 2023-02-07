
# 01.02.2023
####  Tired to type "git add ." "git commit -m "bla bla"" and "git push origin master"
#### Just added this code to my .zshrc and triple baaaam
#### Don't forget to source the .zshrc file

```bash
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```

<img width="608" alt="image" src="https://user-images.githubusercontent.com/36699154/216145341-219278e7-b0c1-4c71-9204-d3705a9ed82c.png">

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

 # 05.02.23

> When working with markdown files (.md) on VsCode, one can toggle the preview screen with <code>shift/alt/v<code>

# 06.02.23

```
Installing pip package manager on remote server whith the goal to install virtualenv
Virtualenv has to be installed (not like venv that is newer and already preinstalled)
```

```
# check python version (in my case python3 was already on my remote machine)
python3 --version

# install pip with python3
udo apt-get install python3-pip
```


```
Changing the shell from bash to zsh
```

```
# this will tell in what shell we are working at the moment
echo $SHELL


# changing shell to zsh
chsh -s $(which zsh)

# exit and reconnect to remote servert in order to take zsh over permanently
exit
```

















