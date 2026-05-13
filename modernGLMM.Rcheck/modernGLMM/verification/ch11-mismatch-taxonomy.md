# Chapter 11 Mismatch Taxonomy

Scope: the seven unresolved Chapter 11 mismatches after re-fitting the current package data and checking reasonable R repair candidates against Stroup, Ptukhina, and Garai (2024), Chapter 11, Section 11.4.

Repair runs are reproducible with `inst/verification/ch11-diagnostic-repairs.R` from the package root.

## Exam11.3 - Naive Poisson Pearson chi-square/DF

Book section: 11.4

Book value: 6.88

Package value: 7.1294

Difference: 0.2494

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned Pearson chi-square/DF 7.1294. MASS glmmPQL was also checked for fitted means but is not the book's Laplace fit.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Naive Poisson mean trt 1

Book section: 11.4

Book value: 4.7023

Package value: 4.2842

Difference: 0.4181

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 1 mean 4.2842/4.2839. MASS glmmPQL returned 5.3844, not the printed 4.7023.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Naive Poisson mean trt 2

Book section: 11.4

Book value: 7.8176

Package value: 7.1225

Difference: 0.6951

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 2 mean 7.1225/7.1220. MASS glmmPQL returned 8.9516, not the printed 7.8176.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Naive Poisson mean trt 3

Book section: 11.4

Book value: 15.1061

Package value: 13.763

Difference: 1.3431

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original RCBD_counts file is unavailable; the constrained integer reconstruction preserves the printed treatment sample means but not all conditional fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and glmmTMB ML; both returned trt 3 mean 13.7630/13.7620. MASS glmmPQL returned 17.2974, not the printed 15.1061.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Poisson-normal unit VC

Book section: 11.4

Book value: 0.9805

Package value: 0.7801

Difference: 0.2004

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. lme4 nAGQ=0, lme4 nAGQ=1, and glmmTMB ML all return unit variance near 0.78, so the gap is not repaired by the available R likelihood options.

Repair attempt: Re-fit Poisson-normal model with lme4 nAGQ=0, lme4 nAGQ=1, and glmmTMB ML. Unit VC values were 0.7801, 0.7812, and 0.7817, respectively, versus the printed 0.9805.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Negative-binomial block VC

Book section: 11.4

Book value: 0.7272

Package value: 0.8505

Difference: 0.1233

Cause category: estimation method mismatch; software limitation

Diagnosis: Primary cause: estimation method mismatch with software limitation. The book reports SAS GLIMMIX pseudo-likelihood output; glmmTMB nbinom2 ML gives a different block variance and no direct GLIMMIX PL analogue is available in the package workflow.

Repair attempt: Re-fit negative-binomial model using glmmTMB nbinom2 ML, nbinom1 ML, and nbinom2 REML. Block VC values were 0.8505, 0.2676, and 0.9765, none jointly reproduced the printed GLIMMIX PL result.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

## Exam11.3 - Negative-binomial scale phi

Book section: 11.4

Book value: 0.845

Package value: 0.683

Difference: 0.162

Cause category: estimation method mismatch; software limitation

Diagnosis: Primary cause: estimation method mismatch with software limitation. The book's negative-binomial scale is reported by SAS GLIMMIX PL; glmmTMB estimates the nbinom2 theta parameter by ML/REML and only an approximate phi conversion is available.

Repair attempt: Re-fit negative-binomial model using glmmTMB nbinom2 ML and REML. Book-scale phi approximations were 0.6830 and 0.7668 versus the printed 0.845; nbinom1 scale is not the same parameter.

Final resolution status: Unresolved; retained as MISMATCH and documented explicitly.

