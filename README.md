# 29.07.2024

This code creates two plots: one with a normal y-axis and another with a logarithmic y-axis. The logarithmic scale helps to better visualize the exponential relationship by compressing the y-axis.

```R
# Create data frame with exponential relationship
df_exp <- data.frame(
    normal = c(1:100),
    exp = exp(1:100)
)
```

```R
# Plot with normal y-axis
df_exp %>% 
    ggplot(aes(normal, exp)) +
    geom_point()
```
![image](https://github.com/user-attachments/assets/876521d4-7064-4cc9-b36e-d094256c2169)

```R
# Plot with logarithmic y-axis
df_exp %>% 
    ggplot(aes(normal, exp)) +
    geom_point() +
    scale_y_log10()
```
![image](https://github.com/user-attachments/assets/f576b80b-9a6a-44c1-8bfc-fdfd2a94f17f)

# 13.07.24

First encounter of the pipe operator behaving weirdly (something with left and right)

```R
major_processed |> 
  select(Major, Total, ShareWomen, Sample_size, Median) %>%
  lm(Median ~ ShareWomen, data = ., weights = Sample_size)
```

# 13.07.24

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/R">R</a>

```R
# facet_grid() forms a matrix of panels defined by row and column faceting variables. It is most useful when you have two discrete variables,
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)
  ```

# 12.07.24

```R
# This vignette summarises the various formats that grid drawing functions take. Most of this information is available scattered throughout the R documentation. This appendix brings it all together in one place.
vignette("ggplot2-specs")
````

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

# 21.04.24

```R
# returns the directory (all parts) of a file path, but not the file name
dirname(file.path("","p1","p2","p3", "filename"))
# "/p1/p2/p3"

# returns the base (last part) of a file path
basename(file.path("","p1","p2","p3", "filename"))
# "filename"
```

# 01.10.23

RStudio: Switching between the console and the code editor without using your mouse (Mac)

```command line
ctrl 1 (for code editor)
ctrl 2 (for console)
```

