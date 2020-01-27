# HW5:dplyr
# 1. Load the `tidyr`, `dplyr` and `readr` packages.
#    Use `read_csv` to load the `abalone.csv` data set from `data` folder and
#    assign it to a tibble `abalone`.
#    Note: all manipulations should be done by `%>%`.
## Do not modify this line!
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
abalone <- "data/abalone.csv" %>%
  read_csv %>% 
  as_tibble




# 2. Extract a tibble `length_sex_ring` of dimension 1216 x 4
#    which contains the `sex`, `diameter`, `height` and `rings` columns.
#    The dataset should be filtered for length strictly larger than 0.6 and
#    be sorted by increasing `sex` and decreasing `ring`.
#    To do that, you can use:
#      - `filter` to select rows that have `length` larger than 0.6.
#      - `arrange` to arrange data set by sex with first `"F"` then `"I"` and `"M"`,
#      and descending order of `ring`.
#      - `select` to select columns `sex`, `diameter`, `height` and `rings`.
#    To check your solution, `length_sex_ring` prints to:
#    # A tibble: 1,216 x 4
#    sex   diameter height rings
#    <chr>    <dbl>  <dbl> <dbl>
#    1 F        0.585  0.185    29
#    2 F        0.49   0.215    25
#    3 F        0.54   0.215    24
#    4 F        0.47   0.2      23
#    5 F        0.52   0.225    23
#    6 F        0.63   0.195    23
#    7 F        0.525  0.215    22
#    8 F        0.485  0.19     21
#    9 F        0.42   0.165    21
#    10 F        0.55   0.2      21
#    # … with 1,206 more rows
## Do not modify this line!
length_sex_ring <- abalone %>%
  filter(length > 0.6) %>%
  arrange(sex, desc(rings)) %>%
  select(sex, diameter, height, rings)
length_sex_ring




# 3. Extract a tibble `count_prop` of dimension 3 x 3,
#    which contains the `sex`, `count` and `prop` columns.
#    The dataset should be grouped by increasing `sex` with counted numbers
#    of each group. Then calculate the proportion of each count.
#    To do that, you can use
#      - `count` to count cases and make name as `count`.
#      - `mutate` to make a new column and name it `prop`, let `prop` be
#      `count / sum(count)`.
#    To check your solution, `count_prop` prints to:
#    # A tibble: 3 x 3
#    sex   count  prop
#    <chr> <int> <dbl>
#    1 F      1307 0.313
#    2 I      1342 0.321
#    # … with 1 more row
## Do not modify this line!
count_prop <- abalone %>%
  count(sex) %>%
  rename("count" = n) %>%
  mutate("prop" = count / sum(count)) 
count_prop
    
  
# 4. Extract a tibble `mean_max_min` of dimension 3 x 4,
#    which contains the `sex`, `weight_mean`, `weight_max` and `weight_min` columns.
#    The dataset should be grouped by increasing `sex` and summarized by
#    finding mean, max and min of `shucked_weight`.
#    To do that, you can use
#      - `group_by` to group data set by `sex` with first `"F"` then `"I"` and `"M"`.
#      - `summarize` to to collapse all values into three new columns:
#      `weight_mean`, `weight_max` and `weight_min`.
#      `weight_mean` should be mean of `shucked_weight`.
#      `weight_min` should be min of `shucked_weight`.
#      `weight_max` should be max of `shucked_weight`.
#    To check your solution, `mean_max_min` prints to:
#    # A tibble: 3 x 4
#    sex   weight_mean weight_max weight_min
#    <chr>       <dbl>      <dbl>      <dbl>
#    F           0.446      1.49      0.031
#    I           0.191      0.774     0.001
#    # … with 1 more row
## Do not modify this line!
mean_max_min <- abalone %>%
  group_by(sex) %>%
  summarize(
    weight_mean = mean(shucked_weight),
    weight_max = max(shucked_weight),
    weight_min = min(shucked_weight)

  ) %>%
  select(sex, weight_mean, weight_max, weight_min)
mean_max_min



# 5. Extract a tibble `filter_na_rename_select_everything` of dimension 2963 x 10,
#    which contains all columns.
#    The dataset should be flitered for diameter is NA or strictly greater than 0.36.
#    The column `X` should be renamed as `index`.
#    You should also rearrange `index`, `sex`, `length`, `diameter` and `rings`.
#    to first five columns and keep all the columns.
#    To do that, you can use
#      - `filter` to select rows that `diameter` is `na` or greater than 0.36.
#      - `rename` to rename `X` as `index`.
#      - `select` and `everything` to select all columns with first five columns
#      as `index`, `sex`, `length`, `diameter` and `rings`.
#    To check your solution, `filter_na_rename_select_everything` prints to:
#    # A tibble: 2,963 x 10
#    index sex   length diameter rings height whole_weight shucked_weight
#    <dbl> <chr>  <dbl>    <dbl> <dbl>  <dbl>        <dbl>          <dbl>
#    1      M      0.455    0.365    15  0.095        0.514          0.224
#    2      F      0.53     0.42      9  0.135        0.677          0.256
#    3      M      0.44     0.365    10  0.125        0.516          0.216
#    4      F      0.53     0.415    20  0.15         0.778          0.237
#    5      F      0.545    0.425    16  0.125        0.768          0.294
#    6      M      0.475    0.37      9  0.125        0.509          0.216
#    7      F      0.55     0.44     19  0.15         0.894          0.314
#    8      F      0.525    0.38     14  0.14         0.606          0.194
#    9      M      0.49     0.38     11  0.135        0.542          0.218
#    10     F      0.535    0.405    10  0.145        0.684          0.272
#    # … with 2,953 more rows, and 2 more variables: viscera_weight <dbl>,
#     shell_weight <dbl>
## Do not modify this line!
filter_na_rename_select_everything <- abalone %>%
  filter(is.na(diameter) | diameter > 0.36) %>%
  rename("index" = X) %>%
  select(index, sex, length, diameter, rings, everything())
filter_na_rename_select_everything



# 6. Extract a tibble `transmute` of dimension 4177 x 2,
#    which contains the `whole_weight_in_mg` and `water_weight_in_mg` columns.
#    The dataset should build two new columns. The first column transfers
#    `whole_weight` into mg. The second column calculate water weight and also in
#    mg.
#    To do that, you can use:
#      - `transmute` to only keep two variables `whole_weight_in_mg` and
#      `water_weight_in_mg`. `whole_weight_in_mg` is `whole_weight` times 1000.
#      `water_weight_in_mg` is `whole_weight` minus all other weights then times 1000.
#    To check your solution, `transmute` prints to:
#    # A tibble: 4,177 x 2
#    whole_weight_in_mg water_weight_in_mg
#    <dbl>              <dbl>
#    514               38.5
#    226.               7.50
#    677               69.
#    516               31.5
#    205               21.0
#    352.              13.
#    778.              69
#    768               64.5
#    509.              15.5
#    894.             109.
#    # … with 4,167 more rows
## Do not modify this line!
transmute <- abalone %>%
  transmute("whole_weight_in_mg" = whole_weight * 1000,
            "water_weight_in_mg" = (whole_weight - shucked_weight - viscera_weight - shell_weight) * 1000)
transmute


# 7. Extract a tibble `first_1000_rank` of dimension 1000 x 3,
#    which contains the `diameter`, `rings` and `rings_rank` columns, sorted
#    by ascending `rings_rank`, which is a column containing the rank
#    corresponding to the value of the `rings` variable.
#    The dataset should select the three columns and rank on the `rings`. Then
#    it should be filtered for first 1000 `rings_rank`.
#    To do that, you can use
#      - `select` to select out `diameter` and `rings`.
#      - `mutate` and `row_number` to rank `rings`. Name the new column as `rings_rank`.
#      - `filter` to filter out `rings_rank` less than or equal to `1000`.
#      - `arrange` by `rings_rank`.
#    To check your solution, `first_1000_rank` prints to:
#    # A tibble: 1,000 x 3
#    diameter rings rings_rank
#    <dbl> <dbl>      <int>
#    1    0.055     1          1
#    2    0.1       2          2
#    3    0.1       3          3
#    4    0.09      3          4
#    5    0.12      3          5
#    6    0.15      3          6
#    7    0.11      3          7
#    8    0.11      3          8
#    9   NA         3          9
#    10    0.15      3         10
#    # … with 990 more rows
## Do not modify this line!
first_1000_rank <- abalone %>%
  select(diameter, rings) %>%
  mutate(rings_rank = row_number(rings)) %>%
  filter(rings_rank <= 1000) %>%
  arrange(rings_rank)
first_1000_rank
  



# 8. Extract a tibble `n_distinct_rings_by_sex` of dimension 3 x 2,
#    which contains the `sex` and `distinct_rings` columns.
#    The dataset should be grouped by `sex` and then summarized to count distinct
#    rings of each group.
#    To do that, you can use
#      - `group_by` to group data set by `sex` with first `"F"` then `"I"` and `"M"`.
#      - `summarize` to build a new column called `distinct_rings`.
#      -`n_distinct` to count number of distinct rings of each group and assign
#      values to `distinct_rings`.
#      To check your solution, `first_1000_rank` prints to:
#      # A tibble: 3 x 2
#      sex   distinct_rings
#      <chr>          <int>
#      F                 23
#      I                 21
#      # … with 1 more row
## Do not modify this line!
n_distinct_rings_by_sex <- abalone %>%
  group_by(sex) %>%
  summarize(distinct_rings = n_distinct(rings))
n_distinct_rings_by_sex




