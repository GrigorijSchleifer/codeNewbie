# 04.05.24

```R
# Load built-in datasets and show what is available
data()
```

```R
# move new column before existing column 1
mutate(new_column = x - y, .before = 1)

# move new column before specified column by name
mutate(new_column = x - y, .before = soneColumnName)

# Example
nycflights13::flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1,
    .keep = "used"
  )
```

# 02.05.24

```R
# modulo: result is the remainder 1
7 %% 2

# regular division: result is 3.5
7 / 2

# integer division: result is 3
7 %/% 2
```

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