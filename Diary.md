## 01.03.24

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/VIM">VIM</a>

* `ctrl r` Redo Changes. The redo feature is the oposite of undo (allows you to reverse the previous action)

<br><br>

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/TMUX">TMUX</a>

Sourcing the ~/.tmux.conf file requires a different command compared to other dotfiles (configuration files with a leading dot in their names). 

```bash
tmux source-file ~/.tmux.conf
```

TMUX basic commands (MAC)

* `ctrl a` or `ctrl t` prefix (needed for all command to follow)

* `ctrl a` + `shift %` splitting panes left and right
* `ctrl a` + `shift "` splitting panes top and down 
* `ctrl a` + `arrow keys` navigating between panes down
* `ctrl d` close a pane or type `exit`
* `ctrl a` + `c` creating a new window (window contains pains)
* `ctrl a`+ `n` switch to the next window
* `ctrl a`+ `p` switch to the previous window
* `ctrl a`+ `d` detach from a session (everything will still run in the background)

* `tmux ls` List the currently running sessions
* `tmux attach -t <sessionNumber>` attacht to a specific session  
* `tmux new -s database` attacht to a specific session  


<br><br>

## 29.02.24

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>

Terminal Keybindings

* `ctrl a` moves the cursor at the beginning of the line
* `ctrl e` moves the cursor at the end of the line
* `ctrl b` moves the cursor to the left
* `ctrl f` moves the cursor to the right

<br><br>

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/JAVA">JAVA</a>

In Java, directly printing an array with System.out.println() will not print the contents of the array but will print its hashcode instead. To print the contents of the array, you need to use `Arrays.toString()` method from the `java.util.Arrays` class.

```java
System.out.println(Arrays.toString(array));
```

<br><br>


> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>


SSH learning session and some bulletpoints for me to remember. 

* SSH connection is implemented using a client-server model
* remote machine must be running a piece of software called an SSH daemon
* The user’s computer must have an SSH client
* passwords (less secure and not recommended) or SSH keys, which are very secure
* always setting up SSH key-based authentication for most configurations
* user must have an SSH key pair locally.
* public key must be copied to `~/.ssh/authorized_keys` on remote server


<br><br>


## 28.02.24

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>

`ctrl a` moves the curser to the end of the line and `ctrl e` moves it  to the beginning of the line.

<br><br>

> MAC

Reverse delete. Or some other name for deleting stuff to the right of the cursor. By typing `cntr d` ... baaaam!

<br><br>

> GIT

The `.gitignore` file contains names of folders and other files that Git ignores. These files are not automatically added to the staging area or included in commits. However, entries starting with an exclamation mark ("!") are an exception. These files will be included in a commit even though they are inside a folder that is otherwise ignored.

```bash
# file in out/ are excluded except `**/src/main/**/out/` and `**/src/test/**/out/`
out/
!**/src/main/**/out/
!**/src/test/**/out/
```

<br><br>

## 26.02.24

> VIM

This one is amazing! Enter the command mode by pressing `:` and use `up` or `down` keys to see your old commands. This will save me so much time!!!

> Terminal

Amazing way to use the last command. Just type `!!` and hit `tab` or `enter`. Even better if you like to use the command befor your last entry just type `!-2`. Or `!-4` and so on. Cool right!


## 25.02.24

> IntelliJ

* Typing `/**` + then pressing `Enter` above a method signature will create Javadoc stubs
* 'live templates' to generate several types of code snippets. `fori` for a for loop. Similar to `sout` for the print statement. 

> VSCode

Adding code snippets. Handy!

```bash
# open command palette
shift option P
```

<br><br>



Paste *configure user snippets*. Amazing video [HERE](https://www.youtube.com/watch?v=TGh2NpCIDlc)


<br><br>

<img width="812" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/176a7f82-f6e6-48e0-b2ad-4e26212dfe26">



<br><br>

# 01.02.23



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

<details>
  <summary>Create a user on remote server and grand superuser privileges</summary>
<br>

```bash
# following this tutorial
# https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/

# create a new user
createuser name_of_user

# Adding user to the sudoers group (root). This will avoid having to log out of our normal user and log back in as the root account.
# This will give or user superuser or root privileges allow our normal user to run commands with administrative privileges by putting the word sudo before the command.
# To add these privileges to our new user, we need to add the user to the sudo group.
usermod -aG sudo name_of_user

# see where linux stores the passwords
vim ect/passwd
```
<br>
</details>





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


# by pressing this again next command will be displayed
# by the way the same command in vim is used to redo the last change :)
`ctrl r`


# 14.02.23


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





# 24.02.23

<details>
  <summary>Quots do matter in bash</summary>
    
<br>
    
```
Hey, this is a cool one. I thougut that double quotes and single quote can be used interchangeably in bash but no! BASH does not expand variables inside single quotes ... what a nice pearl!
```
    
<br>
    
<img width="653" alt="image" src="https://user-images.githubusercontent.com/36699154/221005253-1e96958e-1c12-43cc-9908-da73207d321e.png">

</details>





# 26.02.23

<details>
  <summary>Declaring environment variables</summary>
    
<br>
    
```
Environment variables are useful, even for me. Often I need to check the home directory (HOME) or the shell 
that is actually running (SHELL) and being able to modify this environment variables is important.
```
    
<br>
    
```console
# this will change the default list of options for the less command
declare -x LESS="-iqM"
```

</details>






# 27.02.23

<details>
  <summary>Restart terminal session</summary>
    
<br>
    
```
Sometimes I would like to terminate my zsh session. To do so, just type:
```
    
<br>

</details>






<br>

### 02.10.23
#### Fastest way to insert google docstrins so far. Install autoDocstring extension for vsCode. Press `cmd-shift-2` below your funcition definition

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9ea7eb10-e568-4e2a-b5df-345d4c4c1aa4">

### 17.10.23

#### Terminal > Homebrew: I didn't know that homebrew doesn't automatically uninstall old packages, so you'll need to do it yourself.

```command line
brew cleanup
```

### 19.10.23

#### VS Code: CodeSnap - a nice extension to visualize code snippets
#### After installation just highlight your code, right click and there you have it!

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/03085d7f-4f56-41d3-bc52-b75e7dc029a1">


### 23.10.12:  iTerm: Customizing terminal prompt (PS1) with emojis to add a touch of personalization

<br>

```code
I use agnoster theme for my iTerm2 terminal and settings to that theme can be found at this location ~/.oh-my-zsh/themes/agnoster.zsh-theme

My goal was to get rid of the user and hostname display and replace it with some fancy emojis. 
```

Before that the settings looked like this.

<img width="1013" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9a171b16-9851-4908-81e6-229749c60b4a">

After the edit:

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/a0276f75-ac23-4481-944e-8942df89f561">

<br>

```code
Don't forget to include the source ~/.oh-my-zsh/themes/agnoster.zsh-theme command in your .zshrc. Otherwise, after the terminal session is closed, your changes will disappear.
```


### 26.09.23
#### **Jupyter notebook:** *Revamping Escape in Google Colab: A Vim-tastic Adventure!*

```txt
# press : to switch to command mode then type
:imap kj <Esc>
```

<br>

### 26.09.23
#### **Jupyter notebook:** *Revamping Escape in Google Colab: A Vim-tastic Adventure!*

```txt
# press : to switch to command mode then type
:imap kj <Esc>
```

<br>



<br>

### 02.10.23
#### Fastest way to insert google docstrins so far. Install autoDocstring extension for vsCode. Press `cmd-shift-2` below your funcition definition

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9ea7eb10-e568-4e2a-b5df-345d4c4c1aa4">

### 17.10.23

#### Terminal > Homebrew: I didn't know that homebrew doesn't automatically uninstall old packages, so you'll need to do it yourself.

```command line
brew cleanup
```

### 19.10.23

#### VS Code: CodeSnap - a nice extension to visualize code snippets
#### After installation just highlight your code, right click and there you have it!

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/03085d7f-4f56-41d3-bc52-b75e7dc029a1">


### 23.10.12:  iTerm: Customizing terminal prompt (PS1) with emojis to add a touch of personalization

<br>

```code
I use agnoster theme for my iTerm2 terminal and settings to that theme can be found at this location ~/.oh-my-zsh/themes/agnoster.zsh-theme

My goal was to get rid of the user and hostname display and replace it with some fancy emojis. 
```

Before that the settings looked like this.

<img width="1013" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9a171b16-9851-4908-81e6-229749c60b4a">

After the edit:

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/a0276f75-ac23-4481-944e-8942df89f561">

<br>

```code
Don't forget to include the source ~/.oh-my-zsh/themes/agnoster.zsh-theme command in your .zshrc. Otherwise, after the terminal session is closed, your changes will disappear.
```