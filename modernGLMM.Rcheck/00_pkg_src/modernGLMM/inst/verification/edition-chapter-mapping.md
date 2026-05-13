# Edition Chapter Mapping: 1st Edition → 2nd Edition (2024)

This table maps first-edition chapter topics to their 2024 second-edition locations.
It is the basis for content-based LEGACY classification of exported package examples.
LEGACY status requires confirmed content absence — not merely example-number mismatch.

| 1st_ed_chapter | 1st_ed_title | 2nd_ed_chapter | 2nd_ed_title | Notes |
|---|---|---|---|---|
| 1 | Introduction to GLMMs | 1 | Introduction | Core concepts retained. |
| 2 | Design and linear model basics | 2 | Review of Relevant Statistical Concepts | Appendix B (design matrices) retained. |
| 3 | Single random factor models | 3 | Introduction to GLMM | Numerical examples verified against 2nd ed pp.69-136. |
| 4 | RCBD and factorial models | 4 | Pre-GLMM Estimation and Inference Basics | **PURE THEORY** — 2nd ed Ch4 (pp.137-145) covers OLS, GLS, estimable functions, BLUE, quadratic forms. Zero applied examples or datasets. Any applied 1st-ed Ch4 example is absent. **REMOVED_1ST_ONLY**: Exam4.1 (RCBD variance components), DataSet4.1 — deleted from R/, man/, data/. |
| 5 | Estimation and inference | 5 | GLMM Estimation | **PURE THEORY** — 2nd ed Ch5 (pp.146+) covers exponential family, ML, Newton-Raphson, Fisher scoring, quasi-likelihood. Zero applied examples or datasets. Any applied 1st-ed Ch5 example is absent. **REMOVED_1ST_ONLY**: Exam5.1 (binomial dose-response), Exam5.2 (factorial non-estimable), Exam5.3 (REML/ML ddf comparison), DataSet5.1, DataSet5.2 — all deleted from R/, man/, data/. |
| 6 | Poisson and count models | 6 | Introduction to GLMM Inference | Topic retained but chapter scope expanded. |
| 7 | Binomial models | 7 | More on Covariance Parameter Estimation | Topic retained. |
| 8 | Correlated error models (Gaussian) | 8 | Gaussian LMMs | Numerical examples verified against 2nd ed Ch8. |
| 9 | Split-plot and nested | 9 | Estimable Functions, Inference, and Prediction | Numerical examples verified against 2nd ed Ch9. |
| 10 | BLUP and random effects | 10 | Random Model and Mixed Model BLUPs | Numerical examples verified against 2nd ed Ch10. |
| 11 | Count data GLMMs | 11 | Poisson and Negative Binomial GLMMs for Count Data | Numerical examples partially verified; 7 documented mismatches (Ch11 mismatch taxonomy). |
| 12 | Binary and proportional | 12 | Rates and Proportions | **CORRECTED** — 2nd ed Ch12 "Rates and Proportions" covers binary/binomial and continuous-proportion (beta) models. Exam12.1 now implements Section 12.6.2: beta GLMM, 2 trt × 12 runs × 6 doses, 144 obs (`glmmTMB` beta_family); DataSet12.1 reconstructed from β₀₀=0.6965, β₁₀=0.2846 (trt0) and β₀₁=0.8054, β₁₁=0.5541 (trt1) via set.seed(2024). Exam12.2 now implements Section 12.3.2: nested factorial binomial, 10 blk × 6 trt, 60 obs (`lme4::glmer` with nested random effects); DataSet12.2 reconstructed from published B(A) LSMeans; published σ²_A≈0.4784, A: F(1,8)≈0.46, B(A): F(4,16)≈2.14. |
| 13 | Ordinal and multinomial | 13 | Multinomial and Ordinal GLMMs | No exported package example for Ch13. |
| 14 | Ordinal and multinomial (continued) | 14 | Multinomial Data | **CORRECTED** — 2nd ed Ch14 "Multinomial Data" covers proportional-odds (Section 14.3) and non-proportional odds (Section 14.4). Exam14.1 now implements Section 14.3: proportional-odds GLMM, 10 blk × 6 trt × 3 ordinal rating, 180 frequency obs (`glmmTMB` cumulative("logit")); first 9 rows transcribed exactly from p.435, remainder from η̂₀=0.3492, η̂₁=1.9956 via set.seed(2024). Exam14.2 now implements Section 14.4: non-proportional odds, 3 varieties × 12 growers × 3 ratings, 108 obs; marginal variety × rating table transcribed exactly from p.438; published proportional-odds F(2,8)≈0.02 (fail), non-proportional F(4,8)≈69.65. |
| 15 | Random coefficient models | 15 | Random Coefficient Models | No exported package example. |
| 16 | Spatial variability (Gaussian) | 16 | Spatial Variability, Part I: Gaussian Data | No exported package example. |
| 17 | Repeated measures | 17 | Correlated Errors, Part I: Repeated Measures | **CORRECTED** — Exam17.1 now implements Example 17.3.1: 41 subjects (17+24), 2-treatment crossover, 6 time points + baseline, 492 obs; CS/AR(1)/ARH(1) covariance model selection via `nlme::lme`; DataSet17.1 reconstructed via set.seed(2024); ARH(1) best ≈AICC 3035.25, equal slopes F(1,104)≈4.18, p≈0.0434. Exam17.2 now implements Example 17.3.2: 41 subjects, 9 unequally-spaced times (0,1,2,4,8,16,32,64,128), sparse 101/369 obs, SP(POW) via `nlme::corExp`; DataSet17.2 reconstructed via set.seed(2024); heterogeneous SP(POW) best ≈AICC 575.96, χ²≈8.65, p≈0.0132. |
| 18 | Spatial variability (non-Gaussian) | 18 | Correlated Errors, Part II: Spatial Variability | **CORRECTED** — Exam18.1 now implements Section 18.3: Alliance wheat trial, 48 trt, 12×12 grid, 144 obs; spherical/exponential/Gaussian covariance model selection via `nlme::gls`; DataSet18.1 reconstructed from range=4.1214, σ²=14.0107 via set.seed(2024); AICC: Sph≈512.9, Exp≈521.9, Gau≈530.9. Exam18.2 now implements Section 18.4: HessianFly binomial, 16 varieties, 4×4 lattice, 64 plots; RCB and incomplete block via `lme4::glmer`, G-side spherical via `glmmTMB`; DataSet18.2 reconstructed from published design and SP(SPH)≈3.2256, σ²≈0.5111 via set.seed(2024); AICC: RCB≈317.27, IncBlk≈296.64; F_entry≈6.81. |
| 19 | Bayesian GLMM | 19 | Bayesian Implementation of GLMM | No exported package example. |
| 20 | Bayesian examples | 20 | Bayesian GLMM Examples | No exported package example. |
| 21 | Power and sample size | 21 | Precision, Power, Sample Size, and Planning | **PARTIAL MATCH** — 2nd ed Ch21 Example 21.1.1 uses a 3-treatment CRD with μ₀=20, μ₁=μ₂=25, σ²=9, non-central F approach. Published values (12 quantities across n=5 and n=7) verified EXACT in R. Package Exam21.1 implements the same non-central F method via Cohen f parameterization with a pre-computed power grid. **REMOVED_1ST_ONLY**: Exam21.2 (t-test pilot study power) and DataSet21.2 — absent from 2nd ed Ch21; deleted from R/, man/, data/. |

## Classification Notes

- **PURE THEORY** chapters (Ch4, Ch5 in 2nd ed): No applied examples exist. Any package example referencing these chapters as a source for applied numerical content is LEGACY.
- **CORRECTED** chapters (Ch12, Ch14, Ch17, Ch18): The statistical topic exists in the 2nd ed chapter. Datasets were reconstructed from published design descriptions and model parameters (set.seed(2024)); Exam*.R functions were rewritten to match 2nd ed sections. Numerical output approximates — but does not reproduce exactly — published values because actual SAS data files are proprietary.
- **PARTIAL MATCH** (Ch21): The statistical method (non-central F) is verified EXACT against 2nd ed Example 21.1.1 published values. The dataset parameterization differs (book: exemplary data; package: pre-computed grid). Exam21.2 (t-test pilot) is fully absent.
