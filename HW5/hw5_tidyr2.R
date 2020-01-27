# HW5: tidyr2
#'
#    In this exercise, you will familiarize yourself with the procedure of
#    tidying up data.
#    Throughout the exercise, use `%>%` to structure your operations.
#    Do NOT use `for`, `while` or `repeat` loops.
#'
# 1. Load the package `readr` and use its function `read_csv()` to read the
#    dataset `activities.csv` (located in directory `data/`). Store the
#    corresponding dataframe into a tibble `activities`.
#    In this dataset, each record is an observation (keyed by `id` and `trt`,
#    i.e., treatment group) whose score has been recorded at two times (`T1` and
#    `T2`) for three actions (`work`, `play` and `talk`).
## Do not modify this line!
library(readr)
activities <- read_csv("data/activities.csv")



# 2. Recall the three rules for a tidy dataset. What is the issue here?
#    We have variables stored in multiple columns!
#    Load the packages `tidyr` and `dplyr`.
#    From the `activities` tibble, extract a tibble `act_gathered` of
#    dimension 60 x 4 that contains the `id`, `trt`, `var` and `score` columns.
#    `var` is a new column that collects the six columns for `work`, `play` and
#    `talk`, while `score` is the corresponding score. The dataset should be
#    sorted by increasing `id` and `trt`.
#    To do this, you can use:
#    (1) `gather()` to collect the six columns for `var`.
#    (2) `arrange()` to sort the result by ascending order of `id` and `trt`.
#    Alternatively, you can use `pivot_longer()`.
#    To check your solution, `act_gathered` prints to:
#    # A tibble: 60 x 4
#          id trt   var      score
#       <int> <chr> <chr>    <dbl>
#     1     1 cnt   work.T1 0.652
#     2     1 cnt   play.T1 0.865
#     3     1 cnt   talk.T1 0.536
#     4     1 cnt   work.T2 0.275
#     5     1 cnt   play.T2 0.354
#     6     1 cnt   talk.T2 0.0319
#     7     2 cnt   work.T1 0.568
#     8     2 cnt   play.T1 0.615
#     9     2 cnt   talk.T1 0.0931
#    10     2 cnt   work.T2 0.229
#    # … with 50 more rows
## Do not modify this line!
library(tidyr)
library(dplyr)
act_gathered <- activities %>%
  gather(work.T1, play.T1, talk.T1, work.T2, play.T2, talk.T2, key = "var", value = "score") %>%
  arrange(id, trt)
act_gathered


# 3. What is the issue now? Two variables are stored in a single column!
#    From `act_gathered`, extract a tibble `act_separated` of dimension 60 x 5
#    that contains the `id`, `trt`, `action`, `time` and `score` columns.
#    `action` and `time` are two new columns that are separated from
#    `act_gathered$var`.
#    To do this, you can use `separate()` to separate `var` in `act_gathered`.
#    To check your solution, `act_separated` prints to:
#    # A tibble: 60 x 5
#          id trt   action time   score
#       <int> <chr> <chr>  <chr>  <dbl>
#     1     1 cnt   work   T1    0.652
#     2     1 cnt   play   T1    0.865
#     3     1 cnt   talk   T1    0.536
#     4     1 cnt   work   T2    0.275
#     5     1 cnt   play   T2    0.354
#     6     1 cnt   talk   T2    0.0319
#     7     2 cnt   work   T1    0.568
#     8     2 cnt   play   T1    0.615
#     9     2 cnt   talk   T1    0.0931
#    10     2 cnt   work   T2    0.229
#    # … with 50 more rows
## Do not modify this line!
act_separated <- act_gathered %>%
  separate(var, into = c("action", "time"))
act_separated



# 4. Is this dataset finally tidy? Not quite, we still have observations
#    stored in multiple rows.
#    From `act_separated`, extract a tibble `act_spread` of dimension 20 x 6
#    that contains the `id`, `trt`, `time`, `play`, `talk` and `work` columns.
#    `play`, `talk` and `work` are three new columns that are spread from
#    `act_separated$action`.
#    To do this, you can use `spread()` to spread `action` in `act_separated`.
#    Alternatively, you can use `pivot_wider()`.
#    To check your solution, `act_spread` (using `spread()`) prints to:
#    # A tibble: 20 x 6
#      id trt   time   play   talk    work
#       <int> <chr> <chr> <dbl>  <dbl>   <dbl>
#     1     1 cnt   T1    0.865 0.536   0.652
#     2     1 cnt   T2    0.354 0.0319  0.275
#     3     2 cnt   T1    0.615 0.0931  0.568
#     4     2 cnt   T2    0.936 0.114   0.229
#     5     3 tr    T1    0.775 0.170   0.114
#     6     3 tr    T2    0.246 0.469   0.0144
#     7     4 tr    T1    0.356 0.900   0.596
#     8     4 tr    T2    0.473 0.397   0.729
#     9     5 tr    T1    0.406 0.423  NA
#    10     5 tr    T2    0.192 0.834   0.250
#    11     6 cnt   T1    0.707 0.748   0.429
#    12     6 cnt   T2    0.583 0.761   0.161
#    13     7 tr    T1    0.838 0.823   0.0519
#    14     7 tr    T2    0.459 0.573   0.0170
#    15     8 tr    T1    0.240 0.955   0.264
#    16     8 tr    T2    0.467 0.448   0.486
#    17     9 cnt   T1    0.771 0.685   0.399
#    18     9 cnt   T2    0.400 0.0838  0.103
#    19    10 cnt   T1    0.356 0.501   0.836
#    20    10 cnt   T2    0.505 0.219   0.802
#    Using `pivot_wider()`, `act_spread` prints to:
#    # A tibble: 20 x 6
#      id trt   time     work  play   talk
#       <int> <chr> <chr>   <dbl> <dbl>  <dbl>
#    1      1 cnt   T1     0.652  0.865 0.536
#    2      1 cnt   T2     0.275  0.354 0.0319
#    3      2 cnt   T1     0.568  0.615 0.0931
#    4      2 cnt   T2     0.229  0.936 0.114
#    5      3 tr    T1     0.114  0.775 0.170
#    6      3 tr    T2     0.0144 0.246 0.469
#    7      4 tr    T1     0.596  0.356 0.900
#    8      4 tr    T2     0.729  0.473 0.397
#    9      5 tr    T1    NA      0.406 0.423
#    10     5 tr    T2     0.250  0.192 0.834
#    11     6 cnt   T1     0.429  0.707 0.748
#    12     6 cnt   T2     0.161  0.583 0.761
#    13     7 tr    T1     0.0519 0.838 0.823
#    14     7 tr    T2     0.0170 0.459 0.573
#    15     8 tr    T1     0.264  0.240 0.955
#    16     8 tr    T2     0.486  0.467 0.448
#    17     9 cnt   T1     0.399  0.771 0.685
#    18     9 cnt   T2     0.103  0.400 0.0838
#    19    10 cnt   T1     0.836  0.356 0.501
#    20    10 cnt   T2     0.802  0.505 0.219
## Do not modify this line!
act_spread <- act_separated %>%
  spread(key = action, value = score)
act_spread


# 5. There is one missing value in `act_spread`. Use the function `is.na` and
#    `which()` to locate the column index of the missing value
#    (hint: `arr.ind = TRUE` might be useful). Store the result
#    into a new variable `col_ix`, which should just be an integer.
## Do not modify this line!
col_ix <- which(is.na(act_spread), arr.ind = TRUE)[1,2]
col_ix



# 6. Use the function `fill()` to backward fill the missing value in `act_spread`
#    (hint: in the `up` direction). Use the `col_ix` you find in question 5.
#    Store the result into a tibble `act_filled`.
#    To check your solution, `sum(act_filled[, col_ix])` returns 7.224964.
## Do not modify this line!
act_filled <- act_spread %>%
  fill(names(act_spread)[col_ix], .direction = "up")
sum(act_filled[, col_ix])





