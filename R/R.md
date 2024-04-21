## 21.04.24

```R
# returns the directory (all parts) of a file path, but not the file name
dirname(file.path("","p1","p2","p3", "filename"))
# "/p1/p2/p3"

# returns the base (last part) of a file path
basename(file.path("","p1","p2","p3", "filename"))
# "filename"
```

## 01.10.23
#### RStudio: Switching between the console and the code editor without using your mouse (Mac)

```command line
ctrl 1 (for code editor)
ctrl 2 (for console)
```