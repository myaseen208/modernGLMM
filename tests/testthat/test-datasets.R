test_that("Table1.1 loads and has correct structure", {
  data(Table1.1, package = "modernGLMM")
  expect_s3_class(Table1.1, "data.frame")
  expect_named(Table1.1, c("x", "Nx", "y"))
  expect_equal(nrow(Table1.1), 11L)
  expect_true(all(Table1.1$Nx > 0L))
  expect_true(all(Table1.1$y >= 0L))
})

test_that("Table1.2 loads and has correct structure", {
  data(Table1.2, package = "modernGLMM")
  expect_s3_class(Table1.2, "data.frame")
  expect_true(all(c("X", "Y", "Fav", "N", "Batch") %in% names(Table1.2)))
  expect_equal(nrow(Table1.2), 36L)
})

test_that("DataSet3.1 loads and has correct structure", {
  data(DataSet3.1, package = "modernGLMM")
  expect_s3_class(DataSet3.1, "data.frame")
  expect_true(all(c("trt", "rep", "Y", "N", "F") %in% names(DataSet3.1)))
  expect_equal(nrow(DataSet3.1), 20L)
  expect_true(all(DataSet3.1$N > 0L))
})

test_that("DataSet8.1 loads and has correct structure", {
  data(DataSet8.1, package = "modernGLMM")
  expect_s3_class(DataSet8.1, "data.frame")
  expect_true(all(c("a", "b", "y") %in% names(DataSet8.1)))
  expect_equal(nrow(DataSet8.1), 24L)
})

test_that("DataSet9.1 loads and has correct structure", {
  data(DataSet9.1, package = "modernGLMM")
  expect_s3_class(DataSet9.1, "data.frame")
  expect_true(all(c("block", "trt", "set", "y") %in% names(DataSet9.1)))
  expect_equal(nrow(DataSet9.1), 30L)
  expect_true(all(DataSet9.1$y > 0))
})

test_that("DataSet9.2 loads and has correct structure", {
  data(DataSet9.2, package = "modernGLMM")
  expect_s3_class(DataSet9.2, "data.frame")
  expect_true(all(c("block", "row", "col", "a", "b", "y") %in% names(DataSet9.2)))
  expect_equal(nrow(DataSet9.2), 36L)
})

test_that("Chapter 11 count datasets load and have correct structure", {
  data(DataSet11.1, package = "modernGLMM")
  expect_s3_class(DataSet11.1, "data.frame")
  expect_true(all(c("trt", "unit", "count") %in% names(DataSet11.1)))
  expect_equal(nrow(DataSet11.1), 10L)
  expect_true(all(DataSet11.1$count >= 0L))
  expect_true(all(DataSet11.1$count == as.integer(DataSet11.1$count)))
  expect_equal(as.numeric(stats::aggregate(count ~ trt, DataSet11.1, mean)$count),
               c(4.8, 15.0))

  data(DataSet11.3, package = "modernGLMM")
  expect_s3_class(DataSet11.3, "data.frame")
  expect_true(all(c("block", "trt", "count") %in% names(DataSet11.3)))
  expect_equal(nrow(DataSet11.3), 30L)
  expect_true(all(DataSet11.3$count >= 0L))
  expect_equal(as.numeric(stats::aggregate(count ~ trt, DataSet11.3, mean)$count),
               c(8.0, 13.3, 25.7))

  data(DataSet11.4, package = "modernGLMM")
  expect_s3_class(DataSet11.4, "data.frame")
  expect_true(all(c("block", "a", "b", "count") %in% names(DataSet11.4)))
  expect_equal(nrow(DataSet11.4), 112L)
  expect_true(all(DataSet11.4$count >= 0L))
})

test_that("DataExam2.B.2 loads and has correct structure", {
  data(DataExam2.B.2, package = "modernGLMM")
  expect_s3_class(DataExam2.B.2, "data.frame")
  expect_true(all(c("x", "y", "n") %in% names(DataExam2.B.2)))
  expect_equal(nrow(DataExam2.B.2), 11L)
})

test_that("DataExam2.B.4 loads and has correct structure", {
  data(DataExam2.B.4, package = "modernGLMM")
  expect_s3_class(DataExam2.B.4, "data.frame")
  expect_true(all(c("obs", "trt", "Nij", "Yij") %in% names(DataExam2.B.4)))
})

test_that("all datasets are non-empty data.frames", {
  datasets <- c(
    "Table1.1", "Table1.2",
    "DataSet3.1", "DataSet3.2", "DataSet3.3",
    "DataSet8.1", "DataSet8.2", "DataSet8.3", "DataSet8.4",
    "DataSet8.5", "DataSet8.6", "DataSet8.7",
    "DataSet9.1", "DataSet9.2", "DataSet9.3", "DataSet9.4",
    "DataSet10.1", "DataSet10.2", "DataSet10.4",
    "DataSet11.1", "DataSet11.3", "DataSet11.4",
    "DataSet12.1", "DataSet12.2",
    "DataSet14.1", "DataSet14.2",
    "DataSet17.1", "DataSet17.2",
    "DataSet18.1", "DataSet18.2",
    "DataSet21.1",
    "DataExam2.B.2", "DataExam2.B.3", "DataExam2.B.4", "DataExam2.B.7"
  )
  for (ds in datasets) {
    data(list = ds, package = "modernGLMM")
    obj <- get(ds)
    expect_true(is.data.frame(obj),
                info = paste(ds, "should be a data.frame"))
    expect_gt(nrow(obj), 0L)
  }
})
