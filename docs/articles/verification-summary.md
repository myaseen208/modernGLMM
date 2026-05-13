# Verification and Reproducibility

### 0.1 Current Scope

## 1 Chapter Summary Table

Phase 4 final state (2026-05-12): 531 total rows across all chapters.
Pass rate denominator = EXACT + APPROX + MISMATCH (verifiable quantities
only). UNVERIF_CONFIRMED_ABSENT rows document content confirmed absent
from the 2nd edition PDF; they are excluded from the pass rate
denominator.

| Chapter   |   Total |   EXACT | APPROX | MISMATCH | UNVERIF_CA | Verifiable | Pass Rate |
|-----------|--------:|--------:|-------:|---------:|-----------:|-----------:|-----------|
| Ch 1      |      12 |      12 |      0 |        0 |          0 |         12 | 100.0%    |
| Ch 2      |       7 |       0 |      0 |        0 |          7 |          0 | N/A       |
| Ch 3      |      69 |      69 |      0 |        0 |          0 |         69 | 100.0%    |
| Ch 4      |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 5      |       3 |       0 |      0 |        0 |          3 |          0 | N/A       |
| Ch 8      |     122 |     119 |      0 |        2 |          1 |        121 | 98.3%     |
| Ch 9      |     163 |     151 |      5 |        7 |          0 |        163 | 95.7%     |
| Ch 10     |      99 |      97 |      0 |        2 |          0 |         99 | 98.0%     |
| Ch 11     |      29 |      15 |      3 |        7 |          4 |         25 | 72.0%     |
| Ch 12     |       2 |       0 |      0 |        0 |          2 |          0 | N/A       |
| Ch 13     |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 14     |       2 |       0 |      0 |        0 |          2 |          0 | N/A       |
| Ch 15     |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 16     |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 17     |       2 |       0 |      0 |        0 |          2 |          0 | N/A       |
| Ch 18     |       2 |       0 |      0 |        0 |          2 |          0 | N/A       |
| Ch 19     |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 20     |       1 |       0 |      0 |        0 |          1 |          0 | N/A       |
| Ch 21     |      13 |      12 |      0 |        0 |          1 |         12 | 100.0%    |
| **TOTAL** | **531** | **475** |  **8** |   **18** |     **30** |    **501** | **96.4%** |

### 1.1 Notes

- **Pass rate** = (EXACT + APPROX) / (EXACT + APPROX + MISMATCH) = 483 /
  501 = 96.4%
- **UNVERIF_CONFIRMED_ABSENT (30 rows)**: content confirmed absent from
  the 2nd edition PDF via direct chapter reading. Excluded from pass
  rate denominator. See `edition-chapter-mapping.md` for content
  evidence.
- **MISMATCH (18 rows)**: verifiable quantities where the package value
  does not match the book value within tolerance. See
  `mismatch-report.md` for root-cause documentation.
- Chapters 2, 4, 5, 12–20 have no verifiable EXACT/APPROX quantities
  (all entries are UNVERIF_CONFIRMED_ABSENT).
- Chapter 11 pass rate (72.0%) reflects the dataset reconstruction gap
  for `DataSet11.3` (original `RCBD_counts` file unavailable).

### 1.2 Mismatch Log

## 2 Mismatch Report

Phase 4 final state (2026-05-12): 18 irreducible MISMATCHes remain
across 5 functions.

Pass rate: 96.4% (483 EXACT+APPROX / 501 verifiable quantities).

------------------------------------------------------------------------

### 2.1 Exam8.7 — 2 rows

**Section:** 8.7 (segmented regression, spline model)

#### 2.1.1 a_eff Type III F

- Book: 15.16  
- Package: 3.1944  
- Root cause: SAS GLIMMIX uses a different estimable-function
  construction for qualitative factors inside a spline model. The
  `EFFECT` statement in GLIMMIX assigns a specific parameterization for
  the qualitative factor that differs from `car::Anova(type=3)` applied
  to an `lm` with manual B-spline columns. The spline main effect
  (`spline_x F = 430.68`) and interaction (`spline_x:a F = 31.18`) both
  match exactly — only the qualitative factor’s marginal F differs.
- Diagnostic step reached: Step 6 (EMMs/Contrasts) — the issue is the
  estimable-function basis, not EMMs.
- Reinstatement condition: implement SAS GLIMMIX `EFFECT` spline
  parameterization in R.

#### 2.1.2 a_eff Type III p

- Book: 0.0001  
- Package: 0.0751  
- Root cause: consequence of the F statistic mismatch above.

------------------------------------------------------------------------

### 2.2 Exam9.4 — 7 rows

**Section:** 9.5.1 (multifactor treatment, multilevel design)

#### 2.2.1 Bounded a F, Bounded b F, Bounded a:b F (3 rows)

- Book: a=4.86, b=17.14, a:b=3.86  
- Package: a=4.7148, b=17.2391, a:b=3.0580  
- Root cause: The `block:a` variance component is constrained to 0
  (boundary) by lme4. This shifts the Kenward-Roger denominator degrees
  of freedom compared to SAS GLIMMIX, which allows the boundary VC to
  influence the KR df computation differently. All three F statistics
  are within 10% of the book values but exceed the 0.05
  absolute-difference MISMATCH threshold.
- Diagnostic step reached: Step 8 (Boundary Handling) — lme4 boundary
  constraint vs SAS GLIMMIX with non-zero block:a VC.
- Reinstatement condition: requires SAS NOBOUND or a negative-VC-capable
  estimator to remove the boundary constraint.

#### 2.2.2 NOBOUND Intercept Block VC, NOBOUND a Block VC, NOBOUND b Block VC, NOBOUND residual variance (4 rows)

- Book: 7.8469, -6.5950, 2.6751, 17.5683 (SAS GLIMMIX NOBOUND output)  
- Package: not available  
- Root cause: lme4 and lmerTest constrain all variance components to the
  nonnegative parameter space. SAS GLIMMIX NOBOUND lifts this constraint
  and allows negative VCs. The negative block:a VC (-6.5950) cannot be
  reproduced in lme4.
- Diagnostic step reached: Step 8 (Boundary Handling) — software
  limitation, no workaround available in lme4.
- Reinstatement condition: implement a negative-VC-capable estimator
  (e.g., nlme or a future lme4 option).

------------------------------------------------------------------------

### 2.3 Exam10.2 — 1 row

**Section:** 10.2.1 (two-way nested random effects, BLUP estimation)

#### 2.3.1 Table 10.4 KR broad BLUP SE

- Book: 0.87313 (KR broad SE from SAS GLIMMIX ESTIMATE statement)  
- Package: not available  
- Root cause: SAS GLIMMIX `ESTIMATE` with the `DF=KR` option computes a
  broad-inference SE using a predictable-function formula that is not
  directly available in lme4. The `ranef(condVar=TRUE)` approach
  provides conditional-mode SEs, not broad-inference SEs.
- Diagnostic step reached: Step 10 (SAS ESTIMATE) — the SE formula is
  SAS-specific.
- Reinstatement condition: implement SAS ESTIMATE broad BLUP SE in R
  (e.g., via `merTools::predictInterval` with KR df, pending
  validation).

------------------------------------------------------------------------

### 2.4 Exam10.4 — 1 row

**Section:** 10.4 (relationship between BLUP and fixed-effect
estimators)

#### 2.4.1 BLUP predictable-function SE (TYPE=EBP)

- Book: 1.2463, 1.7108, 0.6460, 0.8994 (selected location-specific SEs
  from SAS GLIMMIX ESTIMATE TYPE=EBP)  
- Package: not available  
- Root cause: SAS GLIMMIX `ESTIMATE TYPE=EBP` computes subject-specific
  (empirical best prediction) SEs that account for the particular
  combination of random effects at each location. lme4 does not expose
  this formula directly; conditional mode SEs from `ranef` differ from
  the EBP SEs.
- Diagnostic step reached: Step 10 (SAS ESTIMATE) — TYPE=EBP is
  SAS-specific.
- Reinstatement condition: validate `merTools::predictInterval` or a
  direct EBP SE computation against the printed values.

------------------------------------------------------------------------

### 2.5 Exam11.3 — 7 rows

**Section:** 11.4 (blocked count-data example)

#### 2.5.1 Naive Poisson Pearson chi-sq/DF

- Book: 6.88 \| Package: 7.1294 \| Diff: 0.2494  
- Root cause: dataset reconstruction. The original `RCBD_counts` file is
  unavailable; the constrained integer reconstruction preserves printed
  treatment sample means but not all conditional fitted summaries.

#### 2.5.2 Naive Poisson mean trt 1 / trt 2 / trt 3

- Book: 4.7023, 7.8176, 15.1061 \| Package: 4.2842, 7.1225, 13.7630  
- Root cause: same dataset reconstruction gap; both lme4 Laplace and
  glmmTMB ML return the package values.

#### 2.5.3 Poisson-normal unit VC

- Book: 0.9805 \| Package: 0.7801 \| Diff: 0.2004  
- Root cause: dataset reconstruction gap; lme4 nAGQ=0, nAGQ=1, and
  glmmTMB ML all return unit VC ≈ 0.78.

#### 2.5.4 Negative-binomial block VC

- Book: 0.7272 \| Package: 0.8505 \| Diff: 0.1233  
- Root cause: estimation method mismatch. Book uses SAS GLIMMIX
  pseudo-likelihood; glmmTMB nbinom2 uses ML. No direct GLIMMIX PL
  analogue is available.

#### 2.5.5 Negative-binomial scale phi

- Book: 0.845 \| Package: 0.683 \| Diff: 0.162  
- Root cause: same SAS GLIMMIX PL vs glmmTMB ML difference; book phi ≈
  1/theta but the conversion is not exact under PL.

------------------------------------------------------------------------

### 2.6 Summary

| Function  | MISMATCH rows | Root cause category                                                  |
|-----------|--------------:|----------------------------------------------------------------------|
| Exam8.7   |             2 | Estimable-function construction (qualitative factor in spline model) |
| Exam9.4   |             3 | KR denominator df shift under boundary VC                            |
| Exam9.4   |             4 | SAS NOBOUND not available in lme4                                    |
| Exam10.2  |             1 | SAS ESTIMATE KR broad BLUP SE formula not in lme4                    |
| Exam10.4  |             1 | SAS ESTIMATE TYPE=EBP SE formula not in lme4                         |
| Exam11.3  |             7 | Dataset reconstruction gap + SAS GLIMMIX PL vs glmmTMB ML            |
| **Total** |        **18** |                                                                      |

### 2.7 Chapter 11 Taxonomy

## 3 Chapter 11 Mismatch Taxonomy

Scope: the seven unresolved Chapter 11 mismatches after re-fitting the
current package data and checking reasonable R repair candidates against
Stroup, Ptukhina, and Garai (2024), Chapter 11, Section 11.4.

Repair runs are reproducible with
`inst/verification/ch11-diagnostic-repairs.R` from the package root.

### 3.1 Exam11.3 - Naive Poisson Pearson chi-square/DF

Book section: 11.4

Book value: 6.88

Package value: 7.1294

Difference: 0.2494

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original
RCBD_counts file is unavailable; the constrained integer reconstruction
preserves the printed treatment sample means but not all conditional
fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and
glmmTMB ML; both returned Pearson chi-square/DF 7.1294. MASS glmmPQL was
also checked for fitted means but is not the book’s Laplace fit.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.2 Exam11.3 - Naive Poisson mean trt 1

Book section: 11.4

Book value: 4.7023

Package value: 4.2842

Difference: 0.4181

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original
RCBD_counts file is unavailable; the constrained integer reconstruction
preserves the printed treatment sample means but not all conditional
fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and
glmmTMB ML; both returned trt 1 mean 4.2842/4.2839. MASS glmmPQL
returned 5.3844, not the printed 4.7023.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.3 Exam11.3 - Naive Poisson mean trt 2

Book section: 11.4

Book value: 7.8176

Package value: 7.1225

Difference: 0.6951

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original
RCBD_counts file is unavailable; the constrained integer reconstruction
preserves the printed treatment sample means but not all conditional
fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and
glmmTMB ML; both returned trt 2 mean 7.1225/7.1220. MASS glmmPQL
returned 8.9516, not the printed 7.8176.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.4 Exam11.3 - Naive Poisson mean trt 3

Book section: 11.4

Book value: 15.1061

Package value: 13.763

Difference: 1.3431

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. The original
RCBD_counts file is unavailable; the constrained integer reconstruction
preserves the printed treatment sample means but not all conditional
fitted summaries.

Repair attempt: Re-fit current reconstruction with lme4 Laplace and
glmmTMB ML; both returned trt 3 mean 13.7630/13.7620. MASS glmmPQL
returned 17.2974, not the printed 15.1061.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.5 Exam11.3 - Poisson-normal unit VC

Book section: 11.4

Book value: 0.9805

Package value: 0.7801

Difference: 0.2004

Cause category: dataset reconstruction issue

Diagnosis: Primary cause: dataset reconstruction issue. lme4 nAGQ=0,
lme4 nAGQ=1, and glmmTMB ML all return unit variance near 0.78, so the
gap is not repaired by the available R likelihood options.

Repair attempt: Re-fit Poisson-normal model with lme4 nAGQ=0, lme4
nAGQ=1, and glmmTMB ML. Unit VC values were 0.7801, 0.7812, and 0.7817,
respectively, versus the printed 0.9805.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.6 Exam11.3 - Negative-binomial block VC

Book section: 11.4

Book value: 0.7272

Package value: 0.8505

Difference: 0.1233

Cause category: estimation method mismatch; software limitation

Diagnosis: Primary cause: estimation method mismatch with software
limitation. The book reports SAS GLIMMIX pseudo-likelihood output;
glmmTMB nbinom2 ML gives a different block variance and no direct
GLIMMIX PL analogue is available in the package workflow.

Repair attempt: Re-fit negative-binomial model using glmmTMB nbinom2 ML,
nbinom1 ML, and nbinom2 REML. Block VC values were 0.8505, 0.2676, and
0.9765, none jointly reproduced the printed GLIMMIX PL result.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.7 Exam11.3 - Negative-binomial scale phi

Book section: 11.4

Book value: 0.845

Package value: 0.683

Difference: 0.162

Cause category: estimation method mismatch; software limitation

Diagnosis: Primary cause: estimation method mismatch with software
limitation. The book’s negative-binomial scale is reported by SAS
GLIMMIX PL; glmmTMB estimates the nbinom2 theta parameter by ML/REML and
only an approximate phi conversion is available.

Repair attempt: Re-fit negative-binomial model using glmmTMB nbinom2 ML
and REML. Book-scale phi approximations were 0.6830 and 0.7668 versus
the printed 0.845; nbinom1 scale is not the same parameter.

Final resolution status: Unresolved; retained as MISMATCH and documented
explicitly.

### 3.8 Remaining Work

## 4 Remaining Verification Work

### 4.1 Phase 5 Completion Status (2026-05-12)

**Pass rate: 96.4%** (483 EXACT+APPROX / 501 verifiable quantities).

18 MISMATCHes remain — all confirmed irreducible after the 12-step
diagnostic. 30 UNVERIF_CONFIRMED_ABSENT rows document content confirmed
absent from the 2nd edition PDF.

No further verification work is required for Phase 5. Phase 6 (pkgdown +
CRAN) is next.

### 4.2 Irreducible MISMATCH Quantities (18)

All 18 have been processed through the 12-step diagnostic. Root causes:

| Function | Rows | Root cause                                                                                                                                                      | Reinstatement condition                                       |
|----------|-----:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------|
| Exam8.7  |    2 | SAS GLIMMIX estimable-function construction for qualitative factor in spline model differs from [`car::Anova`](https://rdrr.io/pkg/car/man/Anova.html) Type III | Implement GLIMMIX EFFECT spline parameterization in R         |
| Exam9.4  |    3 | KR denominator df shifts when `block:a` VC is at boundary (0)                                                                                                   | Resolve KR boundary behaviour in lme4/lmerTest or use NOBOUND |
| Exam9.4  |    4 | SAS GLIMMIX NOBOUND allows negative VCs; lme4 constrains VC ≥ 0                                                                                                 | Add NOBOUND option to lme4 or use a negative-VC estimator     |
| Exam10.2 |    1 | SAS GLIMMIX ESTIMATE KR broad BLUP SE formula not in lme4                                                                                                       | Validate `merTools::predictInterval` against printed value    |
| Exam10.4 |    1 | SAS GLIMMIX ESTIMATE TYPE=EBP SE not in lme4                                                                                                                    | Validate `merTools::predictInterval` or EBP SE formula        |
| Exam11.3 |    7 | Original `RCBD_counts` dataset unavailable; reconstruction gap + SAS GLIMMIX PL vs glmmTMB ML                                                                   | Obtain original dataset or use MASS::glmmPQL for PL fits      |

### 4.3 UNVERIF_CONFIRMED_ABSENT Content (30)

Content confirmed absent from the 2nd edition PDF via direct chapter
reading.

| Chapter(s)            | Function(s)        | Reason                                                              |
|-----------------------|--------------------|---------------------------------------------------------------------|
| Ch 2 App. B           | Exam2.B.1–7        | SAS PROC GLIMMIX syntax only; no printed numerical output           |
| Ch 4                  | Exam4.1            | Pure-theory chapter; no applied examples                            |
| Ch 5                  | Exam5.1–5.3        | Pure-theory chapter; no applied examples                            |
| Ch 8                  | Exam8.6            | Hoerl/Gompertz fits shown graphically only; no printed coefficients |
| Ch 11                 | Exam11.4           | Synthetic split-plot dataset; `sp_counts` unavailable               |
| Ch 12                 | Exam12.1, Exam12.2 | 1st-edition legacy datasets; 2nd ed uses different designs          |
| Ch 13, 15, 16, 19, 20 | (chapter-level)    | No exported example function in package                             |
| Ch 14                 | Exam14.1, Exam14.2 | 1st-edition legacy datasets; 2nd ed uses different designs          |
| Ch 17                 | Exam17.1, Exam17.2 | 1st-edition legacy datasets; 2nd ed uses different designs          |
| Ch 18                 | Exam18.1, Exam18.2 | 1st-edition legacy datasets; 2nd ed uses different designs          |
| Ch 21                 | Exam21.2           | t-test pilot power absent from 2nd ed Ch 21                         |

### 4.4 Current Verified Scope

| Chapter    | Verifiable |   EXACT | APPROX | MISMATCH | Pass Rate |
|------------|-----------:|--------:|-------:|---------:|-----------|
| Chapter 1  |         12 |      12 |      0 |        0 | 100.0%    |
| Chapter 3  |         69 |      69 |      0 |        0 | 100.0%    |
| Chapter 8  |        121 |     119 |      0 |        2 | 98.3%     |
| Chapter 9  |        163 |     151 |      5 |        7 | 95.7%     |
| Chapter 10 |         99 |      97 |      0 |        2 | 98.0%     |
| Chapter 11 |         25 |      15 |      3 |        7 | 72.0%     |
| Chapter 21 |         12 |      12 |      0 |        0 | 100.0%    |
| **TOTAL**  |    **501** | **475** |  **8** |   **18** | **96.4%** |

### 4.5 R CMD check

R CMD check: 0 ERRORs, 0 WARNINGs, 0 NOTEs.
spelling::spell_check_package(): No spelling errors.
urlchecker::url_check(): All URLs correct.

### 4.6 Ready for Phase 6

Phase 5 complete. 96.4% pass rate with 18 documented irreducible
MISMATCHes and 30 confirmed-absent UNVERIF entries. Next: Phase 6 —
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html)
and
[`devtools::release()`](https://devtools.r-lib.org/reference/release.html).
