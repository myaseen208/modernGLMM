# Package Identity Update

`modernGLMM` is positioned as a companion R implementation for the 2024 GLMM
text by Stroup, Ptukhina, and Garai.

The package exists because the book presents SAS workflows while recognizing
that R GLMM practice is distributed across many specialized packages. The
documentation now describes the package as a coherent R bridge across `lme4`,
`glmmTMB`, `nlme`, `mgcv`, `gamm4`, `brms`, `survival`, `coxme`, `emmeans`,
`DHARMa`, and `report`.

Primary identity surfaces updated:

- `DESCRIPTION`
- `README.Rmd` and `README.md`
- `R/modernGLMM-package.R`
- `man/modernGLMM-package.Rd`
- `inst/CITATION`
- `_pkgdown.yml`
- `NEWS.md`
- `inst/doc` rendered vignettes

All 21 vignette YAML headers now use `author: "Muhammad Yaseen"`.
The source build excludes top-level `README.html` through `.Rbuildignore` for
CRAN-safe packaging.
