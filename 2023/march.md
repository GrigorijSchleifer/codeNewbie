# 01.03.23

<details>
  <summary>Permanently add environment variables to ~/.zshenv</summary>
<br>

```txt
So if you want to add your own variables that you can use later after bash session was terminated, you have to add them to a file that is sourced each time you start your shell. For me this is ~/.zshev file.
```

```console
# the output of echo (GS=grigorijschleifer) will be saved in ~/.zshenv. 
echo 'GS=grigorijschleifer' >> ~/.zshenv

# to make changes permanently just source the .zshenv file and you will have your own environmental variable to your disposal
source ~/.zshenv 
```
</details>
