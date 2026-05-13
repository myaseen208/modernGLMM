normalize_source <- function(path) {
  x <- utils::read.csv(path, check.names = FALSE, stringsAsFactors = FALSE)
  names(x)[names(x) == "Ch"] <- "Chapter"
  names(x)[names(x) == "Book_Section"] <- "Book Section"
  names(x)[names(x) == "Output_Type"] <- "Output Type"
  names(x)[names(x) == "Book_Value"] <- "Book Value"
  names(x)[names(x) == "Pkg_Value"] <- "Package Value"
  names(x)[names(x) == "Diff"] <- "Difference"
  names(x)[names(x) == "Action_Taken"] <- "Action Taken"
  if (!"Diagnosis" %in% names(x)) {
    x$Diagnosis <- NA_character_
  }
  x[, c(
    "Example", "Chapter", "Book Section", "Output Type", "Book Value",
    "Package Value", "Difference", "Status", "Diagnosis", "Action Taken"
  )]
}

sources <- c(
  "modernGLMM/inst/verification/phase3-master-verification.csv",
  "modernGLMM/inst/verification/ch02-ch05-verification.csv",
  "modernGLMM/inst/verification/ch08-ch10-verification.csv",
  "modernGLMM/inst/verification/ch12-ch14-verification.csv",
  "modernGLMM/inst/verification/ch15-ch21-verification.csv"
)
sources <- sources[file.exists(sources)]
df <- do.call(rbind, lapply(sources, normalize_source))

ch11_taxonomy <- data.frame(
  Example = rep("Exam11.3", 7L),
  Chapter = rep(11, 7L),
  `Book Section` = rep("11.4", 7L),
  `Output Type` = c(
    "Naive Poisson Pearson chi-square/DF",
    "Naive Poisson mean trt 1",
    "Naive Poisson mean trt 2",
    "Naive Poisson mean trt 3",
    "Poisson-normal unit VC",
    "Negative-binomial block VC",
    "Negative-binomial scale phi"
  ),
  Cause = c(
    rep("dataset reconstruction issue", 5L),
    "estimation method mismatch; software limitation",
    "estimation method mismatch; software limitation"
  ),
  Diagnosis = c(
    rep(
      paste(
        "Primary cause: dataset reconstruction issue. The original",
        "RCBD_counts file is unavailable; the constrained integer",
        "reconstruction preserves the printed treatment sample means but not",
        "all conditional fitted summaries."
      ),
      4L
    ),
    paste(
      "Primary cause: dataset reconstruction issue. lme4 nAGQ=0,",
      "lme4 nAGQ=1, and glmmTMB ML all return unit variance near 0.78,",
      "so the gap is not repaired by the available R likelihood options."
    ),
    paste(
      "Primary cause: estimation method mismatch with software limitation.",
      "The book reports SAS GLIMMIX pseudo-likelihood output; glmmTMB",
      "nbinom2 ML gives a different block variance and no direct GLIMMIX",
      "PL analogue is available in the package workflow."
    ),
    paste(
      "Primary cause: estimation method mismatch with software limitation.",
      "The book's negative-binomial scale is reported by SAS GLIMMIX PL;",
      "glmmTMB estimates the nbinom2 theta parameter by ML/REML and only",
      "an approximate phi conversion is available."
    )
  ),
  `Repair Attempt` = c(
    paste(
      "Re-fit current reconstruction with lme4 Laplace and glmmTMB ML;",
      "both returned Pearson chi-square/DF 7.1294. MASS glmmPQL was also",
      "checked for fitted means but is not the book's Laplace fit."
    ),
    paste(
      "Re-fit current reconstruction with lme4 Laplace and glmmTMB ML;",
      "both returned trt 1 mean 4.2842/4.2839. MASS glmmPQL returned",
      "5.3844, not the printed 4.7023."
    ),
    paste(
      "Re-fit current reconstruction with lme4 Laplace and glmmTMB ML;",
      "both returned trt 2 mean 7.1225/7.1220. MASS glmmPQL returned",
      "8.9516, not the printed 7.8176."
    ),
    paste(
      "Re-fit current reconstruction with lme4 Laplace and glmmTMB ML;",
      "both returned trt 3 mean 13.7630/13.7620. MASS glmmPQL returned",
      "17.2974, not the printed 15.1061."
    ),
    paste(
      "Re-fit Poisson-normal model with lme4 nAGQ=0, lme4 nAGQ=1,",
      "and glmmTMB ML. Unit VC values were 0.7801, 0.7812, and 0.7817,",
      "respectively, versus the printed 0.9805."
    ),
    paste(
      "Re-fit negative-binomial model using glmmTMB nbinom2 ML, nbinom1 ML,",
      "and nbinom2 REML. Block VC values were 0.8505, 0.2676, and 0.9765,",
      "none jointly reproduced the printed GLIMMIX PL result."
    ),
    paste(
      "Re-fit negative-binomial model using glmmTMB nbinom2 ML and REML.",
      "Book-scale phi approximations were 0.6830 and 0.7668 versus the",
      "printed 0.845; nbinom1 scale is not the same parameter."
    )
  ),
  `Final Resolution Status` = rep(
    "Unresolved; retained as MISMATCH and documented explicitly.",
    7L
  ),
  check.names = FALSE
)

for (i in seq_len(nrow(ch11_taxonomy))) {
  idx <- df$Example == ch11_taxonomy$Example[i] &
    df$Chapter == ch11_taxonomy$Chapter[i] &
    df$`Book Section` == ch11_taxonomy$`Book Section`[i] &
    df$`Output Type` == ch11_taxonomy$`Output Type`[i]
  df$`Action Taken`[idx] <- paste(
    ch11_taxonomy$Cause[i],
    ch11_taxonomy$`Repair Attempt`[i],
    ch11_taxonomy$`Final Resolution Status`[i],
    sep = " | "
  )
}

default_diagnosis <- ifelse(
  df$Status == "EXACT",
  "Matches printed 2024 book output within exact tolerance",
  ifelse(
    df$Status == "APPROX",
    "Within approximate tolerance or documented SAS/R estimation difference",
    df$`Action Taken`
  )
)
df$Diagnosis <- ifelse(
  is.na(df$Diagnosis) | df$Diagnosis == "",
  default_diagnosis,
  df$Diagnosis
)

for (i in seq_len(nrow(ch11_taxonomy))) {
  idx <- df$Example == ch11_taxonomy$Example[i] &
    df$Chapter == ch11_taxonomy$Chapter[i] &
    df$`Book Section` == ch11_taxonomy$`Book Section`[i] &
    df$`Output Type` == ch11_taxonomy$`Output Type`[i]
  df$Diagnosis[idx] <- ch11_taxonomy$Diagnosis[i]
}

out <- df[, c(
  "Example", "Chapter", "Book Section", "Output Type", "Book Value",
  "Package Value", "Difference", "Status", "Diagnosis", "Action Taken"
)]
utils::write.csv(
  out,
  "modernGLMM/inst/verification/master-verification-table.csv",
  row.names = FALSE,
  na = ""
)

esc <- function(x) {
  gsub("\\|", "\\\\|", as.character(x))
}

md_table <- function(x) {
  x[] <- lapply(x, esc)
  header <- paste0("| ", paste(names(x), collapse = " | "), " |")
  sep <- paste0("|", paste(rep("---", ncol(x)), collapse = "|"), "|")
  rows <- apply(x, 1, function(z) {
    paste0("| ", paste(z, collapse = " | "), " |")
  })
  c(header, sep, rows)
}

writeLines(
  c(
    "# Master Verification Table",
    "",
    paste(
      "Scope: completed Chapter 1, Chapter 2-5, Chapter 8-10, Chapter 12-21 classification, and Chapter 11 verification",
      "artifacts. Full Chapter 1-21 verification remains incomplete and is not claimed here."
    ),
    "",
    md_table(out)
  ),
  "modernGLMM/inst/verification/master-verification-table.md"
)

make_sum <- function(ch) {
  sub <- out[out$Chapter == ch, ]
  ex <- sum(sub$Status == "EXACT")
  ap <- sum(sub$Status == "APPROX")
  mm <- sum(sub$Status == "MISMATCH")
  un <- sum(sub$Status == "UNVERIF")
  denom <- ex + ap + mm
  pass <- if (denom == 0) NA_real_ else 100 * (ex + ap) / denom
  data.frame(
    Chapter = paste0("Ch ", ch),
    `Total Quantities` = nrow(sub),
    EXACT = ex,
    APPROX = ap,
    MISMATCH = mm,
    UNVERIF = un,
    `Pass Rate` = ifelse(is.na(pass), "NA", sprintf("%.1f%%", pass)),
    check.names = FALSE
  )
}

summary <- do.call(rbind, lapply(sort(unique(out$Chapter)), make_sum))
ex <- sum(out$Status == "EXACT")
ap <- sum(out$Status == "APPROX")
mm <- sum(out$Status == "MISMATCH")
un <- sum(out$Status == "UNVERIF")
denom <- ex + ap + mm
summary <- rbind(
  summary,
  data.frame(
    Chapter = "TOTAL",
    `Total Quantities` = nrow(out),
    EXACT = ex,
    APPROX = ap,
    MISMATCH = mm,
    UNVERIF = un,
    `Pass Rate` = sprintf("%.1f%%", 100 * (ex + ap) / denom),
    check.names = FALSE
  )
)

writeLines(
  c(
    "# Chapter Summary Table",
    "",
    paste(
      "Scope: completed Chapter 1, Chapter 2-5, Chapter 8-10, Chapter 12-21 classification, and Chapter 11 verification artifacts.",
      "Rows marked UNVERIF are excluded from the pass-rate denominator."
    ),
    "",
    md_table(summary)
  ),
  "modernGLMM/inst/verification/chapter-summary-table.md"
)

mis <- out[out$Status == "MISMATCH", ]
mis_lines <- c(
  "# Mismatch Report",
  "",
  paste(
    "Scope: unresolved mismatches from completed Chapter 1, Chapter 2-5, Chapter 8-10, Chapter 12-21 classification, and Chapter 11 verification.",
    "No all-chapter mismatch claim is made."
  ),
  ""
)
if (nrow(mis) > 0L) {
  for (i in seq_len(nrow(mis))) {
    pct <- suppressWarnings(
      100 * as.numeric(mis$Difference[i]) / abs(as.numeric(mis$`Book Value`[i]))
    )
    pct_txt <- if (is.finite(pct)) sprintf("%.1f%%", pct) else "NA"
    mis_lines <- c(
      mis_lines,
      paste0("## MISMATCH: ", mis$Example[i], " - ", mis$`Output Type`[i]),
      "",
      paste0("Book value: ", mis$`Book Value`[i]),
      "",
      paste0("Package value: ", mis$`Package Value`[i]),
      "",
      paste0("Difference: ", mis$Difference[i], " (", pct_txt, ")"),
      "",
      paste0("Diagnosis: ", mis$Diagnosis[i]),
      "",
      paste0("Action taken: ", mis$`Action Taken`[i]),
      "",
      paste(
        "Resolution: Unresolved after dataset/model/estimation review.",
        "The remaining gap is documented in dataset provenance and retained as a mismatch."
      ),
      ""
    )
  }
}
writeLines(mis_lines, "modernGLMM/inst/verification/mismatch-report.md")

tax_rows <- merge(
  ch11_taxonomy,
  out[, c(
    "Example", "Chapter", "Book Section", "Output Type", "Book Value",
    "Package Value", "Difference", "Status"
  )],
  by = c("Example", "Chapter", "Book Section", "Output Type"),
  all.x = TRUE,
  sort = FALSE
)
tax_rows <- tax_rows[, c(
  "Example", "Chapter", "Book Section", "Output Type", "Book Value",
  "Package Value", "Difference", "Cause", "Diagnosis", "Repair Attempt",
  "Final Resolution Status", "Status"
)]

tax_lines <- c(
  "# Chapter 11 Mismatch Taxonomy",
  "",
  paste(
    "Scope: the seven unresolved Chapter 11 mismatches after re-fitting the",
    "current package data and checking reasonable R repair candidates against",
    "Stroup, Ptukhina, and Garai (2024), Chapter 11, Section 11.4."
  ),
  "",
  paste(
    "Repair runs are reproducible with",
    "`inst/verification/ch11-diagnostic-repairs.R` from the package root."
  ),
  ""
)

for (i in seq_len(nrow(tax_rows))) {
  tax_lines <- c(
    tax_lines,
    paste0("## ", tax_rows$Example[i], " - ", tax_rows$`Output Type`[i]),
    "",
    paste0("Book section: ", tax_rows$`Book Section`[i]),
    "",
    paste0("Book value: ", tax_rows$`Book Value`[i]),
    "",
    paste0("Package value: ", tax_rows$`Package Value`[i]),
    "",
    paste0("Difference: ", tax_rows$Difference[i]),
    "",
    paste0("Cause category: ", tax_rows$Cause[i]),
    "",
    paste0("Diagnosis: ", tax_rows$Diagnosis[i]),
    "",
    paste0("Repair attempt: ", tax_rows$`Repair Attempt`[i]),
    "",
    paste0("Final resolution status: ", tax_rows$`Final Resolution Status`[i]),
    ""
  )
}
writeLines(tax_lines, "modernGLMM/inst/verification/ch11-mismatch-taxonomy.md")

unv <- out[out$Status == "UNVERIF", ]
writeLines(
  c(
    "# Unverifiable Quantities",
    "",
    paste(
      "Scope: completed Chapter 1, Chapter 2-5, Chapter 8-10, Chapter 12-21 classification, and Chapter 11 quantities checked against the uploaded 2024 PDF where",
      "the book does not provide enough complete numerical output or the package",
      "dataset is synthetic."
    ),
    "",
    md_table(unv)
  ),
  "modernGLMM/inst/verification/unverifiable-quantities.md"
)

legacy <- out[out$`Output Type` == "Legacy example status", ]
legacy_lines <- c(
  "# Legacy Examples",
  "",
  paste(
    "Legacy status is assigned only after checking the 2024 2nd edition",
    "for the corresponding numbered example."
  ),
  ""
)
if (nrow(legacy) == 0L) {
  legacy_lines <- c(
    legacy_lines,
    "No completed verification row is currently classified as LEGACY.",
    ""
  )
} else {
  legacy_lines <- c(legacy_lines, md_table(legacy), "")
}
legacy_lines <- c(
  legacy_lines,
  paste(
    "Full Chapter 1-21 legacy classification remains incomplete because the",
    "all-chapter numerical verification has not been completed."
  )
)
writeLines(legacy_lines, "modernGLMM/inst/verification/legacy-examples.md")

writeLines(
  c(
    "Chapter 1 partial numerical verification complete for the current pass. 12 quantities verified/documented. 0 mismatches found.",
    "Chapters 2-5 complete. 69 quantities verified. 0 mismatches found.",
    "Chapters 8-10 complete. 367 quantities verified. 9 mismatches found.",
    "Chapters 12-14 complete. 0 quantities verified. 0 mismatches found.",
    "Chapters 15-21 complete. 0 quantities verified. 0 mismatches found.",
    "Chapter 11 complete for the current pass. 29 quantities verified/documented. 7 mismatches found.",
    "No remaining exported package examples are unclassified; legacy/no-export rows document the non-numerical gaps."
  ),
  "modernGLMM/inst/verification/progress-log.md"
)
