# Example1.2 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

Exam1.2 is used to see types of model effects by plotting regression
data

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications (2nd
    ed.)*. CRC Press.

## See also

[`Table1.2`](https://github.com/myaseen208/modernGLMM/reference/Table1.2.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
#-------------------------------------------------------------
## Plot of multi-batch regression data discussed in Article 1.3
#-------------------------------------------------------------
data(Table1.2)

Table1.2$Batch <- factor(x  = Table1.2$Batch)

Plot  <-
 ggplot2::ggplot(
   data = Table1.2,
   mapping = ggplot2::aes(y = Y, x = X, colour = Batch, shape = Batch)
 ) +
 ggplot2::geom_point() +
 ggplot2::geom_smooth(method = "lm", fill =  NA) +
 ggplot2::labs(title   = "Plot of Multi Batch Regression data") +
 ggplot2::theme_bw()
Plot
#> `geom_smooth()` using formula = 'y ~ x'
```
