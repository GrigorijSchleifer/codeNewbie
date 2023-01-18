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


```
