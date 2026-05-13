# Mismatch Report

Scope: unresolved mismatches from completed Chapter 1, Chapter 2-5, Chapter 8-10, Chapter 12-21 classification, and Chapter 11 verification. No all-chapter mismatch claim is made.

Phase 4 updated 2026-05-12: 18 confirmed irreducible MISMATCHes remain. Removed 4 entries
that were resolved to EXACT (Exam8.7 spline_x F, Exam8.7 spline_x*a F, Exam9.1 Set F,
Exam9.1 Set p). Added 6 new entries (Exam9.4 NOBOUND x4, Exam10.2 BLUP SE, Exam10.4 BLUP SE).
Updated Exam8.7 a F/p package values to reflect RANGEFRACTION+SAS-effect-coding refit.

---

## MISMATCH: Exam11.3 - Naive Poisson Pearson chi-square/DF

Book value: 6.88

Package value: 7.1294

Difference: 0.2494 (3.6%)

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Action taken: dataset reconstruction issue | Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned Pearson chi-square/DF 7.1294. MASS glmmPQL was also checked for fitted means but is not the book's Laplace fit. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Naive Poisson mean trt 1

Book value: 4.7023

Package value: 4.2842

Difference: 0.4181 (8.9%)

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Action taken: dataset reconstruction issue | Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 1 mean 4.2842/4.2839. MASS glmmPQL returned 5.3844, not the printed 4.7023. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Naive Poisson mean trt 2

Book value: 7.8176

Package value: 7.1225

Difference: 0.6951 (8.9%)

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Action taken: dataset reconstruction issue | Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 2 mean 7.1225/7.1220. MASS glmmPQL returned 8.9516, not the printed 7.8176. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Naive Poisson mean trt 3

Book value: 15.1061

Package value: 13.763

Difference: 1.3431 (8.9%)

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Action taken: dataset reconstruction issue | Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 3 mean 13.7630/13.7620. MASS glmmPQL returned 17.2974, not the printed 15.1061. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Poisson-normal unit VC

Book value: 0.9805

Package value: 0.7801

Difference: 0.2004 (20.4%)

Diagnosis: Primary cause: dataset reconstruction issue. lme4 nAGQ=0, lme4 nAGQ=1, and glmmTMB ML all return unit variance near 0.78, so the gap is not repaired by the available R likelihood options.

Action taken: dataset reconstruction issue | Re-fit Poisson-normal model with lme4 nAGQ=0, lme4 nAGQ=1, and glmmTMB ML. Unit VC values were 0.7801, 0.7812, and 0.7817, respectively, versus the printed 0.9805. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Negative-binomial block VC

Book value: 0.7272

Package value: 0.8505

Difference: 0.1233 (17.0%)

Diagnosis: Primary cause: estimation method mismatch with software limitation. The book reports SAS GLIMMIX pseudo-likelihood output; glmmTMB nbinom2 ML gives a different block variance and no direct GLIMMIX PL analogue is available in the package workflow.

Action taken: estimation method mismatch; software limitation | Re-fit negative-binomial model using glmmTMB nbinom2 ML, nbinom1 ML, and nbinom2 REML. Block VC values were 0.8505, 0.2676, and 0.9765, none jointly reproduced the printed GLIMMIX PL result. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam11.3 - Negative-binomial scale phi

Book value: 0.845

Package value: 0.683

Difference: 0.162 (19.2%)

Diagnosis: Primary cause: estimation method mismatch with software limitation. The book's negative-binomial scale is reported by SAS GLIMMIX PL; glmmTMB estimates the nbinom2 theta parameter by ML/REML and only an approximate phi conversion is available.

Action taken: estimation method mismatch; software limitation | Re-fit negative-binomial model using glmmTMB nbinom2 ML and REML. Book-scale phi approximations were 0.6830 and 0.7668 versus the printed 0.845; nbinom1 scale is not the same parameter. | Unresolved; retained as MISMATCH and documented explicitly.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam8.7 - a F

Book value: 15.16

Package value: 3.194419

Difference: 11.965581 (78.9%)

Diagnosis: Irreducible estimable-function difference. GLIMMIX Type III test for qualitative factor a in a spline model constructs a different estimable function than car::linearHypothesis on an lm B-spline basis. The RANGEFRACTION knot placement and SAS effect coding were applied to match the spline component F statistics (spline_x and spline_x*a are now EXACT), but the marginal a F statistic reflects a fundamentally different hypothesis in SAS GLIMMIX vs. R lm.

Action taken: Applied RANGEFRACTION inner knots (x_min + seq(0.1, 0.9, 0.1) * (x_max - x_min)), SAS effect coding (a=1 → +1, a=2 → -1), and car::linearHypothesis for joint F tests. Spline_x F and spline_x*a F are now EXACT; marginal a F remains a confirmed MISMATCH due to estimable-function construction difference.

Resolution: Confirmed irreducible after applying all 7 diagnostic steps. Root cause: GLIMMIX EFFECT statement smoothing-spline marginal test vs. R lm polynomial spline joint hypothesis test differ in estimable-function construction for the qualitative factor.

## MISMATCH: Exam8.7 - a p

Book value: 1e-04

Package value: 0.075131

Difference: 0.075031 (75031%)

Diagnosis: Irreducible estimable-function difference. p-value follows from the different F statistic for a (see Exam8.7 a F diagnosis above).

Action taken: Updated p-value follows from RANGEFRACTION+SAS-effect-coding refit. The new p-value 0.075131 is closer to book 0.0001 but still a MISMATCH because the F statistic construction differs.

Resolution: Confirmed irreducible. Root cause identical to Exam8.7 a F.

## MISMATCH: Exam9.4 - Bounded a F

Book value: 4.86

Package value: 4.714756

Difference: 0.145244 (3.0%)

Diagnosis: R/SAS Kenward-Roger denominator df difference when a variance component is at its boundary (zero). lme4/lmerTest KR approximation diverges from SAS GLIMMIX KR at boundary VCs.

Action taken: Fitted bounded lmerTest model; lme4 cannot reproduce SAS NOBOUND negative variance fits. KR denominator df approximation differs at boundary.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam9.4 - Bounded b F

Book value: 17.14

Package value: 17.239067

Difference: 0.099067 (0.6%)

Diagnosis: R/SAS Kenward-Roger difference under a boundary variance component; retained mismatch where it exceeds tolerance.

Action taken: Fitted bounded lmerTest model; lme4 cannot reproduce SAS NOBOUND negative variance fits.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam9.4 - Bounded a:b F

Book value: 3.86

Package value: 3.058034

Difference: 0.801966 (20.8%)

Diagnosis: R/SAS Kenward-Roger difference under a boundary variance component; retained mismatch where it exceeds tolerance.

Action taken: Fitted bounded lmerTest model; lme4 cannot reproduce SAS NOBOUND negative variance fits.

Resolution: Unresolved after dataset/model/estimation review. The remaining gap is documented in dataset provenance and retained as a mismatch.

## MISMATCH: Exam9.4 - NOBOUND Intercept Block VC

Book value: 7.8469

Package value: not available in R

Diagnosis: Software limitation: lme4/lmerTest constrain all variance components to >= 0 (Cholesky parameterization). SAS NOBOUND option allows an unconstrained REML fit where the intercept block VC = 7.8469. The bounded R fit forces the VC to 0, yielding a different model.

Action taken: Confirmed that lme4 cannot fit NOBOUND models. This quantity is printed in the book as a NOBOUND REML result and is not reproducible in lmerTest without a custom optimizer bypass.

Resolution: Confirmed irreducible. Root cause: SAS NOBOUND vs. lme4 non-negative VC constraint. Not reproducible in R.

## MISMATCH: Exam9.4 - NOBOUND a Block VC

Book value: -6.5950

Package value: not available in R

Diagnosis: Software limitation: SAS NOBOUND allows a negative variance component (-6.5950) for factor a random block effect. lme4/lmerTest constrain VCs >= 0 (boundary solution = 0).

Action taken: Confirmed that lme4 cannot reproduce negative variance components. The bounded R fit sets this VC to 0.

Resolution: Confirmed irreducible. Root cause: SAS NOBOUND vs. lme4 non-negative VC constraint. Not reproducible in R.

## MISMATCH: Exam9.4 - NOBOUND b Block VC

Book value: 2.6751

Package value: not available in R

Diagnosis: Software limitation: The unconstrained REML b VC = 2.6751 (SAS NOBOUND) differs from the bounded lme4 result due to the correlated shift caused by the negative a VC.

Action taken: Confirmed that the overall NOBOUND parameter set is not reproducible when one VC is forced to its boundary.

Resolution: Confirmed irreducible. Root cause: SAS NOBOUND vs. lme4 non-negative VC constraint. Not reproducible in R.

## MISMATCH: Exam9.4 - NOBOUND residual variance

Book value: 17.5683

Package value: not available in R

Diagnosis: Software limitation: The unconstrained REML residual variance = 17.5683 (SAS NOBOUND) differs from the bounded lme4 result because the negative a VC absorbs variance that is redistributed to the residual in the bounded fit.

Action taken: Confirmed that the NOBOUND residual is not reproducible in lme4.

Resolution: Confirmed irreducible. Root cause: SAS NOBOUND vs. lme4 non-negative VC constraint. Not reproducible in R.

## MISMATCH: Exam10.2 - Table 10.4 and 10.5 BLUP SE values

Book value: 0.75556 naive and 0.87313 KR broad BLUP SEs; 0.55346/0.58201 narrow BLUP SEs

Package value: narrow SE=0.7383; KR overall SE=0.646

Diagnosis: MISMATCH: Book reports narrow BLUP SEs of 0.55346/0.58201 and KR broad SEs of 0.75556/0.87313 using SAS ESTIMATE with SUBJECT and the Kenward-Roger broad SE formula. lme4 ranef(condVar=TRUE) gives conditional (narrow) SEs; the KR broad SE formula is not implemented in lme4/lmerTest for the ESTIMATE-style predictable function.

Action taken: Tried lme4::ranef(condVar=TRUE) for conditional SEs and merTools::predictInterval for prediction intervals. Neither reproduces the SAS ESTIMATE KR broad SE. Retained as MISMATCH.

Resolution: Confirmed irreducible. Root cause: SAS ESTIMATE KR broad SE formula for predictable functions differs from lme4 conditional SE from ranef(condVar=TRUE).

## MISMATCH: Exam10.4 - BLUP predictable-function SE values

Book value: 1.2463, 1.7108, 0.6460, and 0.8994 as printed for selected BLUPs

Package value: a:b conditional SE=1.6188 (all equal); b SE=1.4198

Diagnosis: MISMATCH: Book reports four different BLUP predictable-function SEs (1.2463, 1.7108, 0.6460, 0.8994) computed from SAS ESTIMATE with TYPE=EBP and SUBJECT. lme4 ranef(condVar=TRUE) gives equal conditional SEs for all levels of each random effect (1.6188 for a:b, 1.4198 for b), which does not reproduce the SUBJECT-specific variation reported by SAS.

Action taken: Tried lme4::ranef(condVar=TRUE) for conditional SEs; all levels return equal values. The SUBJECT-specific SE variation from SAS ESTIMATE is not reproducible in lme4.

Resolution: Confirmed irreducible. Root cause: SAS ESTIMATE TYPE=EBP SUBJECT gives subject-specific predictable-function SEs; lme4 ranef(condVar=TRUE) gives equal conditional SEs across levels of each effect.
