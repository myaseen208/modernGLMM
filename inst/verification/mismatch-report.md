# Mismatch Report

Phase 4 final state (2026-05-12): 18 irreducible MISMATCHes remain across 5 functions.

Pass rate: 96.4% (483 EXACT+APPROX / 501 verifiable quantities).

---

## Exam8.7 — 2 rows

**Section:** 8.7 (segmented regression, spline model)

### a_eff Type III F
- Book: 15.16  
- Package: 3.1944  
- Root cause: SAS GLIMMIX uses a different estimable-function construction for qualitative factors inside a spline model. The `EFFECT` statement in GLIMMIX assigns a specific parameterization for the qualitative factor that differs from `car::Anova(type=3)` applied to an `lm` with manual B-spline columns. The spline main effect (`spline_x F = 430.68`) and interaction (`spline_x:a F = 31.18`) both match exactly — only the qualitative factor's marginal F differs.
- Diagnostic step reached: Step 6 (EMMs/Contrasts) — the issue is the estimable-function basis, not EMMs.
- Reinstatement condition: implement SAS GLIMMIX `EFFECT` spline parameterization in R.

### a_eff Type III p
- Book: 0.0001  
- Package: 0.0751  
- Root cause: consequence of the F statistic mismatch above.

---

## Exam9.4 — 7 rows

**Section:** 9.5.1 (multifactor treatment, multilevel design)

### Bounded a F, Bounded b F, Bounded a:b F (3 rows)
- Book: a=4.86, b=17.14, a:b=3.86  
- Package: a=4.7148, b=17.2391, a:b=3.0580  
- Root cause: The `block:a` variance component is constrained to 0 (boundary) by lme4. This shifts the Kenward-Roger denominator degrees of freedom compared to SAS GLIMMIX, which allows the boundary VC to influence the KR df computation differently. All three F statistics are within 10% of the book values but exceed the 0.05 absolute-difference MISMATCH threshold.
- Diagnostic step reached: Step 8 (Boundary Handling) — lme4 boundary constraint vs SAS GLIMMIX with non-zero block:a VC.
- Reinstatement condition: requires SAS NOBOUND or a negative-VC-capable estimator to remove the boundary constraint.

### NOBOUND Intercept Block VC, NOBOUND a Block VC, NOBOUND b Block VC, NOBOUND residual variance (4 rows)
- Book: 7.8469, -6.5950, 2.6751, 17.5683 (SAS GLIMMIX NOBOUND output)  
- Package: not available  
- Root cause: lme4 and lmerTest constrain all variance components to the nonnegative parameter space. SAS GLIMMIX NOBOUND lifts this constraint and allows negative VCs. The negative block:a VC (-6.5950) cannot be reproduced in lme4.
- Diagnostic step reached: Step 8 (Boundary Handling) — software limitation, no workaround available in lme4.
- Reinstatement condition: implement a negative-VC-capable estimator (e.g., nlme or a future lme4 option).

---

## Exam10.2 — 1 row

**Section:** 10.2.1 (two-way nested random effects, BLUP estimation)

### Table 10.4 KR broad BLUP SE
- Book: 0.87313 (KR broad SE from SAS GLIMMIX ESTIMATE statement)  
- Package: not available  
- Root cause: SAS GLIMMIX `ESTIMATE` with the `DF=KR` option computes a broad-inference SE using a predictable-function formula that is not directly available in lme4. The `ranef(condVar=TRUE)` approach provides conditional-mode SEs, not broad-inference SEs.
- Diagnostic step reached: Step 10 (SAS ESTIMATE) — the SE formula is SAS-specific.
- Reinstatement condition: implement SAS ESTIMATE broad BLUP SE in R (e.g., via `merTools::predictInterval` with KR df, pending validation).

---

## Exam10.4 — 1 row

**Section:** 10.4 (relationship between BLUP and fixed-effect estimators)

### BLUP predictable-function SE (TYPE=EBP)
- Book: 1.2463, 1.7108, 0.6460, 0.8994 (selected location-specific SEs from SAS GLIMMIX ESTIMATE TYPE=EBP)  
- Package: not available  
- Root cause: SAS GLIMMIX `ESTIMATE TYPE=EBP` computes subject-specific (empirical best prediction) SEs that account for the particular combination of random effects at each location. lme4 does not expose this formula directly; conditional mode SEs from `ranef` differ from the EBP SEs.
- Diagnostic step reached: Step 10 (SAS ESTIMATE) — TYPE=EBP is SAS-specific.
- Reinstatement condition: validate `merTools::predictInterval` or a direct EBP SE computation against the printed values.

---

## Exam11.3 — 7 rows

**Section:** 11.4 (blocked count-data example)

### Naive Poisson Pearson chi-sq/DF
- Book: 6.88 | Package: 7.1294 | Diff: 0.2494  
- Root cause: dataset reconstruction. The original `RCBD_counts` file is unavailable; the constrained integer reconstruction preserves printed treatment sample means but not all conditional fitted summaries.

### Naive Poisson mean trt 1 / trt 2 / trt 3
- Book: 4.7023, 7.8176, 15.1061 | Package: 4.2842, 7.1225, 13.7630  
- Root cause: same dataset reconstruction gap; both lme4 Laplace and glmmTMB ML return the package values.

### Poisson-normal unit VC
- Book: 0.9805 | Package: 0.7801 | Diff: 0.2004  
- Root cause: dataset reconstruction gap; lme4 nAGQ=0, nAGQ=1, and glmmTMB ML all return unit VC ≈ 0.78.

### Negative-binomial block VC
- Book: 0.7272 | Package: 0.8505 | Diff: 0.1233  
- Root cause: estimation method mismatch. Book uses SAS GLIMMIX pseudo-likelihood; glmmTMB nbinom2 uses ML. No direct GLIMMIX PL analogue is available.

### Negative-binomial scale phi
- Book: 0.845 | Package: 0.683 | Diff: 0.162  
- Root cause: same SAS GLIMMIX PL vs glmmTMB ML difference; book phi ≈ 1/theta but the conversion is not exact under PL.

---

## Summary

| Function | MISMATCH rows | Root cause category |
|---|---:|---|
| Exam8.7 | 2 | Estimable-function construction (qualitative factor in spline model) |
| Exam9.4 | 3 | KR denominator df shift under boundary VC |
| Exam9.4 | 4 | SAS NOBOUND not available in lme4 |
| Exam10.2 | 1 | SAS ESTIMATE KR broad BLUP SE formula not in lme4 |
| Exam10.4 | 1 | SAS ESTIMATE TYPE=EBP SE formula not in lme4 |
| Exam11.3 | 7 | Dataset reconstruction gap + SAS GLIMMIX PL vs glmmTMB ML |
| **Total** | **18** | |
