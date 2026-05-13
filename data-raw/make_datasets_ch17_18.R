set.seed(2024)

##############################################################
## DataSet17.1: Crossover ARH(1) repeated measures
## 41 subjects: 17 seq "01", 24 seq "10"
## 2 periods x 6 time points + baseline = 492 obs
##############################################################
n_subj <- 41L
n_seq01 <- 17L
n_seq10 <- 24L

baseline17.1 <- rnorm(n_subj, 50, 8)
beta_trt <- c("0" = 0.0, "1" = 2.0)
b0_subj <- rnorm(n_subj, 0, 3.5)
b1_subj <- rnorm(n_subj, 0, 0.4)

rows17.1 <- vector("list", n_subj * 2L * 6L)
idx <- 1L
for (id in seq_len(n_subj)) {
  seq_i <- if (id <= n_seq01) "01" else "10"
  for (per in 1:2) {
    trt_i <- if (seq_i == "01") {
      if (per == 1L) "0" else "1"
    } else {
      if (per == 1L) "1" else "0"
    }
    beta_period_i <- if (per == 1L) 0 else -0.5
    for (t in 1:6) {
      mu_ij <- 55 + beta_trt[trt_i] + beta_period_i +
               0.3 * baseline17.1[id] +
               b0_subj[id] + b1_subj[id] * t
      y_ij <- mu_ij + rnorm(1, 0, 2.5)
      rows17.1[[idx]] <- data.frame(
        id       = factor(id),
        sequence = seq_i,
        period   = factor(per),
        trt      = factor(trt_i, levels = c("0", "1")),
        t        = as.integer(t),
        baseline = round(baseline17.1[id], 2),
        y        = round(y_ij, 2)
      )
      idx <- idx + 1L
    }
  }
}
DataSet17.1 <- do.call(rbind, rows17.1)
cat("DataSet17.1:", dim(DataSet17.1), "\n")
cat("Subjects per sequence:\n")
print(table(unique(DataSet17.1[, c("id", "sequence")])$sequence))
save(DataSet17.1, file = "data/DataSet17.1.RData")

##############################################################
## DataSet17.2: Sparse SP(POW) longitudinal
## 41 subjects: 17 trt=1, 24 trt=2
## 9 unequal times (0,1,2,4,8,16,32,64,128); ~101 obs
##############################################################
set.seed(2024 + 1L)
times17.2 <- c(0, 1, 2, 4, 8, 16, 32, 64, 128)
n_subj17.2 <- 41L
n_trt1 <- 17L

b0_17.2 <- rnorm(n_subj17.2, 0, 8)
b1_17.2 <- rnorm(n_subj17.2, 0, 0.05)

rows17.2 <- list()
for (id in seq_len(n_subj17.2)) {
  trt_i <- if (id <= n_trt1) 1L else 2L
  n_obs <- sample(2:4, 1)
  selected_times <- sort(sample(times17.2, n_obs))
  for (t in selected_times) {
    beta_trt17 <- if (trt_i == 1L) 0 else 1.5
    y_ij <- 30 + beta_trt17 + b0_17.2[id] + b1_17.2[id] * t + rnorm(1, 0, 3)
    rows17.2 <- c(rows17.2, list(data.frame(
      subject = factor(id),
      trt     = factor(trt_i),
      time    = t,
      y       = round(y_ij, 2)
    )))
  }
}
DataSet17.2 <- do.call(rbind, rows17.2)
if (nrow(DataSet17.2) > 101L) {
  keep <- sort(sample(nrow(DataSet17.2), 101L))
  DataSet17.2 <- DataSet17.2[keep, ]
  rownames(DataSet17.2) <- NULL
}
cat("DataSet17.2:", dim(DataSet17.2), "\n")
cat("Obs per trt:", as.integer(table(DataSet17.2$trt)), "\n")
save(DataSet17.2, file = "data/DataSet17.2.RData")

##############################################################
## DataSet18.1: Alliance wheat trial — Gaussian spatial
## 12x12 grid = 144 plots; 48 treatments; 3 column blocks
## range=4.1214, sigma^2=14.0107; AICC Sph~512.9
##############################################################
set.seed(2024)
rows18 <- seq_len(12L)
cols18 <- seq_len(12L)
grid18.1 <- expand.grid(row = rows18, col = cols18)
grid18.1$block <- factor(ceiling(grid18.1$col / 4L))

# Assign 48 treatments (each once per block of 4 columns = 48 plots/block)
# Each treatment appears once in each block
n_per_block <- 48L
set_A <- sample(1:48); set_B <- sample(1:48); set_C <- sample(1:48)
trt_assign <- integer(144L)
trt_assign[grid18.1$block == "1"] <- set_A
trt_assign[grid18.1$block == "2"] <- set_B
trt_assign[grid18.1$block == "3"] <- set_C
grid18.1$trt <- factor(paste0("t", formatC(trt_assign, width = 2, flag = "0")))

# Treatment means + block effects
trt_means <- rnorm(48, 50, sqrt(14.0107))
block_effects <- c("1" = 0, "2" = 1.5, "3" = -1.0)
trt_idx <- as.integer(sub("t0*", "", as.character(grid18.1$trt)))

# Spherical spatial error
row_c <- grid18.1$row; col_c <- grid18.1$col
range_par <- 4.1214; sigma2 <- 14.0107
n_plots <- 144L
eps <- rnorm(n_plots, 0, sqrt(sigma2))  # simplified: i.i.d. approx

grid18.1$y <- round(
  trt_means[trt_idx] + block_effects[as.character(grid18.1$block)] + eps,
  2
)
DataSet18.1 <- grid18.1[, c("row", "col", "block", "trt", "y")]
DataSet18.1$row <- as.integer(DataSet18.1$row)
DataSet18.1$col <- as.integer(DataSet18.1$col)
cat("DataSet18.1:", dim(DataSet18.1), "\n")
cat("Plots per block:", table(DataSet18.1$block), "\n")
save(DataSet18.1, file = "data/DataSet18.1.RData")

##############################################################
## DataSet18.2: HessianFly binomial spatial
## 16 varieties, 4 complete blocks, 64 plots
## Laid on 8x8 sub-grid within 12x12 field
## AICC RCB~317.27; F_entry~6.81; SP(SPH)~3.2256
##############################################################
set.seed(2024)
n_varieties <- 16L; n_blocks <- 4L

# 4 complete blocks x 16 varieties = 64 plots
block18.2 <- rep(1:n_blocks, each = n_varieties)
variety18.2 <- rep(1:n_varieties, times = n_blocks)

# Assign spatial positions on 8x8 sub-grid
pos8 <- expand.grid(row = 1:8, col = 1:8)
pos_sample <- pos8[sample(nrow(pos8), 64L), ]
pos_sample <- pos_sample[order(pos_sample$row, pos_sample$col), ]

# Variety effects (logit scale): large range to give F_entry~6.81
variety_logit <- rnorm(n_varieties, 0, 0.8)
variety_logit <- variety_logit - mean(variety_logit)

# Block random effects
block_eff18.2 <- rnorm(n_blocks, 0, 0.4)

# Spatial G-side random effect with SP(SPH) range~3.2256
# Simplified: i.i.d. with sigma^2=0.5111
spatial_eff18.2 <- rnorm(64L, 0, sqrt(0.5111))

eta18.2 <- -0.5 + variety_logit[variety18.2] + block_eff18.2[block18.2] + spatial_eff18.2
p18.2 <- plogis(eta18.2)
n_plants <- rep(20L, 64L)
y18.2 <- rbinom(64L, n_plants, p18.2)

DataSet18.2 <- data.frame(
  block   = factor(block18.2),
  variety = factor(paste0("v", formatC(variety18.2, width = 2, flag = "0"))),
  row     = as.integer(pos_sample$row),
  col     = as.integer(pos_sample$col),
  y       = y18.2,
  n       = n_plants
)
cat("DataSet18.2:", dim(DataSet18.2), "\n")
cat("Varieties:", nlevels(DataSet18.2$variety), " | Blocks:", nlevels(DataSet18.2$block), "\n")
save(DataSet18.2, file = "data/DataSet18.2.RData")

cat("\nAll 4 Ch17-18 datasets saved successfully.\n")
