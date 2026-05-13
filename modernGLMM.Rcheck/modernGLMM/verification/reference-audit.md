# Reference Audit

## Scope

Active package files were checked for outdated first-edition citation patterns,
legacy package identifiers, and stale generated-document references.

## Standard Reference

Stroup, W. W., Ptukhina, M., and Garai, S. (2024). *Generalized Linear Mixed
Models: Modern Concepts, Methods and Applications* (2nd ed.). CRC Press.

## Corrections

| Area | Action |
|---|---|
| DESCRIPTION | Standardized the book citation and added package-positioning text. |
| README | Rewritten around the 2024 book and the R ecosystem gap. |
| Package-level documentation | Rewritten with the standard reference and ecosystem scope. |
| Vignettes and generated articles | Rebuilt from corrected sources under `inst/doc`. |
| Citation metadata | Updated package citation title and URL. |

## Validation

Targeted recursive scans found no remaining outdated first-edition citation
patterns in active package files, and no stale legacy package identifier in
active source, vignette, README, test, documentation, or generated article paths.

## Unresolved Cases

No unresolved outdated citation pattern is intentionally retained in active package files.
