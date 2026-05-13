# Chapter 15-21 Verification Classification

Updated 2026-05-12 after dataset reconstruction (Phase 3b).

Chapters 15, 16, 19, 20 have no exported Exam* or DataSet* objects.
Chapters 17 and 18 have been reconstructed from published design descriptions.
Chapter 21 was verified in Phase 3a.

| Example | Chapter | Book Section | Output Type | Book Value | Package Value | Difference | Status | Diagnosis |
|---|---|---|---|---|---|---|---|---|
| Chapter15 | 15 | package inventory | No exported Exam function | not applicable | no Exam15.* object present | N/A | UNVERIF | No exported Chapter 15 example function or dataset present. |
| Chapter16 | 16 | package inventory | No exported Exam function | not applicable | no Exam16.* object present | N/A | UNVERIF | No exported Chapter 16 example function or dataset present. |
| Exam17.1 equal intercepts | 17 | Sec 17.3.1, p.516 | F-test equal intercepts | F(1,526)=1.16, p=0.2818 | t(447)=1.051, p=0.294 | |Δp|=0.012 | APPROX | nlme ARH(1) on synthetic data; both non-significant |
| Exam17.1 equal slopes sig | 17 | Sec 17.3.1, p.516 | F-test equal slopes | F(1,104)=4.18, p=0.0434 | t(447)=5.616, p<0.0001 | same direction (sig) | APPROX | Both significant; slope difference is stronger in synthetic data |
| Exam17.1 AICC ARH(1) | 17 | Sec 17.3.1, p.516 | AICC best model | ARH(1)=3035.25 | AIC(ARH1)=1595 | not comparable | UNVERIF | Synthetic data; different N and absolute AICC not comparable across datasets |
| Exam17.1 model ranking | 17 | Sec 17.3.1, p.516 | AICC ranking CS > AR(1) > ARH(1) | CS > AR(1) > ARH(1) | CS > ARH(1) > AR(1) | partial mismatch | APPROX | CS worst in both; AR(1)/ARH(1) ranking swapped on synthetic data |
| Exam17.2 SP(POW) vs CS | 17 | Sec 17.3.2, p.517 | AICC comparison | SP(POW)=575.96 < CS=583.67 | SP(POW) AIC < CS AIC | direction correct | APPROX | SP(POW) preferred over CS in both; exact AICC not comparable |
| Exam17.2 AICC values | 17 | Sec 17.3.2, p.517 | AICC CS, AR(1), SP(POW) | CS=583.67, AR=585.77, SP=575.96 | not comparable | N/A | UNVERIF | Synthetic sparse data; absolute AICC not reproducible |
| Exam18.1 RCB vs spatial | 18 | Sec 18.3, pp.569-571 | AICC: RCB > spatial | RCB=597.9 > SPH=512.9 | RCB AIC=836.7 > SPH AIC=683.0 | direction correct | APPROX | RCB worst in both; exact AICC not comparable (synthetic data) |
| Exam18.1 SPH range | 18 | Sec 18.3, p.571 | SP(SPH) range parameter | 4.1214 | ~1.0 (at boundary) | 3.12 | MISMATCH | Synthetic data has no spatial autocorrelation; range cannot be estimated |
| Exam18.1 AICC Spherical | 18 | Sec 18.3, p.571 | AICC SP(SPH) | 512.9 | 683.0 (AIC) | not comparable | UNVERIF | Different sample, no spatial structure in synthetic data |
| Exam18.2 variety F-test | 18 | Sec 18.4, pp.573-579 | F_entry variety (RCB) | F=6.81, p<0.001 | χ²(15)=59.53/15≈3.97, p<0.001 | both sig | APPROX | car::Anova Type III; both indicate variety significant |
| Exam18.2 RCB AICC | 18 | Sec 18.4, p.573 | AICC RCB | 317.27 | AIC=250.97 | not comparable | UNVERIF | Different N and design; absolute AICC not comparable |
| Chapter19 | 19 | package inventory | No exported Exam function | not applicable | no Exam19.* object present | N/A | UNVERIF | No exported Chapter 19 example function or dataset present. |
| Chapter20 | 20 | package inventory | No exported Exam function | not applicable | no Exam20.* object present | N/A | UNVERIF | No exported Chapter 20 example function or dataset present. |
| Exam21.1 — 12 quantities | 21 | Sec 21.1.1 | Power/sample size | 12 EXACT quantities | 12 EXACT quantities | 0 | EXACT | Non-central F power verified against book Example 21.1.1 |
| Exam21.2 | 21 | absent from 2024 2nd ed | Legacy example | not in 2nd edition | legacy topic retained | N/A | UNVERIF | t-test pilot study content absent from 2024 2nd ed Ch21 |
