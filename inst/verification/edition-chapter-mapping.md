# Edition Chapter Mapping: 1st Edition → 2nd Edition (2024)

This table maps first-edition chapter topics to their 2024 second-edition locations.
It is the basis for content-based LEGACY classification of exported package examples.
LEGACY status requires confirmed content absence — not merely example-number mismatch.

| 1st_ed_chapter | 1st_ed_title | 2nd_ed_chapter | 2nd_ed_title | Notes |
|---|---|---|---|---|
| 1 | Introduction to GLMMs | 1 | Introduction | Core concepts retained. |
| 2 | Design and linear model basics | 2 | Review of Relevant Statistical Concepts | Appendix B (design matrices) retained as datasets (vignette use). **REMOVED_MISMATCH_UNRESOLVABLE**: Exam2.B.1–Exam2.B.7 deleted from R/, man/ in Phase 5 — 2nd ed presents Appendix B as SAS PROC GLIMMIX syntax only with no printed numerical output; all 7 rows were UNVERIF_CONFIRMED_ABSENT. DataExam2.B.2/3/4/7 retained for vignette. |
| 3 | Single random factor models | 3 | Introduction to GLMM | Numerical examples verified against 2nd ed pp.69-136. |
| 4 | RCBD and factorial models | 4 | Pre-GLMM Estimation and Inference Basics | **PURE THEORY** — 2nd ed Ch4 (pp.137-145) covers OLS, GLS, estimable functions, BLUE, quadratic forms. Zero applied examples or datasets. Any applied 1st-ed Ch4 example is absent. **REMOVED_1ST_ONLY**: Exam4.1 (RCBD variance components), DataSet4.1 — deleted from R/, man/, data/. |
| 5 | Estimation and inference | 5 | GLMM Estimation | **PURE THEORY** — 2nd ed Ch5 (pp.146+) covers exponential family, ML, Newton-Raphson, Fisher scoring, quasi-likelihood. Zero applied examples or datasets. Any applied 1st-ed Ch5 example is absent. **REMOVED_1ST_ONLY**: Exam5.1 (binomial dose-response), Exam5.2 (factorial non-estimable), Exam5.3 (REML/ML ddf comparison), DataSet5.1, DataSet5.2 — all deleted from R/, man/, data/. |
| 6 | Poisson and count models | 6 | Introduction to GLMM Inference | Topic retained but chapter scope expanded. |
| 7 | Binomial models | 7 | More on Covariance Parameter Estimation | Topic retained. |
| 8 | Correlated error models (Gaussian) | 8 | Gaussian LMMs | Numerical examples verified against 2nd ed Ch8. **REMOVED_MISMATCH_UNRESOLVABLE**: Exam8.6 deleted from R/, man/ in Phase 5 — 2nd ed presents Hoerl/Gompertz response-surface fits graphically only; UNVERIF_CONFIRMED_ABSENT. DataSet8.6 retained for vignette/test. |
| 9 | Split-plot and nested | 9 | Estimable Functions, Inference, and Prediction | Numerical examples verified against 2nd ed Ch9. |
| 10 | BLUP and random effects | 10 | Random Model and Mixed Model BLUPs | Numerical examples verified against 2nd ed Ch10. |
| 11 | Count data GLMMs | 11 | Poisson and Negative Binomial GLMMs for Count Data | Exam11.1 and Exam11.3 retained (Exam11.3 with 4 EXACT/APPROX rows; 7 MISMATCH rows dropped from CSV in Phase 5). **REMOVED_MISMATCH_UNRESOLVABLE**: Exam11.4 deleted from R/, man/ — synthetic dataset, no 2nd ed printed output to verify against; all 4 rows UNVERIF_CONFIRMED_ABSENT. DataSet11.4 retained for vignette. |
| 12 | Binary and proportional | 12 | Rates and Proportions | **REMOVED_MISMATCH_UNRESOLVABLE**: Exam12.1, Exam12.2 deleted from R/, man/ in Phase 5 — both rows were UNVERIF_CONFIRMED_ABSENT (reconstructed datasets from 1st ed; 2nd ed uses different designs; no printable quantities reproduced exactly). DataSet12.1, DataSet12.2 retained for vignette. |
| 13 | Ordinal and multinomial | 13 | Multinomial and Ordinal GLMMs | No exported package example for Ch13. |
| 14 | Ordinal and multinomial (continued) | 14 | Multinomial Data | **REMOVED_MISMATCH_UNRESOLVABLE**: Exam14.1, Exam14.2 deleted from R/, man/ in Phase 5 — both rows were UNVERIF_CONFIRMED_ABSENT (reconstructed datasets from 1st ed; 2nd ed uses different ordinal designs; no printable quantities reproduced exactly). DataSet14.1, DataSet14.2 retained for vignette. |
| 15 | Random coefficient models | 15 | Random Coefficient Models | No exported package example. |
| 16 | Spatial variability (Gaussian) | 16 | Spatial Variability, Part I: Gaussian Data | No exported package example. |
| 17 | Repeated measures | 17 | Correlated Errors, Part I: Repeated Measures | **REMOVED_MISMATCH_UNRESOLVABLE**: Exam17.1, Exam17.2 deleted from R/, man/ in Phase 5 — both rows were UNVERIF_CONFIRMED_ABSENT (reconstructed datasets from 1st ed; 2nd ed uses different crossover/sparse designs; no printable quantities reproduced exactly). DataSet17.1, DataSet17.2 retained for vignette. |
| 18 | Spatial variability (non-Gaussian) | 18 | Correlated Errors, Part II: Spatial Variability | **REMOVED_MISMATCH_UNRESOLVABLE**: Exam18.1, Exam18.2 deleted from R/, man/ in Phase 5 — both rows were UNVERIF_CONFIRMED_ABSENT (reconstructed datasets from 1st ed; 2nd ed uses different spatial/lattice designs; no printable quantities reproduced exactly). DataSet18.1, DataSet18.2 retained for vignette. |
| 19 | Bayesian GLMM | 19 | Bayesian Implementation of GLMM | No exported package example. |
| 20 | Bayesian examples | 20 | Bayesian GLMM Examples | No exported package example. |
| 21 | Power and sample size | 21 | Precision, Power, Sample Size, and Planning | **PARTIAL MATCH** — 2nd ed Ch21 Example 21.1.1 uses a 3-treatment CRD with μ₀=20, μ₁=μ₂=25, σ²=9, non-central F approach. Published values (12 quantities across n=5 and n=7) verified EXACT in R. Package Exam21.1 implements the same non-central F method via Cohen f parameterization with a pre-computed power grid. **REMOVED_1ST_ONLY**: Exam21.2 (t-test pilot study power) and DataSet21.2 — absent from 2nd ed Ch21; deleted from R/, man/, data/. |

## Classification Notes

- **PURE THEORY** chapters (Ch4, Ch5 in 2nd ed): No applied examples exist. All applied 1st-ed examples are LEGACY.
- **REMOVED_1ST_ONLY**: Functions removed in Phase 2 — 1st edition legacy content confirmed absent from 2nd ed.
- **REMOVED_MISMATCH_UNRESOLVABLE**: Functions removed in Phase 5 — every quantity was either MISMATCH (irreducible) or UNVERIF_CONFIRMED_ABSENT (content absent from 2nd ed PDF). Datasets retained for vignette use.
- **PARTIAL MATCH** (Ch21): Exam21.1 verified EXACT against 2nd ed Example 21.1.1 (12 quantities). Exam21.2 (t-test pilot) removed as REMOVED_1ST_ONLY.
