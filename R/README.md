


```R
# exponential relationship
df_exp <- data.frame(
    normal = c(1:100),
    exp = exp(1:100)
)
```

```R
# normal logs view
df_exp %>% 
    ggplot(aes(normal, exp)) +
    geom_point()
```
![image](https://github.com/user-attachments/assets/876521d4-7064-4cc9-b36e-d094256c2169)

```R
# y axis log10
df_exp %>% 
    ggplot(aes(normal, exp)) +
    geom_point() +
    scale_y_log10()
```
![image](https://github.com/user-attachments/assets/f576b80b-9a6a-44c1-8bfc-fdfd2a94f17f)

