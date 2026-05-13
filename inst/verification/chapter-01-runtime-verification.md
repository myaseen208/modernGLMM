# Chapter 1 Runtime Verification

Scope: `Exam1.1` quantities with numerical values printed in Chapter 1,
Sections 1.2.3 and 1.2.4 of Stroup, Ptukhina, and Garai (2024).

`Exam1.2` is a plot-oriented illustration of Table 1.2. Chapter 1 does not
print fitted numerical output for that plot, so it remains outside the numerical
verification table.

## Model Definitions Run

```r
data(Table1.1)

lm1 <- stats::lm(y / Nx ~ x, data = Table1.1)

glm1 <- stats::glm(
  cbind(y, Nx - y) ~ x,
  family = stats::binomial(link = "logit"),
  data = Table1.1
)
```

The package and Chapter 1 vignette were corrected to use the binomial-count
response for the logistic GLM. The previous unweighted proportion model did not
reproduce the book's printed logit estimates.

## Runtime Values

| Quantity | Book Value | Package Value | Status |
|---|---:|---:|---|
| LM beta0 | -0.089 | -0.08943985 | EXACT |
| LM beta1 | 0.1115 | 0.11151515 | EXACT |
| LM slope p-value | <0.0001 | 0.000003706 | EXACT |
| LM R-squared | 0.917 | 0.9167923 | EXACT |
| LM fitted p at x = 0 | -0.089 | -0.08943985 | EXACT |
| LM fitted p at x = 10 | 1.026 | 1.02571166 | EXACT |
| Logistic GLM beta0 | -4.109 | -4.1085728 | EXACT |
| Logistic GLM beta1 | 0.764 | 0.7640431 | EXACT |
| Logistic GLM fitted p at x = 0 | 0.016 | 0.01616559 | EXACT |
| Logistic GLM fitted p at x = 10 | 0.972 | 0.97158075 | EXACT |
| LM observed-fitted correlation | 0.957 | 0.9574927 | EXACT |
| Logistic GLM observed-fitted correlation | 0.982 | 0.9817539 | EXACT |
