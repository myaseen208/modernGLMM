# DataSet3.2 for Example 3.3, Example 3.4, Example3.6, Example3.8 and Example 3.9 from Generalized Linear Mixed Models: Modern Concepts, Methods and Applications by Stroup, Ptukhina, and Garai (2024, 2nd ed.)

DataSet3.2 Multi-Location, 4 Treatment Randomized Block

## Usage

``` r
data(DataSet3.2)
```

## Format

A `data.frame` with 32 rows and 10 variables.

## Details

- trt four treatments, coded 0, 1, 2, and 3

- loc eight locations used as blocks

- Y is Gaussian response variable

- Nbin subjects at each Loc x Trt for binomial response

- S1 and S2 are two binomial response variables

- count1 and count 2 used later

- A and B factorial treatment components with levels 0 and 1; the
  mapping follows the Chapter 3, Section 3.3.5 `a*b` least-squares means
  table

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024).*Generalized
    linear mixed models: modern concepts, methods and applications*. CRC
    Press.

## See also

[`Exam3.3`](https://github.com/myaseen208/modernGLMM/reference/Exam3.3.md)
[`Exam3.9`](https://github.com/myaseen208/modernGLMM/reference/Exam3.9.md)

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

## Examples

``` r
data(DataSet3.2)
```
