
# 01.02.23

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

```console
lazygit "commit message"
```
    
</details>




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

# -t ed25519 is the newest type of encryption that will be used to generate the key
# the key will be stored in ~/.ssh/id_ed25519 (default location)
# https://www.ssh.com/academy/ssh/keygen (nice tutorial)
ssh-keygen -t ed25519 -C your-git-mail

# starting the ssh agent
# Here we let computers ssh agent know about the key (like a wallet thes stores the key)
eval "$(ssh-agent -s)"

# adding private key to the ssh agent (like putting the id into the wallet)
touch ~/.ssh/config

# adding that file to ssh
ssh-add ~/.ssh/id_ed25519

# showing the public key that will be added to githubs 
cat ~/.ssh/id_ed25519.pub

# check if authentication was successful
# Hi GrigorijSchleifer! You've successfully authenticated, but GitHub does not provide shell access.
ssh -T git@github.com
```

```console
ssh -T git@github.com
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


```console
# Installing venv on Debian (like my remote server) or Ubuntu
sudo apt-get install python3-venv
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
# by the way the same command in vim is used to redo the last change :)
Control-r <...>
```


# 14.02.23

```
Repeat last command in the terminal
```

```bash
!!
```


# 16.02.2023
   
#### Showing PATH like a pro

```
Hey, what's up fellas. I'm trying to install Jekyll for running my own technical blog for doctors, but unfortunately 
I'm not able to update Ruby ... somehow I am stuck on an older version and don't know why I get a bunch of errors ... 
So while I'm trying to stay calm instead of throwing my Mac out of the OR, I found this little snippet that shows my PATH 
in a nice, concise way. Check it out ... and  yes, my PATH <br> is messed up ... the next ToDo is already planned ... 
see you later ... and as always ... sorry for my gebrochen english
```

[Link to a similar but more sophisticated tutorial](https://chriswarrick.com/blog/2018/09/04/python-virtual-environments/)

```console
echo $PATH | sed 's/:/\n/g' | uniq -c
```
<img width="592" alt="image" src="https://user-images.githubusercontent.com/36699154/219898860-c4a478fe-f788-4419-956c-d2b80a389d97.png">

#### Bringing virtualenv to the next level


```
I am still new to virtual environment world but I already know that you must use virtual environments for your project 
to separatte stuff ... so I was wondering where I should create all my environments ... I know I have only a few but it 
turns out you should store the env's in ~ (your homne directory) ... oh Meister I hope it is true ... 
```
```console
# step I
mkdir ~/virtualenvs
# step 2
python -m virtualenv venv_name
# step 3
source venv_name/bin/activate
```
```
But the coolest thing ever ... you can save time by adding a function to your .zshrc and just use the funciton name plus the name of the environment to activate it ... niiiice
```
```bash
# add this to your .zshrc or .bashrc

export WORKON_HOME=~/virtualenvs # this is where you will store all your environments

 function workon {
     source "$WORKON_HOME/$1/bin/activate"
 }
```
   
```console
# to activate a environment just type
workon env_name
```
# 20.02.23

<details>
  <summary>Display avalable functions in iterm (zsh) </summary>
<br>

```
Hey, what is cookin ... I am adding some more functions to my bash. A neat new way to display all avalable function inside terminal is:
```

```console
declare -f
```

```
This command will show a huge amount of functions and if you would like to limit the output to only one terminal page than pipe the output 
of declare into less
```

```console
declare -f | less
```

```
You can move to the next matched pattern by pressing the n key or move back to the previous match by pressing the N (shift+n) key.
```
</details>

<details>
  <summary> Get the newest ruby version (Jekyll static webpage installation)</summary>
<br>
```
I want a static webpage where I write about coding and collect my thougts. But, somehow I was not able to get Jekyll installd. And this was because of my ruby environment on Mac. I spent almost a day figuring out why I was not able to install the bundler gem (not sure yet what gem and bundler are) and found this amazing tutorial:
```
<br>
    
[The fastest and easiest way to install Ruby on a Mac in 2023](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/#configure-your-shell)

</details>

# 21.02.23

<details>
  <summary>Stopwords</summary>
    
<br>
    
```
This is a link to a page with a collection of stopwords for 40 different languages. 
```
    
<br>
    
[Stopwords](https://www.ranks.nl/stopwords/)

</details>



