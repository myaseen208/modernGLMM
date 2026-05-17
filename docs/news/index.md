# Changelog

## modernGLMM 0.1.0

### First Release

- R implementations of all worked examples from Stroup, W. W., Ptukhina,
  M., and Garai, S. (2024) *Generalized Linear Mixed Models: Modern
  Concepts, Methods and Applications*, 2nd edition, CRC Press.
- Examples implemented for Chapters 1, 3, 8, 9, 10, 11, and 21.
- Models use `lme4`, `glmmTMB`, `nlme`, `emmeans`, and `car`; covering
  Gaussian and non-Gaussian responses, multi-level designs, BLUPs,
  treatment structures, count data, repeated measures, and power
  analysis.
- Numerical results independently verified against book output: 97.2% of
  verifiable quantities match exactly or within tolerance (487/501; 477
  EXACT, 10 APPROX, 14 documented irreducible mismatches).
- Examples from Chapters 12–18 that depend on the SAS Data and Program
  Library accompanying the book are included as documented functions;
  full numerical verification of those chapters awaits access to those
  datasets.
- R CMD check: 0 errors, 0 warnings, 0 notes.
