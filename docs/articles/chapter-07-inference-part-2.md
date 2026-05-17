# Chapter 7: Inference, Part II

``` r
library(modernGLMM)
library(emmeans)
library(car)
```

## 1 Overview

Chapter 7 covers fixed-effects inference: constructing estimable
functions, computing contrasts, and performing multiple comparisons in
(G)LMMs.

Key topics:

- **Estimability**: not all linear combinations of
  \\\boldsymbol{\beta}\\ can be estimated; `emmeans` handles this
  transparently.
- **Contrasts**: custom linear combinations via
  [`emmeans::contrast()`](https://rvlenth.github.io/emmeans/reference/contrast.html).
- **Multiple comparisons**: Tukey, Bonferroni, Scheffé, and FDR
  adjustments.
- **Interaction dissection**:
  [`emmeans::joint_tests()`](https://rvlenth.github.io/emmeans/reference/joint_tests.html)
  for simple effects.

## 2 Treatment Structure Example (DataSet8.1)

The 2×3 factorial from Chapter 8 is used here to illustrate contrast
coding.

``` r
data(DataSet8.1)
DataSet8.1$a <- factor(DataSet8.1$a)
DataSet8.1$b <- factor(DataSet8.1$b)

fit <- stats::lm(y ~ a * b, data = DataSet8.1)
```

### 2.1 Estimated marginal means

``` r
emm <- emmeans::emmeans(fit, ~ a * b)
print(emm)
```

     a b emmean   SE df lower.CL upper.CL
     0 0   50.5 2.56 18     45.1     55.9
     1 0   67.8 2.56 18     62.4     73.1
     0 1   59.8 2.56 18     54.4     65.1
     1 1   67.2 2.56 18     61.9     72.6
     0 2   71.5 2.56 18     66.1     76.9
     1 2   71.0 2.56 18     65.6     76.4

    Confidence level used: 0.95 

### 2.2 All pairwise comparisons within each level of `a`

``` r
pairs(
  emmeans::emmeans(fit, ~ b | a),
  adjust = "tukey"
)
```

    a = 0:
     contrast estimate   SE df t.ratio p.value
     b0 - b1     -9.25 3.62 18  -2.554  0.0498
     b0 - b2    -21.00 3.62 18  -5.798 <0.0001
     b1 - b2    -11.75 3.62 18  -3.244  0.0119

    a = 1:
     contrast estimate   SE df t.ratio p.value
     b0 - b1      0.50 3.62 18   0.138  0.9896
     b0 - b2     -3.25 3.62 18  -0.897  0.6488
     b1 - b2     -3.75 3.62 18  -1.035  0.5649

    P value adjustment: tukey method for comparing a family of 3 estimates 

### 2.3 Simple effects (ANOVA for b within each level of a)

``` r
emmeans::joint_tests(fit, by = "a")
```

|     | model term | a   | df1 | df2 | F.ratio |   p.value |
|:----|:-----------|:----|----:|----:|--------:|----------:|
| 1   | b          | 0   |   2 |  18 |  16.888 | 0.0000742 |
| 3   | b          | 1   |   2 |  18 |   0.632 | 0.5428773 |

### 2.4 Custom contrasts

``` r
emmeans::contrast(emm, list(
  "a0: b0 vs b1" = c(1, -1, 0, 0, 0, 0),
  "a1: b0 vs b1" = c(0, 0, 0, 1, -1, 0)
))
```

     contrast     estimate   SE df t.ratio p.value
     a0: b0 vs b1   -17.25 3.62 18  -4.763  0.0002
     a1: b0 vs b1    -4.25 3.62 18  -1.173  0.2559

## 3 Key Takeaways

- [`emmeans::emmeans()`](https://rvlenth.github.io/emmeans/reference/emmeans.html)
  computes estimable marginal means automatically.
- [`emmeans::contrast()`](https://rvlenth.github.io/emmeans/reference/contrast.html)
  accepts named lists of contrast vectors.
- [`emmeans::joint_tests()`](https://rvlenth.github.io/emmeans/reference/joint_tests.html)
  provides F-tests for each term, optionally `by` a conditioning
  variable (equivalent to SAS `SLICE`).
- Multiplicity adjustment (`adjust = "tukey"`, `"bonferroni"`, `"fdr"`)
  is passed as an argument to
  [`pairs()`](https://rdrr.io/r/graphics/pairs.html) or
  [`contrast()`](https://rvlenth.github.io/emmeans/reference/contrast.html).

## 4 References

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear
Mixed Models: Modern Concepts, Methods and Applications (2nd ed.)*. CRC
Press.
