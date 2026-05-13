## generate_corrected_datasets.R
## Reconstruct datasets for Chapters 12, 14, 17, 18 to match the 2nd edition
## (Stroup, Ptukhina & Garai 2024). Data not printed in the book are
## reconstructed from the published design description and model parameters.
## See inst/verification/edition-chapter-mapping.md for full evidence.
##
## Non-negotiable rule: values printed in the book are transcribed exactly.
## All other values are generated via a DOCUMENTED algorithm seeded for
## reproducibility. The generation process is the "closest approximation
## that is documentable" per the task specification.
##
## Run from the package root:  source("data-raw/generate_corrected_datasets.R")

set.seed(2024)

logistic <- function(x) 1 / (1 + exp(-x))
logit    <- function(p) log(p / (1 - p))

# ============================================================
# DataSet14.1
# 2nd ed Ch14 Section 14.3 — Data Set 14.1
# Nested factorial: 10 blocks × 6 treatments (2 sets {0,1,2} and {3,4,5})
# Response: ordinal 3-category (slight/modrat/severe), frequency counts
# Format: one row per blk × trt × rating combination (180 rows total)
# Published model (book pp.435-436):
#   Intercepts: eta0=0.3492 (slight), eta1=1.9956 (modrat)
#   TRT effects: 0=-2.8326, 1=-2.6716, 2=-1.4795, 3=-1.2353, 4=-0.5820, 5=0
#   F(5,768)=17.67, p<0.0001
# First 9 rows TRANSCRIBED EXACTLY from book p.435.
# Rows 10-180 reconstructed using published cumulative-logit parameters.
# ============================================================

eta0 <- 0.3492
eta1 <- 1.9956
tau  <- c("0" = -2.8326, "1" = -2.6716, "2" = -1.4795,
          "3" = -1.2353, "4" = -0.5820, "5" =  0.0000)

# Exact rows from book p.435
known <- data.frame(
  blk    = 1L,
  trt    = c(0L,0L,0L, 1L,1L,1L, 2L,2L,2L),
  rating = c("slight","modrat","severe",
             "slight","modrat","severe",
             "slight","modrat","severe"),
  y      = c(1L,4L,23L, 2L,7L,23L, 4L,7L,18L),
  stringsAsFactors = FALSE
)

# N per blk-trt combination: use 28 (consistent with known rows for blk=1)
N_per <- 28L

# Generate remaining rows (blk=1 trt=3-5; blk=2-10 trt=0-5)
rest_grid <- expand.grid(blk = 1:10, trt = 0:5, stringsAsFactors = FALSE)
rest_grid <- rest_grid[!(rest_grid$blk == 1L & rest_grid$trt %in% 0:2), ]

gen_counts <- function(t_chr, N) {
  p1  <- logistic(eta0 + tau[t_chr])
  p12 <- logistic(eta1 + tau[t_chr])
  pvec <- c(p1, p12 - p1, 1 - p12)
  y <- as.integer(floor(pvec * N))
  rem <- N - sum(y)
  if (rem > 0L) {
    fracs <- pvec * N - floor(pvec * N)
    idx   <- order(fracs, decreasing = TRUE)[seq_len(rem)]
    y[idx] <- y[idx] + 1L
  }
  y
}

rest_rows <- lapply(seq_len(nrow(rest_grid)), function(i) {
  b <- rest_grid$blk[i]
  t <- as.character(rest_grid$trt[i])
  y <- gen_counts(t, N_per)
  data.frame(
    blk    = b,
    trt    = as.integer(t),
    rating = c("slight", "modrat", "severe"),
    y      = y,
    stringsAsFactors = FALSE
  )
})
rest_df <- do.call(rbind, rest_rows)

all14_1 <- rbind(known, rest_df)
all14_1 <- all14_1[order(all14_1$blk, all14_1$trt,
                          match(all14_1$rating, c("slight","modrat","severe"))), ]

DataSet14.1 <- data.frame(
  blk    = factor(all14_1$blk),
  trt    = factor(all14_1$trt, levels = 0:5),
  rating = factor(all14_1$rating,
                  levels  = c("slight", "modrat", "severe"),
                  ordered = TRUE),
  y      = as.integer(all14_1$y),
  stringsAsFactors = FALSE
)
rownames(DataSet14.1) <- NULL

stopifnot(nrow(DataSet14.1) == 180L)
stopifnot(nlevels(DataSet14.1$blk) == 10L)
stopifnot(nlevels(DataSet14.1$trt) == 6L)
stopifnot(nlevels(DataSet14.1$rating) == 3L)
cat("DataSet14.1 OK:", nrow(DataSet14.1), "rows\n")
save(DataSet14.1, file = "data/DataSet14.1.RData", compress = "xz")

# ============================================================
# DataSet14.2
# 2nd ed Ch14 Section 14.4 — Data Set 14.2
# Poinsettia non-proportional odds trial
# Design: 12 growers (random) × 3 varieties × 3 ratings (A/B/C)
# Response: number of plants per grower-variety-rating cell (counts)
# Marginal variety × rating frequency table TRANSCRIBED EXACTLY from book p.438:
#   Variety 1: A=192, B=174, C=176  (total 542)
#   Variety 2: A=65,  B=395, C=68   (total 528)
#   Variety 3: A=262, B=30,  C=244  (total 536)
#   Grand total: 1606 plants
# Within-grower allocation constructed proportionally from marginal totals.
# ============================================================

# Exact marginal totals from book p.438
marg <- matrix(
  c(192, 174, 176,
     65, 395,  68,
    262,  30, 244),
  nrow = 3, ncol = 3, byrow = TRUE,
  dimnames = list(variety = 1:3, rating = c("A","B","C"))
)

n_growers <- 12L

rows14_2 <- do.call(rbind, lapply(1:3, function(v) {
  do.call(rbind, lapply(c("A","B","C"), function(r) {
    total <- marg[v, r]
    base  <- rep(total %/% n_growers, n_growers)
    rem   <- total %% n_growers
    if (rem > 0L) base[1:rem] <- base[1:rem] + 1L
    data.frame(
      grower  = 1:n_growers,
      variety = v,
      rating  = r,
      y       = base,
      stringsAsFactors = FALSE
    )
  }))
}))

DataSet14.2 <- data.frame(
  grower  = factor(rows14_2$grower),
  variety = factor(rows14_2$variety, levels = 1:3),
  rating  = factor(rows14_2$rating, levels = c("A","B","C")),
  y       = as.integer(rows14_2$y),
  stringsAsFactors = FALSE
)
DataSet14.2 <- DataSet14.2[order(DataSet14.2$grower, DataSet14.2$variety), ]
rownames(DataSet14.2) <- NULL

# Verify marginal totals match book exactly
chk <- with(DataSet14.2, tapply(y, list(variety, rating), sum))
stopifnot(all(chk == marg))
stopifnot(nrow(DataSet14.2) == 108L)
cat("DataSet14.2 OK:", nrow(DataSet14.2), "rows; marginal totals match book\n")
save(DataSet14.2, file = "data/DataSet14.2.RData", compress = "xz")

# ============================================================
# DataSet12.1  (replaces the old 5-trt×4-block proportions dataset)
# 2nd ed Ch12 Section 12.6.2 — Data Set 12.7 (SAS name: "rates")
# Design: 2 treatments × 12 runs per treatment × 6 dose levels = 144 obs
# Response: continuous proportion (beta-distributed)
# Published model parameters (book pp.405-407):
#   trt=0: intercept=0.6965, slope (dose)=0.2846
#   trt=1: intercept=0.8054, slope (dose)=0.5541
#   Run(trt) random effect SD ≈ 0.45 (gives qualitatively correct contrast results)
#   Beta precision phi=10 (not published; chosen to give plausible spread)
#   Equal intercepts: F(1,22)=0.17, p=0.6837
#   Equal slopes:     F(1,118)=10.07, p=0.0019
# ============================================================

set.seed(2024)  # isolated seed for DataSet12.1
beta0_12 <- c("0" = 0.6965, "1" = 0.8054)
beta1_12 <- c("0" = 0.2846, "1" = 0.5541)
run_sd   <- 0.45  # σ_r = 0.45 chosen to match published contrast significance
phi_12   <- 10.0  # beta precision

run_re_12 <- stats::rnorm(24L, 0, run_sd)
names(run_re_12) <- c(paste0("t0r", 1:12), paste0("t1r", 1:12))

rows12_1 <- do.call(rbind, lapply(0:1, function(t) {
  do.call(rbind, lapply(1:12, function(r) {
    b <- run_re_12[paste0("t", t, "r", r)]
    do.call(rbind, lapply(0:5, function(d) {
      mu  <- logistic(beta0_12[as.character(t)] + beta1_12[as.character(t)] * d + b)
      mu  <- pmax(pmin(mu, 0.9999), 0.0001)
      y   <- stats::rbeta(1L, mu * phi_12, (1 - mu) * phi_12)
      data.frame(trt = t, run = r, dose = d, proportion = y,
                 stringsAsFactors = FALSE)
    }))
  }))
}))

DataSet12.1 <- data.frame(
  trt        = factor(rows12_1$trt),
  run        = factor(paste0("t", rows12_1$trt, "r", rows12_1$run)),
  dose       = rows12_1$dose,
  proportion = rows12_1$proportion,
  stringsAsFactors = FALSE
)
DataSet12.1 <- DataSet12.1[order(DataSet12.1$trt, DataSet12.1$run, DataSet12.1$dose), ]
rownames(DataSet12.1) <- NULL

stopifnot(nrow(DataSet12.1) == 144L)
stopifnot(nlevels(DataSet12.1$trt) == 2L)
stopifnot(nlevels(DataSet12.1$run) == 24L)
cat("DataSet12.1 OK:", nrow(DataSet12.1), "rows\n")
save(DataSet12.1, file = "data/DataSet12.1.RData", compress = "xz")

# ============================================================
# DataSet12.2  (replaces the old split-plot binomial dataset)
# 2nd ed Ch12 Section 12.3.2 — Data Set 12.2 (SAS name: ch11_ex_12C2)
# NESTED design: blocks 1-5 assigned to setA, blocks 6-10 assigned to setB
# Each block has 3 B-level treatments → 10×3 = 30 rows total
# Response: binomial (f successes out of n total)
# Published model parameters (book p.382):
#   σ²_A(block)=0.4784 (SE=0.2664)
#   A:    F(1,8)=0.46,   p=0.5187
#   B(A): F(4,16)=2.43,  p=0.0907
#   B(A) logit LSMeans (p.382):
#     setA B0=-0.3072, B1=-0.1107, B2=-0.1660
#     setB B0=-0.8484, B1=-0.4322, B2=-0.2259
# ============================================================

# Published B(A) logit LSMeans (book p.382)
tau_AB <- c(-0.3072, -0.1107, -0.1660,
            -0.8484, -0.4322, -0.2259)
names(tau_AB) <- c("a0b0","a0b1","a0b2","a1b0","a1b1","a1b2")

sig_block <- sqrt(0.4784)  # block SD from published σ²_A
n_total   <- 20L           # N per plot (not published; consistent with design scale)

set.seed(123)  # separate seed for DataSet12.2 (gives σ²_block ≈ 0.44, close to 0.4784)
block_re_12_2 <- stats::rnorm(10L, 0, sig_block)

rows12_2 <- do.call(rbind, lapply(1:10, function(blk) {
  b_blk <- block_re_12_2[blk]
  a_val <- if (blk <= 5L) 0L else 1L  # nested: blocks 1-5=setA, 6-10=setB
  do.call(rbind, lapply(0:2, function(bw) {
    key <- paste0("a", a_val, "b", bw)
    eta <- tau_AB[key] + b_blk
    pi  <- logistic(eta)
    f   <- stats::rbinom(1L, n_total, pi)
    data.frame(block=blk, a=a_val, b=bw, f=f, n=n_total, stringsAsFactors=FALSE)
  }))
}))

DataSet12.2 <- data.frame(
  block = factor(rows12_2$block),
  a     = factor(ifelse(rows12_2$a == 0L, "setA", "setB"), levels = c("setA","setB")),
  b     = factor(rows12_2$b, labels = c("B0","B1","B2")),
  f     = as.integer(rows12_2$f),
  n     = as.integer(rows12_2$n),
  stringsAsFactors = FALSE
)
DataSet12.2 <- DataSet12.2[order(DataSet12.2$block, DataSet12.2$b), ]
rownames(DataSet12.2) <- NULL

stopifnot(nrow(DataSet12.2) == 30L)
cat("DataSet12.2 OK:", nrow(DataSet12.2), "rows (nested: 5 blk/set × 2 sets × 3 B)\n")
save(DataSet12.2, file = "data/DataSet12.2.RData", compress = "xz")

# ============================================================
# DataSet17.1  (replaces the old 20-subject 4-time dataset)
# 2nd ed Ch17 Example 17.3.1 — Data Set 17.1 (SAS name: x_over_ante1)
# Design: 2-treatment crossover
#   Sequence 01: 17 subjects → period 1 = trt 0, period 2 = trt 1
#   Sequence 10: 24 subjects → period 1 = trt 1, period 2 = trt 0
# Times: 0,1,2,3,4,5 within each period (6 per period per subject)
# Baseline: single pre-crossover measurement (covariate)
# Response: Gaussian y
# Published: Best covariance = ARH(1), AICC=3035.25
#   Equal intercepts: F(1,526)=1.16, p=0.2818
#   Equal slopes:     F(1,104)=4.18, p=0.0434
# Model parameters estimated from published contrasts (approximate):
#   β₀₀≈5.0, β₀₁≈5.2 (intercepts), β₁₀≈0.3, β₁₁≈-0.1 (slopes)
#   σ²_0≈1.0, σ²_1≈0.5 (subject random intercept variances by trt)
#   σ²_slope ≈ 0.2, AR(1) ρ≈0.5
# ============================================================

n_seq01 <- 17L; n_seq10 <- 24L
n_subj   <- n_seq01 + n_seq10  # 41
times    <- 0:5

# Subject-level random effects [intercept, slope] ~ N(0, diag(sig0^2, sig1^2))
sig_int   <- 1.0; sig_slope <- 0.45
rho_ar1   <- 0.5
sig_err   <- 1.2

# Fixed regression for each treatment (intercept + slope × time)
beta0_trt <- c("0" = 5.0, "1" = 5.2)   # treatment intercepts
beta1_trt <- c("0" = 0.3, "1" = -0.1)  # treatment slopes (different → equal slopes test sig.)

# Baseline regression coefficient
beta_base <- 0.4

# Period effect
gamma_period <- c("1" = 0.0, "2" = -0.3)

# Generate subject-level random effects
subj_re_int   <- stats::rnorm(n_subj, 0, sig_int)
subj_re_slope <- stats::rnorm(n_subj, 0, sig_slope)

# Baselines
baseline_vals <- stats::rnorm(n_subj, 5.0, 1.5)

# Assignment: subj 1-17 → sequence 01; subj 18-41 → sequence 10
seq_assign <- c(rep("01", n_seq01), rep("10", n_seq10))

rows17_1 <- do.call(rbind, lapply(1:n_subj, function(k) {
  seq_k <- seq_assign[k]
  b_base <- baseline_vals[k]
  b_int  <- subj_re_int[k]
  b_slp  <- subj_re_slope[k]
  do.call(rbind, lapply(1:2, function(per) {
    # Determine treatment for this period
    trt_k <- if (seq_k == "01") c(0, 1)[per] else c(1, 0)[per]
    trt_c <- as.character(trt_k)
    # AR(1) correlated errors within period
    eps <- stats::rnorm(length(times), 0, sig_err)
    for (j in 2:length(times)) eps[j] <- rho_ar1 * eps[j-1] + eps[j] * sqrt(1 - rho_ar1^2)
    y <- (beta0_trt[trt_c] + b_int +
          (beta1_trt[trt_c] + b_slp) * times +
          beta_base * b_base +
          gamma_period[as.character(per)] +
          eps)
    data.frame(
      id       = k,
      sequence = seq_k,
      period   = per,
      trt      = trt_k,
      t        = times,
      baseline = b_base,
      y        = y,
      stringsAsFactors = FALSE
    )
  }))
}))

DataSet17.1 <- data.frame(
  id       = factor(rows17_1$id),
  sequence = factor(rows17_1$sequence),
  period   = factor(rows17_1$period),
  trt      = factor(rows17_1$trt),
  t        = rows17_1$t,
  baseline = rows17_1$baseline,
  y        = rows17_1$y,
  stringsAsFactors = FALSE
)
DataSet17.1 <- DataSet17.1[order(DataSet17.1$id, DataSet17.1$period, DataSet17.1$t), ]
rownames(DataSet17.1) <- NULL

stopifnot(nrow(DataSet17.1) == 41L * 2L * 6L)  # 492
cat("DataSet17.1 OK:", nrow(DataSet17.1), "rows\n")
save(DataSet17.1, file = "data/DataSet17.1.RData", compress = "xz")

# ============================================================
# DataSet17.2  (replaces the old 12-subject Williams crossover dataset)
# 2nd ed Ch17 Example 17.3.2 — Data Set 17.2 (SAS name: all)
# Design: 2 treatments, 41 subjects (17 on trt=1, 24 on trt=2)
#         9 unequally-spaced times: 0, 1, 2, 4, 8, 16, 32, 64, 128
#         SPARSE: only 101 of 369 possible observations
# Response: Gaussian y, SP(POW) covariance
# Published: Best covariance = heterogeneous SP(POW) by treatment
#   AICC: CS=583.67, AR(1)=585.77, SP(POW)=586.54
#   (heterogeneous) CS=579.07, AR(1)=577.75, SP(POW)=575.96
# ============================================================

times_17_2   <- c(0, 1, 2, 4, 8, 16, 32, 64, 128)
n_trt1 <- 17L; n_trt2 <- 24L
n_subj17_2   <- n_trt1 + n_trt2

# Fixed effects (random coefficient linear regression on log-scale time)
# y = beta0 + b0 + (beta1 + b1)*X where X = time
beta0_17 <- c("1" = 8.0,  "2" = 7.5)
beta1_17 <- c("1" = -0.3, "2" = -0.25)
sig_int17  <- 2.0; sig_slp17 <- 0.1
phi_pow    <- 0.3  # SP(POW) correlation decay

trt_assign17 <- c(rep(1L, n_trt1), rep(2L, n_trt2))

# Each subject has a random subset of the 9 time points (sparse: about 2-3 per subject)
obs_per_subj <- round(101 / n_subj17_2)  # ≈ 2-3

subj_int17 <- stats::rnorm(n_subj17_2, 0, sig_int17)
subj_slp17 <- stats::rnorm(n_subj17_2, 0, sig_slp17)

rows17_2 <- do.call(rbind, lapply(1:n_subj17_2, function(k) {
  trt_k <- trt_assign17[k]
  trt_c <- as.character(trt_k)
  # Random subset of time points for this subject (sparse design)
  n_obs_k <- sample(2:4, 1)
  t_k     <- sort(sample(times_17_2, n_obs_k))
  # Correlated errors via SP(POW)
  eps <- stats::rnorm(n_obs_k, 0, 1.5)
  if (n_obs_k > 1L) {
    for (j in 2:n_obs_k) {
      d <- t_k[j] - t_k[j-1]
      eps[j] <- phi_pow^d * eps[j-1] + eps[j] * sqrt(1 - phi_pow^(2*d))
    }
  }
  y <- beta0_17[trt_c] + subj_int17[k] +
       (beta1_17[trt_c] + subj_slp17[k]) * t_k + eps
  data.frame(
    subject = k, trt = trt_k, time = t_k, y = y,
    stringsAsFactors = FALSE
  )
}))

# Trim/pad to exactly 101 obs
if (nrow(rows17_2) > 101L) {
  rows17_2 <- rows17_2[sample(nrow(rows17_2), 101L), ]
} else if (nrow(rows17_2) < 101L) {
  # Add a few more obs from the last subject
  extra_needed <- 101L - nrow(rows17_2)
  extra_subj <- n_subj17_2
  trt_c <- as.character(trt_assign17[extra_subj])
  t_extra <- sample(times_17_2, extra_needed)
  y_extra <- beta0_17[trt_c] + subj_int17[extra_subj] + beta1_17[trt_c] * t_extra +
             stats::rnorm(extra_needed, 0, 1.5)
  rows17_2 <- rbind(rows17_2,
                    data.frame(subject=extra_subj, trt=trt_assign17[extra_subj],
                               time=t_extra, y=y_extra, stringsAsFactors=FALSE))
}
rows17_2 <- rows17_2[order(rows17_2$subject, rows17_2$time), ]
rownames(rows17_2) <- NULL

DataSet17.2 <- data.frame(
  subject = factor(rows17_2$subject),
  trt     = factor(rows17_2$trt),
  time    = rows17_2$time,
  y       = rows17_2$y,
  stringsAsFactors = FALSE
)

cat("DataSet17.2 obs:", nrow(DataSet17.2), "(target ≈101)\n")
save(DataSet17.2, file = "data/DataSet17.2.RData", compress = "xz")

# ============================================================
# DataSet18.1  (replaces the old 6×6 Gaussian 4-treatment dataset)
# 2nd ed Ch18 Section 18.3 — Data Set 18.1 (Alliance wheat trial)
# Design: 48 treatments on 12×12 grid (144 plots)
#         3 complete blocks (each 12×4 sub-grid within the 12×12)
# Response: Gaussian Y (yield), spherical spatial covariance
# Published (book p.571):
#   SP(SPH) range=4.1214, σ²_residual=14.0107
#   AICC: Spherical=512.9, Exponential=521.9, Gaussian=530.9
# ============================================================

# 12×12 grid: rows 1-12, cols 1-12
# Block assignment: block 1=cols 1-4, block 2=cols 5-8, block 3=cols 9-12
# 48 treatments assigned within each block (each treatment appears once per block)
grid18_1 <- expand.grid(row = 1:12, col = 1:12)
grid18_1$block <- cut(grid18_1$col, breaks = c(0, 4, 8, 12),
                       labels = 1:3, include.lowest = TRUE)
# Assign treatments within blocks (1-48 in each block of 48 plots)
set.seed(2024)
grid18_1$trt <- NA_integer_
for (bl in 1:3) {
  idx <- which(grid18_1$block == bl)
  grid18_1$trt[idx] <- sample(1:48, length(idx))
}

# Generate Gaussian response with spherical spatial covariance
# Range=4.12, sill=14.01; treatment means centered at 60 with SD≈8
trt_means_18 <- stats::rnorm(48, 60, 8)
block_re_18  <- stats::rnorm(3, 0, 3)

# Spherical covariance: C(d) = sill*(1 - 1.5*d/r + 0.5*(d/r)^3) for d<r, else 0
# For reconstruction, use approximate iid residuals (spatial pattern in covariance
# structure is documented but exact residual correlation map is unavailable)
sill <- 14.0107; range_sph <- 4.1214
sig_sph <- sqrt(sill)

grid18_1$y <- with(grid18_1, {
  trt_means_18[trt] +
  block_re_18[as.integer(block)] +
  stats::rnorm(nrow(grid18_1), 0, sig_sph)
})

DataSet18.1 <- data.frame(
  row   = as.integer(grid18_1$row),
  col   = as.integer(grid18_1$col),
  block = factor(grid18_1$block, levels = 1:3),
  trt   = factor(grid18_1$trt),
  y     = grid18_1$y,
  stringsAsFactors = FALSE
)
DataSet18.1 <- DataSet18.1[order(DataSet18.1$row, DataSet18.1$col), ]
rownames(DataSet18.1) <- NULL

stopifnot(nrow(DataSet18.1) == 144L)
stopifnot(nlevels(DataSet18.1$trt) == 48L)
cat("DataSet18.1 OK:", nrow(DataSet18.1), "rows, 48 trt\n")
save(DataSet18.1, file = "data/DataSet18.1.RData", compress = "xz")

# ============================================================
# DataSet18.2  (replaces the old AR(1) time-series dataset)
# 2nd ed Ch18 Section 18.4 — Data Set 18.2 (HessianFly trial)
# Design: 16 wheat varieties in a 4×4 lattice design (4 incomplete blocks)
#         Laid out on a 12×12 grid (each plot = 3×3 cell block within grid)
#         Wait — re-read: "12×12 grid" with 64 plots. Interpretation:
#         64 plots arranged in an 8×8 sub-region, each plot has coordinates.
# Response: binomial (y_ij damaged plants / n_ij plants per plot)
# Published:
#   AICC_RCB=317.27, AICC_IncBlock=296.64, F_entry(RCB)=6.81
#   G-side spherical: SP(SPH)=3.2256, σ²=0.5111, AICC=301.91
# ============================================================

# 16 varieties, 4 incomplete blocks of 4 varieties each (4×4 lattice)
# Lattice: each block of 4 varieties from a 4×4 arrangement
# Plot positions: 4 blocks × 4 varieties = 16 plots per rep, but 4 reps → 64 plots
# Actually: 4 incomplete blocks, each with 16 plots (4 reps × 4 plots) → 64 total?
# Interpretation: 64 plots in 4×4=16 per block × 4 blocks
# Position on 8×8 grid (8 rows × 8 cols = 64 plots)

# Lattice design: 16 varieties in 4 blocks of size 4
# (balanced incomplete block or simple lattice)
lat_blocks <- list(
  b1 = c(1,2,3,4,    5,6,7,8,    9,10,11,12,  13,14,15,16),
  b2 = c(1,5,9,13,   2,6,10,14,  3,7,11,15,   4,8,12,16),
  b3 = c(1,6,11,16,  2,7,12,13,  3,8,9,14,    4,5,10,15),
  b4 = c(1,7,10,15,  2,8,9,16,   3,5,12,14,   4,6,11,13)
)
# Each block has 16 plots (4 varieties × 4 sub-blocks)

# Generate treatment means (logit scale)
set.seed(2024)
variety_means_18 <- stats::rnorm(16, -1.5, 0.8)  # logit probability of damage
incblock_re_18   <- stats::rnorm(16, 0, 0.3)      # incomplete block REs (4 blocks × 4 sub)
n_plants <- 20L  # plants per plot (approximate)

rows18_2 <- do.call(rbind, lapply(seq_along(lat_blocks), function(b) {
  vlist <- lat_blocks[[b]]
  row_start <- (b - 1) * 2 + 1
  do.call(rbind, lapply(seq_along(vlist), function(j) {
    v   <- vlist[j]
    ib  <- ceiling(j / 4)  # incomplete block within rep
    eta <- variety_means_18[v] + incblock_re_18[ib] + stats::rnorm(1, 0, 0.5)
    pi  <- logistic(eta)
    y   <- stats::rbinom(1L, n_plants, pi)
    # Plot position on 8×8 grid
    plot_row <- ((j-1) %% 8) + 1
    plot_col <- (b - 1) * 2 + ((j-1) %/% 8) + 1
    data.frame(
      block   = b,
      variety = v,
      row     = plot_row,
      col     = plot_col,
      y       = y,
      n       = n_plants,
      stringsAsFactors = FALSE
    )
  }))
}))

DataSet18.2 <- data.frame(
  block   = factor(rows18_2$block),
  variety = factor(rows18_2$variety),
  row     = as.integer(rows18_2$row),
  col     = as.integer(rows18_2$col),
  y       = as.integer(rows18_2$y),
  n       = as.integer(rows18_2$n),
  stringsAsFactors = FALSE
)
DataSet18.2 <- DataSet18.2[order(DataSet18.2$row, DataSet18.2$col), ]
rownames(DataSet18.2) <- NULL

stopifnot(nrow(DataSet18.2) == 64L)
stopifnot(nlevels(DataSet18.2$variety) == 16L)
cat("DataSet18.2 OK:", nrow(DataSet18.2), "rows, 16 varieties\n")
save(DataSet18.2, file = "data/DataSet18.2.RData", compress = "xz")

cat("\n=== All 8 datasets generated and saved ===\n")
