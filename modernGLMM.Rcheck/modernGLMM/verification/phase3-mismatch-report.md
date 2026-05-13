# Phase 3 Mismatch Report

## MISMATCH: Exam11.3 - Naive Poisson Pearson Chi-square/DF

Book value: 6.88

Package value: 7.1294

Difference: 0.2494

Diagnosis: `DataSet11.3` was reconstructed from printed summaries because the
original SAS data file was not available. The treatment sample means match
exactly, but the complete block-level count pattern is not uniquely determined
by the printed output.

Resolution: Unresolved. Documented in `DataSet11.3` provenance.

## MISMATCH: Exam11.3 - Naive Poisson Fitted Means

Book values: 4.7023, 7.8176, 15.1061

Package values: 4.2842, 7.1225, 13.7630

Diagnosis: Same source as above. The constrained reconstruction matches the
marginal treatment means but does not fully recover the SAS conditional fitted
means.

Resolution: Unresolved. Retained because the raw data are unavailable.

## MISMATCH: Exam11.3 - Poisson-normal Unit Variance

Book value: 0.9805

Package value: 0.7801

Difference: 0.2004

Diagnosis: The reconstructed block-by-treatment pattern and R likelihood
approximation differ from SAS PROC GLIMMIX pseudo-likelihood output.

Resolution: Unresolved. Documented as an approximate reconstruction.

## MISMATCH: Exam11.3 - Negative-binomial Variance and Scale

Book values: block variance 0.7272, scale 0.8450

Package values: block variance 0.8505, scale 0.6830

Diagnosis: The raw data were unavailable, and `glmmTMB::nbinom2()` reports the
negative-binomial dispersion through a different parameterization than SAS
PROC GLIMMIX. The report converts the dispersion as `phi = 1 / sigma(model)`.

Resolution: Unresolved. Documented in `DataSet11.3` provenance and example
notes.
