# Datasets Not Yet Available for Verification

This document describes 30 entries in `verification-results.csv` that carry
the status `UNVERIF_CONFIRMED_ABSENT_FINAL`. These are not failures: the
quantities are excluded from the pass-rate denominator because no printed
numerical target suitable for automated verification exists in the 2nd edition,
or the underlying dataset is not publicly available.

The four categories below follow the classification in `verification-results.csv`.

---

## Category A — Chapter has no exported example function (12 entries)

These chapters have no exported `Exam*` function in the package because their
examples depend exclusively on SAS-syntax illustrations, design-matrix figures,
or data distributed through the SAS Data and Program Library.

| Chapter | Entries | Note |
|---------|--------:|------|
| Ch 2, Appendix B | 7 | SAS syntax and design-matrix illustrations only; no printed fitted numerical output |
| Ch 13 | 1 | All examples use SAS Data and Program Library data; no R-implementable output |
| Ch 15 | 1 | As Ch 13 |
| Ch 16 | 1 | As Ch 13 |
| Ch 19 | 1 | Uses SAS PROC BGLIMM/PROC MCMC; no R-implementable output |
| Ch 20 | 1 | As Ch 19 |

---

## Category B — Example not present in the 2nd edition (13 entries)

These entries correspond to example numbers used in the 1st edition that do
not appear under the same identifier in the 2nd edition. The 2nd edition
reorganised several chapters with section-based numbering and updated
datasets distributed through the SAS Data and Program Library.

| Entry | Chapter | Finding |
|-------|---------|---------|
| Exam4.1 | Ch 4 | Chapter 4 is a pure-theory chapter (OLS/GLS/ML/REML derivations); no applied dataset |
| Exam5.1–5.3 | Ch 5 | Chapter 5 is a pure-theory chapter (REML/ML theory); no applied dataset |
| Exam12.1, Exam12.2 | Ch 12 | 2nd edition uses section-based numbering (§12.3.1–12.3.4); all data in SAS Data and Program Library |
| Exam14.1, Exam14.2 | Ch 14 | 2nd edition uses section-based numbering (§14.3–14.5); all data in SAS Data and Program Library |
| Exam17.1, Exam17.2 | Ch 17 | 2nd edition uses 'Example 17.3.1/17.3.2' labelling; Data Sets 17.1–17.2 in SAS Data and Program Library |
| Exam18.1, Exam18.2 | Ch 18 | 2nd edition uses section-based numbering (§18.2–18.4); all data in SAS Data and Program Library |
| Exam21.2 | Ch 21 | t-test pilot study power calculation absent from 2nd edition; Ch 21 uses GLMM-based power analysis throughout |

---

## Category C — Quantity appears in a figure only (1 entry)

| Entry | Section | Finding |
|-------|---------|---------|
| Exam8.6 | §8.6 | Response-surface fits displayed as 3-D and contour plots; no printed coefficient or fit-statistic table |

---

## Category D — Original dataset unavailable (4 entries)

| Entry | Section | Finding |
|-------|---------|---------|
| Exam11.4 | §11.5 | Synthetic split-plot count dataset (`sp_counts`) not exported and not reconstructible from printed summary statistics |

---

## Requesting the SAS Data and Program Library

Chapters 12–18 use datasets distributed in the SAS Data and Program Library
that accompanies Stroup, Ptukhina & Garai (2024). This library is not
publicly available. Researchers requiring these datasets may contact:

- **Author:** Walter W. Stroup — wstroup1@unl.edu
- **Publisher permissions:** mpkbookspermissions@tandf.co.uk

Receipt of these datasets will allow full numerical verification of Chapters
12–18 and upgrade of the corresponding entries from
`UNVERIF_CONFIRMED_ABSENT_FINAL` to `EXACT` or `APPROX`.

---

## Summary

| Category | Description | Entries |
|----------|-------------|--------:|
| A | No exported example; syntax-only or SAS-library data | 12 |
| B | Example not in 2nd edition under this identifier | 13 |
| C | Quantity in figure only; no printed value | 1 |
| D | Original dataset unavailable | 4 |
| **Total** | | **30** |
