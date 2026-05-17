# modernGLMM: Unified R Workflows for Generalized Linear Mixed Models

\`modernGLMM\` provides unified, reproducible R implementations of
examples from Stroup, W. W., Ptukhina, M., and Garai, S. (2024),
*Generalized Linear Mixed Models: Modern Concepts, Methods and
Applications*, second edition, CRC Press.

The 2024 book uses SAS for the worked examples and notes that the R GLMM
ecosystem is powerful but fragmented. This package responds to that gap
by collecting coherent R workflows for the book examples and by
documenting how modern R tools fit together for estimation, inference,
diagnostics, visualization, and reporting.

## Scope

The package includes datasets, example code, vignettes, and verification
artifacts for linear models, generalized linear models, linear mixed
models, and generalized linear mixed models. Coverage spans designed
experiments, best linear unbiased prediction, treatment structures,
multi-level designs, count data, rates and proportions, multinomial
responses, time-to-event data, smoothing splines, repeated measures,
correlated errors, Bayesian GLMMs, and power analysis.

## R Ecosystem

Workflows use explicit namespaces and draw from the R mixed-model
ecosystem:

- lme4:

  Linear and generalized linear mixed models.

- glmmTMB:

  Flexible GLMMs, including count and zero-inflated models.

- nlme:

  Correlated-error and repeated-measures models.

- mgcv and gamm4:

  Smoothing splines and additive mixed models.

- brms:

  Bayesian GLMM implementations.

- survival and coxme:

  Time-to-event and frailty models.

- emmeans:

  Estimated marginal means and contrasts.

- DHARMa:

  Simulation-based residual diagnostics.

- report:

  Readable model summaries.

## Workflow Example



    data(DataSet11.1)
    fit <- stats::glm(y ~ trt, family = stats::poisson(link = "log"), data = DataSet11.1)
    summary(fit)

    if (requireNamespace("emmeans", quietly = TRUE)) {
      emmeans::emmeans(fit, specs = ~ trt, type = "response")
    }

    if (requireNamespace("report", quietly = TRUE)) {
      report::report(fit)
    }

## GLMM Model Framework

A generalized linear mixed model can be written as \$\$g(\mu\_{ij}) =
\mathbf{x}\_{ij}^\top \boldsymbol{\beta} + \mathbf{z}\_{ij}^\top
\mathbf{b}\_i\$\$ with random effects \\\mathbf{b}\_i \sim
\mathcal{N}(\mathbf{0}, \mathbf{G})\\ and conditional responses drawn
from an exponential-family distribution.

## References

1.  Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized
    Linear Mixed Models: Modern Concepts, Methods and Applications* (2nd
    ed.). CRC Press.

2.  Bates, D., Maechler, M., Bolker, B., and Walker, S. (2015). Fitting
    linear mixed-effects models using lme4. *Journal of Statistical
    Software*, 67(1), 1-48.

3.  Lenth, R. V. (2023). emmeans: Estimated Marginal Means, aka
    Least-Squares Means. R package.

## See also

- <https://github.com/myaseen208/modernGLMM>

## Author

1.  Muhammad Yaseen (<myaseen208@gmail.com>)

2.  Adeela Munawar (<adeela.uaf@gmail.com>)

3.  Walter W. Stroup (<wstroup@unl.edu>)

4.  Marina Ptukhina (<ptukhim@whitman.edu>)

5.  Soumit Garai
