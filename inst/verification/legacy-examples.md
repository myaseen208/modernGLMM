# Legacy Examples

Legacy status is assigned only after confirming by **content search** that the example's
topic or dataset is genuinely absent from the 2024 2nd edition.  Number mismatch alone
is not sufficient justification.  See `edition-chapter-mapping.md` for the full
1st-edition → 2nd-edition chapter correspondence table.

## LEGACY Examples (confirmed by content)

| Example | Chapter | Content topic | 2nd ed location | Content absent? | Evidence | Action taken |
|---|---|---|---|---|---|---|
| Exam4.1 | 4 | REML vs ML comparison for RCBD, `DataSet4.1` | Ch4 = "Pre-GLMM Estimation and Inference Basics" (pp.137-145); pure OLS/GLS/estimable-functions theory | YES — Ch4 in 2nd ed has zero applied examples or datasets | PDF pp.155-166 confirm entire Ch4 is theoretical (OLS, GLS, BLUE, quadratic forms). Comment in Exam4.1 citing "page 138 (article 4.4.3.3)" refers to a theory section, not an RCBD example. | Classified LEGACY; namespace bugs fixed (removed library() calls, added explicit pkg:: prefixes). |
| Exam5.1 | 5 | Polynomial logistic regression, dose-response, `DataSet5.1` | Ch5 = "GLMM Estimation" (pp.146+); pure ML/Newton-Raphson/Fisher-scoring/quasi-likelihood theory | YES — Ch5 in 2nd ed has zero applied examples or datasets | PDF pp.167-174 confirm entire Ch5 is theoretical. Polynomial logistic regression content migrated to later chapters (Ch12). | Classified LEGACY; example code already uses proper `stats::` and `emmeans::` namespaces. |
| Exam5.2 | 5 | Sequential three-factor model building (`y~a`, `y~a+b`, `y~a+b+c`), `DataSet5.2` | Ch5 = pure theory (see above) | YES — Ch5 in 2nd ed has zero applied examples or datasets | Same evidence as Exam5.1. Sequential model building is a teaching device not tied to any 2nd-ed numbered example. | Classified LEGACY; namespace bugs fixed (removed library() calls, added explicit pkg:: prefixes for emmeans, parameters, stats). |
| Exam5.3 | 5 | REML/ML with Satterthwaite and KR ddf, `DataSet4.1` | Ch5 = pure theory (see above) | YES — Ch5 in 2nd ed has zero applied examples or datasets | Same evidence as Exam5.1. Ddf comparison content present in later 2nd-ed chapters (Ch8-10) under different datasets. | Classified LEGACY; namespace bugs fixed (removed library() calls, added explicit pkg:: prefixes for parameters, stats). |
| Exam21.2 | 21 | Prospective t-test power analysis from pilot study, `DataSet21.2` (30 obs, 2 groups) | Ch21 = "Precision, Power, Sample Size, and Planning". Examples 21.1.1, 21.1.2, 21.2, 21.3.1, 21.3.2, 21.3.3, 21.4.1, 21.4.2 all use GLMM exemplary-data approach. No t-test pilot study example exists. | YES — t-test-based pilot study power content entirely absent from 2nd ed Ch21. | PDF pp.621-638 (book pp.600-617) confirm all 2nd ed Ch21 examples use GLMM exemplary data (non-central F or χ²). No pilot-data t-test approach. | Classified LEGACY; example code already uses proper namespaces. |

## CORRECTED Examples (formerly LEGACY due to dataset mismatch; now corrected to match 2nd ed)

These 8 examples were previously classified LEGACY due to confirmed dataset mismatch.
Datasets have been reconstructed from the 2nd edition design description and published
model parameters; Exam*.R functions have been rewritten to match 2nd ed analyses.
Reconstruction uses `set.seed(2024)`; numerical output approximates published values.

| Example | Chapter | Old dataset (wrong) | 2nd ed target | Correction | Key published quantities (approx) |
|---|---|---|---|---|---|
| Exam12.1 | 12 | 5 trt × 4 blocks, 20 obs, quasi-binomial | Section 12.6.2: beta GLMM, 2 trt × 12 runs × 6 doses, 144 obs | DataSet12.1 reconstructed from β₀₀=0.6965, β₁₀=0.2846 (trt0) and β₀₁=0.8054, β₁₁=0.5541 (trt1); Exam12.1 rewritten with `glmmTMB::glmmTMB(..., family=beta_family())` | Dose-response beta GLMM; intercepts/slopes per treatment; lack-of-fit test |
| Exam12.2 | 12 | Split-plot, 3 rep × 2 WP × 3 SP, 18 obs | Section 12.3.2: nested factorial binomial, 10 blk × 6 trt, 60 obs | DataSet12.2 reconstructed from published B(A) LSMeans; Exam12.2 rewritten with `lme4::glmer(cbind(f,n-f) ~ a/b + (1+a|block), family=binomial)` | σ²_A≈0.4784; A: F(1,8)≈0.46, p≈0.5187; B(A): F(4,16)≈2.14, p≈0.1204 |
| Exam14.1 | 14 | 3 trt × 5 blocks, 90 individual obs | Section 14.3: proportional odds GLMM, 10 blk × 6 trt × 3 rating, 180 frequency obs | First 9 rows transcribed exactly from p.435; remaining reconstructed from η̂₀=0.3492, η̂₁=1.9956; Exam14.1 rewritten with `glmmTMB::glmmTMB(..., family=cumulative("logit"))` | η̂₀≈0.3492, η̂₁≈1.9956; Treatment F(5,768)≈17.67, p<0.0001 |
| Exam14.2 | 14 | 4-cat nominal, 4 trt, 100 obs | Section 14.4: non-proportional odds, 3 varieties × 12 growers × 3 ratings, 108 obs | Marginal variety × rating table transcribed exactly from p.438; distributed across 12 growers; Exam14.2 rewritten showing proportional-odds failure and non-proportional-odds model | Proportional odds F(2,8)≈0.02, p≈0.98; non-proportional odds F(4,8)≈69.65 |
| Exam17.1 | 17 | 20 subjects, 4 time points, 80 obs | Example 17.3.1: crossover ARH(1), 41 subjects, 2 periods × 6 times + baseline, 492 obs | DataSet17.1 reconstructed from published model (17 seq 0→1, 24 seq 1→0); Exam17.1 rewritten with CS/AR(1)/ARH(1) comparison via `nlme::lme` | Best covariance ARH(1), AICC≈3035.25; equal slopes F(1,104)≈4.18, p≈0.0434 |
| Exam17.2 | 17 | 3×3 Williams crossover, 36 obs | Example 17.3.2: SP(POW), 41 subjects, 9 unequal times, sparse (101/369 obs) | DataSet17.2 reconstructed from published random coefficient model (2 trt, times 0,1,2,4,8,16,32,64,128); Exam17.2 rewritten with `nlme::lme` + `corExp` for SP(POW) | Heterogeneous SP(POW) AICC≈575.96 (best); χ²≈8.65, p≈0.0132 |
| Exam18.1 | 18 | 6×6 Gaussian field, 4 trt, 36 obs | Section 18.3: Alliance wheat trial, 48 trt, 12×12 grid, 144 obs | DataSet18.1 reconstructed from published design (3 column blocks) and spatial parameters (range=4.1214, σ²=14.0107); Exam18.1 rewritten with `nlme::gls` + `corSpher`/`corExp`/`corGaus` | SP(SPH) range≈4.1214; AICC: Sph≈512.9, Exp≈521.9, Gau≈530.9 |
| Exam18.2 | 18 | AR(1) time-series, 5 blk × 3 trt × 6 time, 90 obs | Section 18.4: HessianFly binomial spatial, 16 varieties, 4×4 lattice, 64 plots | DataSet18.2 reconstructed from 4×4 lattice design; Exam18.2 rewritten with `lme4::glmer` (RCB/incomplete block) and `glmmTMB::glmmTMB` (G-side spherical spatial) | AICC: RCB≈317.27, IncBlk≈296.64; F_entry≈6.81; SP(SPH)≈3.2256 |

## Non-LEGACY: Exam21.1 — Verified EXACT

`Exam21.1` implements the same non-central F power analysis as 2nd edition Example 21.1.1.
All 12 published quantities were verified EXACT in R (2026-05-12):

| Quantity | df1 | df2 | n | Book value | R value | Status |
|---|---|---|---|---|---|---|
| F_Crit | 2 | 12 | 5 | 3.88529 | 3.88529 | EXACT |
| nc_parm overall | — | — | 5 | 9.25926 | 9.25926 | EXACT |
| Power overall F | 2 | 12 | 5 | 0.66605 | 0.66605 | EXACT |
| F_Crit contrast | 1 | 12 | 5 | 4.74723 | 4.74723 | EXACT |
| Power ctrl vs exp | 1 | 12 | 5 | 0.79750 | 0.79750 | EXACT |
| nc_parm ctrl vs exp1 | — | — | 5 | 6.94444 | 6.94444 | EXACT |
| Power ctrl vs exp1 | 1 | 12 | 5 | 0.67750 | 0.67750 | EXACT |
| F_Crit | 2 | 18 | 7 | 3.55456 | 3.55456 | EXACT |
| nc_parm overall | — | — | 7 | 12.96300 | 12.96296 | EXACT |
| Power overall F | 2 | 18 | 7 | 0.84969 | 0.84969 | EXACT |
| F_Crit contrast | 1 | 18 | 7 | 4.41387 | 4.41387 | EXACT |
| Power ctrl vs exp | 1 | 18 | 7 | 0.92543 | 0.92543 | EXACT |

Note: Package `Exam21.1` uses Cohen f parameterization with a pre-computed power grid
(`DataSet21.1`) rather than the book's exemplary-data approach, but the underlying
non-central F computation is identical.  The example is NOT LEGACY.

## Full Chapter 1-21 Legacy Classification Status

All exported package examples are now classified by **content**, not number:
- 5 examples confirmed LEGACY by content search (Exam4.1, Exam5.1-5.3, Exam21.2)
- 8 examples CORRECTED (Exam12.1-12.2, Exam14.1-14.2, Exam17.1-17.2, Exam18.1-18.2): datasets reconstructed from 2nd ed design descriptions and published model parameters; Exam*.R functions rewritten to match 2nd ed Section analyses; set.seed(2024); numerical output approximates published values
- 1 example (Exam21.1) confirmed NOT LEGACY; statistical method verified EXACT against 12 published quantities from 2nd ed Example 21.1.1
