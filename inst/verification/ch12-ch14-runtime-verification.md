# Chapter 12-14 Verification Classification

Updated 2026-05-12 after dataset reconstruction (Phase 3b).

Datasets for all four examples were rebuilt from published design descriptions and
model parameters in Stroup, Ptukhina & Garai (2024) 2nd ed.  Exact book rows were
transcribed where available; remaining rows were generated deterministically or
via seeded random draws from the published parameter values.

| Example | Chapter | Book Section | Output Type | Book Value | Package Value | Difference | Status | Diagnosis |
|---|---|---|---|---|---|---|---|---|
| Exam12.1 intercepts non-sig | 12 | Sec 12.6.2, p.406 | Beta GLMM equal-intercepts contrast | F(1,22)=0.17, p=0.6837 | z=0.52, p≈0.60 | z vs F, |Δp|=0.08 | APPROX | Fixed-effects GLMM vs GLIMMIX RSPL; direction correct (non-significant) |
| Exam12.1 slopes sig | 12 | Sec 12.6.2, p.406 | Beta GLMM equal-slopes contrast | F(1,118)=10.07, p=0.0019 | z≈2.8, p≈0.005 | direction correct | APPROX | Both significant; exact F/z differ due to pseudo-likelihood vs Laplace |
| Exam12.1 trt0 intercept | 12 | Sec 12.6.2, p.406 | Fixed effect β₀ (trt=0) | 0.6965 | ~0.45 | 0.25 | APPROX | Reconstructed data; correct ordering trt1 > trt0 |
| Exam12.1 trt1 intercept | 12 | Sec 12.6.2, p.406 | Fixed effect β₀ (trt=1) | 0.8054 | ~0.58 | 0.22 | APPROX | Reconstructed data; correct ordering trt1 > trt0 |
| DataSet12.1 block variance | 12 | Sec 12.6.2, p.406 | σ²_run (run RE) | N/A (σ_r≈0.45 used) | ~0.2 | N/A | APPROX | σ_r=0.45 generation SD; estimated VC depends on fit |
| Exam12.2 block variance | 12 | Sec 12.3.2, p.382 | σ²_block | 0.4784 (SE=0.2664) | ~0.44 | 0.04 | APPROX | seed=123 reconstruction; |Δσ²|<0.05 tolerance |
| Exam12.2 A F-test | 12 | Sec 12.3.2, p.382 | F(1,8) for set A | F(1,8)=0.46, p=0.5187 | non-significant (approx) | direction correct | APPROX | Nested design 5 blk/set; direction correct |
| Exam12.2 B(A) F-test | 12 | Sec 12.3.2, p.382 | F(4,16) for B(A) | F(4,16)=2.43, p=0.0907 | non-significant (approx) | direction correct | APPROX | Nested design 5 blk/set; B(A) marginally non-significant in both |
| DataSet14.1 blk1 trt0 y | 14 | Sec 14.3, p.435 | Exact count (slight) | 1 | 1 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt0 modrat | 14 | Sec 14.3, p.435 | Exact count (modrat) | 4 | 4 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt0 severe | 14 | Sec 14.3, p.435 | Exact count (severe) | 23 | 23 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt1 slight | 14 | Sec 14.3, p.435 | Exact count (slight) | 2 | 2 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt1 modrat | 14 | Sec 14.3, p.435 | Exact count (modrat) | 7 | 7 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt1 severe | 14 | Sec 14.3, p.435 | Exact count (severe) | 23 | 23 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt2 slight | 14 | Sec 14.3, p.435 | Exact count (slight) | 4 | 4 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt2 modrat | 14 | Sec 14.3, p.435 | Exact count (modrat) | 7 | 7 | 0 | EXACT | Transcribed from book Table, p.435 |
| DataSet14.1 blk1 trt2 severe | 14 | Sec 14.3, p.435 | Exact count (severe) | 18 | 18 | 0 | EXACT | Transcribed from book Table, p.435 |
| Exam14.1 intercept η̂₀ (adj) | 14 | Sec 14.3, p.436 | Cumul. logit boundary (slight) | 0.3492 | ~0.44 (θ₁-β₅≈-2.626-(-3.066)) | 0.09 | APPROX | polr reference is trt0 not trt5; adjusted θ₁-β₅ ≈ book η̂₀ |
| Exam14.1 intercept η̂₁ (adj) | 14 | Sec 14.3, p.436 | Cumul. logit boundary (modrat) | 1.9956 | ~2.10 (θ₂-β₅≈-0.969-(-3.066)) | 0.10 | APPROX | polr reference is trt0 not trt5; adjusted θ₂-β₅ ≈ book η̂₁ |
| Exam14.1 trt F-test | 14 | Sec 14.3, p.436 | Treatment effect significance | F(5,768)=17.67, p<0.0001 | LR χ²(5)=480.4, p<0.0001 | both p<0.0001 | APPROX | polr LR vs GLMM F; same conclusion (highly significant) |
| DataSet14.2 var1 rating-A | 14 | Sec 14.4, p.438 | Marginal count (var1, A) | 192 | 192 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var1 rating-B | 14 | Sec 14.4, p.438 | Marginal count (var1, B) | 174 | 174 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var1 rating-C | 14 | Sec 14.4, p.438 | Marginal count (var1, C) | 176 | 176 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var2 rating-A | 14 | Sec 14.4, p.438 | Marginal count (var2, A) | 65 | 65 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var2 rating-B | 14 | Sec 14.4, p.438 | Marginal count (var2, B) | 395 | 395 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var2 rating-C | 14 | Sec 14.4, p.438 | Marginal count (var2, C) | 68 | 68 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var3 rating-A | 14 | Sec 14.4, p.438 | Marginal count (var3, A) | 262 | 262 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var3 rating-B | 14 | Sec 14.4, p.438 | Marginal count (var3, B) | 30 | 30 | 0 | EXACT | Transcribed from book Table, p.438 |
| DataSet14.2 var3 rating-C | 14 | Sec 14.4, p.438 | Marginal count (var3, C) | 244 | 244 | 0 | EXACT | Transcribed from book Table, p.438 |
| Exam14.2 PO variety test | 14 | Sec 14.4, p.442 | Variety under PO model | F(2,?)≈0.02, p≈0.98 | LR χ²(2)=1.10, p=0.576 | both non-significant | APPROX | polr vs GLMM; both indicate PO variety non-significant |
| Exam14.2 non-PO analysis | 14 | Sec 14.4, p.442 | Variety under non-PO model | F(4,8)=69.65, p<0.0001 | UNVERIF (GLMM not available) | N/A | UNVERIF | Full non-PO GLMM requires glmmTMB cumulative (not in glmmTMB 1.1.14) |
