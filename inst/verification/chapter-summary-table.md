# Chapter Summary Table

Phase 4 final state (2026-05-12): 531 total rows across all chapters.
Pass rate denominator = EXACT + APPROX + MISMATCH (verifiable quantities only).
UNVERIF_CONFIRMED_ABSENT rows document content confirmed absent from the 2nd edition PDF; they are excluded from the pass rate denominator.

| Chapter | Total | EXACT | APPROX | MISMATCH | UNVERIF_CA | Verifiable | Pass Rate |
|---|---:|---:|---:|---:|---:|---:|---|
| Ch 1 | 12 | 12 | 0 | 0 | 0 | 12 | 100.0% |
| Ch 2 | 7 | 0 | 0 | 0 | 7 | 0 | N/A |
| Ch 3 | 69 | 69 | 0 | 0 | 0 | 69 | 100.0% |
| Ch 4 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 5 | 3 | 0 | 0 | 0 | 3 | 0 | N/A |
| Ch 8 | 122 | 119 | 0 | 2 | 1 | 121 | 98.3% |
| Ch 9 | 163 | 151 | 5 | 7 | 0 | 163 | 95.7% |
| Ch 10 | 99 | 97 | 0 | 2 | 0 | 99 | 98.0% |
| Ch 11 | 29 | 15 | 3 | 7 | 4 | 25 | 72.0% |
| Ch 12 | 2 | 0 | 0 | 0 | 2 | 0 | N/A |
| Ch 13 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 14 | 2 | 0 | 0 | 0 | 2 | 0 | N/A |
| Ch 15 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 16 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 17 | 2 | 0 | 0 | 0 | 2 | 0 | N/A |
| Ch 18 | 2 | 0 | 0 | 0 | 2 | 0 | N/A |
| Ch 19 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 20 | 1 | 0 | 0 | 0 | 1 | 0 | N/A |
| Ch 21 | 13 | 12 | 0 | 0 | 1 | 12 | 100.0% |
| **TOTAL** | **531** | **475** | **8** | **18** | **30** | **501** | **96.4%** |

## Notes

- **Pass rate** = (EXACT + APPROX) / (EXACT + APPROX + MISMATCH) = 483 / 501 = 96.4%
- **UNVERIF_CONFIRMED_ABSENT (30 rows)**: content confirmed absent from the 2nd edition PDF via direct chapter reading. Excluded from pass rate denominator. See `edition-chapter-mapping.md` for content evidence.
- **MISMATCH (18 rows)**: verifiable quantities where the package value does not match the book value within tolerance. See `mismatch-report.md` for root-cause documentation.
- Chapters 2, 4, 5, 12–20 have no verifiable EXACT/APPROX quantities (all entries are UNVERIF_CONFIRMED_ABSENT).
- Chapter 11 pass rate (72.0%) reflects the dataset reconstruction gap for `DataSet11.3` (original `RCBD_counts` file unavailable).
