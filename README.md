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

### 20.01.23
##### Github: A cool trick to fire up Vs Code in github, just to press '.' in a repository or to change github.com/ropository name to 'github.dev/repository name

### 22.01.23
##### VIM: Display all colorschemes that are used in vim: in vim's normal mode press `:colorscheme [space] [Ctrl+d]`


