# codeNewbie
Hey, here I store all my coding pearls I find useful and cool. This repo is like my coding diary. Enjoy if you find it here :)

### 16.01.23
#### Vim: Entering the Replace mode ... soo cool!

```command line
shift R
```

### 17.01.23
#### Python: Nice way to use if else in the return statement

```python
return True if done == 'done' else False
```

### 18.01.23
#### Python: Uuuuh ... list comprehension indeed ... we can print everything to the right of ':' with [1] and left with [0]



```python
lst = [
    'X-DSPAM-Confidence:0.8475', 
    'X-DSPAM-Confidence:0.9867', 
    'X-DSPAM-Confidence:0.2872', 
    'X-DSPAM-Confidence:0.0282'
]

print([i.split(':')[1] for i in lst])
# ['0.8475', '0.9867', '0.2872', '0.0282']

print([i.split(':')[0] for i in lst])
# ['X-DSPAM-Confidence', 'X-DSPAM-Confidence', 'X-DSPAM-Confidence', 'X-DSPAM-Confidence']

# The reason for that behaviour is that the split method splits the line in two peaces
# and we access either the first (index 0) or the second (index 1) list item

# here without indexing
print([i.split(':') for i in lst])
# [['X-DSPAM-Confidence', '0.8475'], ['X-DSPAM-Confidence', '0.9867'], ['X-DSPAM-Confidence', '0.2872'], ['X-DSPAM-Confidence', '0.0282']]
```

## 20.01.23
### Github: 

#### A cool trick to fire up Vs Code in github, just to press '.' in a repository or to change github.com/ropository name to 'github.dev/repository name

## 22.01.23
### VIM: 

Display all colorschemes that are used in vim: in vim's normal mode press `:colorscheme [space] [Ctrl+d]`

## 23.01.23

### Vs Code: 

##### Installing shell command `code` in PATH to be able to open Vs Code from the terminal
##### Press `Command + Shift + P` inside Vs Code, enter "shell" and than `Enter`

<img width="651" alt="image" src="https://user-images.githubusercontent.com/36699154/214015648-841a842e-c319-44be-86f5-a95080f9eb27.png">


```code
brew install tmux
git clone https://github.com/tmux-plugins/tmp ~/.tmux/plugins/tpm
```

## 26.01.23

### VIM: 
#### Display of the VIM REFERENCE MANUAL - in VIM's edit mode type:

<a href="https://www.youtube.com/watch?v=JFr28K65-5E">VIM AWESOME TUTORIAL by Leeren</a>

```code
:h vimrc
```

<img width="799" alt="image" src="https://user-images.githubusercontent.com/36699154/214760541-6931f696-5dd1-4aee-9178-83af4caab084.png">

##### No settings etc should be loaded
```code
vim -u NONE
vim -u NORC
```

<img width="1385" alt="image" src="https://user-images.githubusercontent.com/36699154/214761405-b09cf04b-d94e-4675-9df2-bf3e21fd2fb6.png">

#### Access to expression register: in NORMAL mode type "= and then &rtp for displaying the content of the runtime path option
#### And then enter and 'p' for paste

```code
"=&rtp
```
# 27.01.23
#### readlines() will read all lines and store them in a list as separate items
#### readline() will only return the first line

```python
with open('filename.txt') as f:
    lines = f.readlines()
    print(lines)
```

# 29.01.23
#### read() will read the entire file into memory as a single string (be carefull with large files)
#### and if you try to count line numbers it will count all characters

<img width="504" alt="image" src="https://user-images.githubusercontent.com/36699154/215355600-93092a10-c06b-4d05-a0d4-6440a8d6fc6b.png">

# 30.01.23
#### When pushing changes to remote on a server, github password is your personal access token!

<img width="494" alt="image" src="https://user-images.githubusercontent.com/36699154/215593312-b8142b8d-7063-44d4-b48e-6d50e1d5c71e.png">

# 01.02.2023
# Tired to type "git add ." "git commit -m "bla bla"" and "git push origin master"
" Just added this code to my .zshrc and triple baaaam

```code
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
```

