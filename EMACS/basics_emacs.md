## 31.03.24

I want to install DOOM Emacs but can't do it because it requires Emacs version 27 or above. My problem is that I can't upgrade my version of Emacs. Now I am trying to delete Emacs from my server and install a newer version from source (for the first time in my life).


```bash
sudo apt remove emacs
```

Installation of Emacs 28 from source

1: Dependencies (needed for installation)

```bash
sudo apt-get install build-essential texinfo libx11-dev li bxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf
```

2: Download and extract source code

```bash
wget https://ftp.gnu.org/gnu/emacs/emacs-28.1.tar.xz
```

3: Compile and install

```bash
cd emacs-28.1
./configure
make
sudo make install
```

4: Doom needs a more recent version of Git. Installed Git from source using the tutorial from this [link](https://www.digitalocean.com/community/tutorials/how-to-install-git-on-debian-10)



## 24.03.24

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/EMACS">EMACS</a>

### Step 1

```console
# Install Emacs
sudo apt install emacs
```

### Step 2

Create `.config` file inside your home directory. Inside `.config` create a `emacs` directory and inside that create an `init.el` file.

### Step 3

In the `init.el` file add the following: 


```elisp
# telling the system that the config file will be config.org and not init.el
# config.org will be an org document containing emacs configuration blocks

(org-babel-load-file
  (expand-file-name                                                                           
  "config.org"                                                                              │ 
  user-emacs-directory))
```
### Step 4

Create a `config.org` file in `~/.config/emacs` location (same as the config.el)


`control x` and `control s`: saving
`control x` and `control f`: finding files
