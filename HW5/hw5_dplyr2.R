# HW5: dplyr2
#'
#    In this exercise, you will familiarize yourself with the verbs of `dplyr`.
#    Throughout the exercise, use `%>%` to structure your operations.
#    Do NOT use `for`, `while` or `repeat` loops.
#'
# 1. Load the package `readr` and use its function `read_csv()` to read the
#    dataset `nations.csv` (located in directory `data/`).
#    Store the corresponding dataframe into a tibble `nations`.
#    Load the `dplyr` package.
#    Use the `glimpse()` function to have a look at the data set.
## Do not modify this line!
library(readr)
nations <- read_csv("data/nations.csv")
library(dplyr)
glimpse(nations)


# 2. From the `nations` in Q1, extract a tibble `longevity` of dimension 175 x 5
#    that contains the `country`, `gdp_percap`, `life_expect`, `population` and
#    `region` columns.
#    The dataset should be filtered for `year` `2016` with non-null values in
#    `life_expect` and `gdp_percap`.
#    To do this, you can use:
#    (1) `filter()` to select rows with `year` as `2016` and non-NA `life_expect`
#    and `gdp_percap` (hint: you can use `is.na()` to check for missing values).
#    (2) `dplyr::select()` to include only `country`, `gdp_percap`, `life_expect`,
#    `population` and `region` (side note: by doing `dplyr::`, we enforce the use
#    of `dplyr`'s `select` to resolve function conflicts with other packages such
#    as `MASS`).
#    To check your solution, `longevity` prints to:
#    # A tibble: 175 x 5
#       country              gdp_percap life_expect population region
#       <chr>                     <dbl>       <dbl>      <int> <chr>
#     1 United Arab Emirates     72400.        77.3    9269612 Middle East & North Africa
#     2 Afghanistan               1944.        63.7   34656032 South Asia
#     3 Antigua and Barbuda      22661.        76.4     100963 Latin America & Caribbean
#     4 Albania                  11540.        78.3    2876101 Europe & Central Asia
#     5 Armenia                   8833.        74.6    2924816 Europe & Central Asia
#     6 Angola                    6454.        61.5   28813463 Sub-Saharan Africa
#     7 Argentina                19940.        76.6   43847430 Latin America & Caribbean
#     8 Austria                  50552.        80.9    8731471 Europe & Central Asia
#     9 Australia                46012.        82.5   24210809 East Asia & Pacific
#    10 Azerbaijan               17257.        72.0    9757812 Europe & Central Asia
#    # … with 165 more rows
## Do not modify this line!
longevity <- nations %>%
  filter(year == 2016 & !is.na(life_expect) & !is.na(gdp_percap)) %>%
  dplyr::select(country, gdp_percap, life_expect, population, region)
longevity



# 3. From `longevity` in Q2, extract a tibble `ea_na_75_85` of dimension 15 x 5
#    that contains the `country`, `gdp_percap`, `life_expect`, `population` and
#    `region` columns.
#    The dataset should be filtered for countries in `"East Asia & Pacific"` or
#    `"North America"`, with `life_expect` between 75 and 85 (include the boundary
#    points). It should be sorted by decreasing `life_expect`.
#    To do this, you can use:
#    (1) `filter()` to select rows with `region` as `"East Asia & Pacific"` or
#    `"North America"` and `life_expect` between 75 and 85.
#    (2) `arrange()` to arrange data by descending order of `life_expect`.
#    To check your solution, `ea_na_75_85` prints to:
#    # A tibble: 15 x 5
#       country              gdp_percap life_expect population region
#       <chr>                     <dbl>       <dbl>      <int> <chr>
#     1 Hong Kong SAR, China     58618.        84.2    7336600 East Asia & Pacific
#     2 Japan                    42281.        84.0  126994511 East Asia & Pacific
#     3 Macao SAR, China        105420.        83.8     612167 East Asia & Pacific
#     4 Singapore                87833.        82.8    5607283 East Asia & Pacific
#     5 Australia                46012.        82.5   24210809 East Asia & Pacific
#     6 Canada                   44819.        82.3   36264604 North America
#     7 Korea, Rep.              36532.        82.0   51245707 East Asia & Pacific
#     8 New Zealand              38565.        81.6    4693200 East Asia & Pacific
#     9 United States            57638.        78.7  323127513 North America
#    10 Brunei Darussalam        77421.        77.2     423196 East Asia & Pacific
#    11 Vietnam                   6296.        76.3   94569072 East Asia & Pacific
#    12 China                    15529.        76.3 1378665000 East Asia & Pacific
#    13 Thailand                 16913.        75.3   68863514 East Asia & Pacific
#    14 Malaysia                 27683.        75.3   31187265 East Asia & Pacific
#    15 Samoa                     6378.        75.0     195125 East Asia & Pacific
## Do not modify this line!
ea_na_75_85 <- longevity %>%
  filter((region == "East Asia & Pacific" | region == "North America") & life_expect > 75 & life_expect < 85) %>%
  arrange(desc(life_expect))
ea_na_75_85


# 4. From `longevity` in Q2, extract a tibble `top_10_perc_us` of dimension
#    19 x 6 that contains the `country`, `gdp_percap`, `life_expect`, `population`,
#    `region` and `perc_rank` columns.
#    `perc_rank` should be a new column calculating the percentile rank for
#    `life_expect` (hint: use `percent_rank()`). The dataset should be sorted
#    by decreasing `perc_rank` and filtered for countries with top 10%
#    `perc_rank` (i.e., `perc_rank` >= 0.9), plus `"United States"` (whose rank
#    may lie outside the top 10%).
#    To do this, you can use:
#    (1) `mutate()` to create a new column `perc_rank`.
#    (2) `arrange()` to sort the result by `perc_rank` descendingly.
#    (3) `filter()` to find the countries with the top 10% `perc_rank` plus
#    `"United States"`.
#    To check your solution, `top_10_perc_us` prints to:
#    # A tibble: 19 x 6
#       country             gdp_percap life_expect population region                  perc_rank
#       <chr>                    <dbl>       <dbl>      <int> <chr>                       <dbl>
#     1 Hong Kong SAR, Chi…     58618.        84.2    7336600 East Asia & Pacific         1.
#     2 Japan                   42281.        84.0  126994511 East Asia & Pacific         0.994
#     3 Macao SAR, China       105420.        83.8     612167 East Asia & Pacific         0.989
#     4 Switzerland             63889.        82.9    8372413 Europe & Central Asia       0.983
#     5 Spain                   36305.        82.8   46484533 Europe & Central Asia       0.977
#     6 Singapore               87833.        82.8    5607283 East Asia & Pacific         0.971
#     7 Italy                   38380.        82.5   60627498 Europe & Central Asia       0.966
#     8 Norway                  58790.        82.5    5236151 Europe & Central Asia       0.960
#     9 Australia               46012.        82.5   24210809 East Asia & Pacific         0.954
#    10 Iceland                 50746.        82.5     335439 Europe & Central Asia       0.948
#    11 Israel                  37258.        82.4    8546000 Middle East & North Af…     0.943
#    12 Canada                  44819.        82.3   36264604 North America               0.937
#    13 Luxembourg             102389.        82.3     582014 Europe & Central Asia       0.931
#    14 France                  41343.        82.3   66892205 Europe & Central Asia       0.925
#    15 Sweden                  48905.        82.2    9923085 Europe & Central Asia       0.920
#    16 Korea, Rep.             36532.        82.0   51245707 East Asia & Pacific         0.914
#    17 Malta                   37928.        81.8     437418 Middle East & North Af…     0.908
#    18 Finland                 43378.        81.8    5495303 Europe & Central Asia       0.902
#    19 United States           57638.        78.7  323127513 North America               0.805
## Do not modify this line!
top_10_perc_us <- longevity %>%
  mutate(perc_rank = percent_rank(life_expect)) %>%
  arrange(desc(perc_rank)) %>%
  filter(perc_rank > 0.9 | country == "United States")
top_10_perc_us


# 5. From `nations` in Q1, extract a tibble `gdp_by_region` of dimension 189 x 3
#    that contains the `region`, `year` and `total_gdp` columns.
#    `total_gdp` should be a new column calculating the total real GDP by
#    `region` and `year`, where real GDP is the product of `gdp_percap` and
#    `population`. The unit of `total_gdp` should be trillions of dollars (hint:
#    divide the result by 1000000000000).
#    To do this, you can use:
#    (1) `mutate()` to create a new column `gdp` to find the real GDP.
#    (2) `group_by()` to group data by `region` and `year`.
#    (3) `summarise()` to find the total real GDP in trillions of dollars
#    (hint: set `na.rm = TRUE` when taking sum since we may have NA's for `gdp`).
#    To check your solution, `gdp_by_region` prints to:
#    # A tibble: 189 x 3
#    # Groups:   region [7]
#       region               year total_gdp
#       <chr>               <int>     <dbl>
#     1 East Asia & Pacific  1990      5.59
#     2 East Asia & Pacific  1991      6.10
#     3 East Asia & Pacific  1992      6.57
#     4 East Asia & Pacific  1993      7.11
#     5 East Asia & Pacific  1994      7.71
#     6 East Asia & Pacific  1995      8.39
#     7 East Asia & Pacific  1996      9.09
#     8 East Asia & Pacific  1997      9.66
#     9 East Asia & Pacific  1998      9.75
#    10 East Asia & Pacific  1999     10.3
#    # … with 179 more rows
## Do not modify this line!
gdp_by_region <- nations %>%
  mutate(gdp = gdp_percap * population / 1000000000000) %>%
  group_by(region, year) %>%
  summarise(total_gdp = sum(gdp, na.rm = TRUE))
gdp_by_region


# 6. From `nations` in Q1, extract a tibble `p_countries` of dimension 5 x 2
#    that contains `income` and `p` columns.
#    The dataset should be filtered for `year` `2016`. `p` should be a new column
#    calculating the proportions of countries with `life_expect` over 70 by
#    `income` (hint: count for countries that satisfy the condition, then divide
#    by the total count using `n()`).
#    To do this, you can use:
#    (1) `filter()` filter select rows for `year` `2016`.
#    (2) `group_by()` to group data by `income`.
#    (3) `summarise()` to find the proportions of countries with `life_expect`
#    over 70 (hint: set `na.rm = TRUE` when taking sum since we may have NA's).
#    To check your solution, `p_countries` prints to:
#    # A tibble: 5 x 2
#      income                  p
#      <chr>               <dbl>
#    1 High income         0.841
#    2 Low income          0.118
#    3 Lower middle income 0.426
#    4 Not classified      0
#    5 Upper middle income 0.849
## Do not modify this line!
p_countries <- nations %>%
  filter(year == 2016) %>%
  group_by(income) %>%
  summarise(p = sum(life_expect > 70, na.rm = TRUE)/length(income))
p_countries



