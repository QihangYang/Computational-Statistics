# HW7: Reproducing a paper figure
#'
# This exercise was inspired by exercise 6 in Chapter 2 of
# [Bit By Bit: Social Research in the Digital Age]
# (https://www.bitbybitbook.com/en/1st-ed/observing-behavior/observing-activities/)
# by Matt Salganik.
#'
# "In a widely discussed paper, Michel and colleagues
# ([2011](https://doi.org/10.1126/science.1199644)) analyzed the content of
# more than five million digitized books in an attempt to identify long-term
# cultural trends. The data that they used has now been released as the Google
# NGrams dataset, and so we can use the data to replicate and extend some of
# their work.
#'
# In one of the many results in the paper, Michel and colleagues argued that we
# are forgetting faster and faster. For a particular year, say “1883,” they
# calculated the proportion of all terms published in each year between 1875
# and 1975 that were “1883”. They reasoned that this proportion is a measure of
# the interest in events that happened in that year. In their figure 3a, they
# plotted the usage trajectories for three years: 1883, 1910, and 1950. These
# three years share a common pattern: little use before that year, then a
# spike, then decay."
#'
# They noticed the rate of decay for each year mentioned seemed to increase
# with time and they argued that this means that we are forgetting the past
# faster and faster.
#'
# The full paper can be found
# [here](https://aidenlab.org/papers/Science.Culturomics.pdf), and you are
# going to replicate part of figure 3a.
#'
# To do so we will focus on the mention of terms that can represent years
# (strings like "1765", "1886", "1897", "1937"...). The raw data was fetched
# for you from the [Google Books NGram Viewer website]
# (http://storage.googleapis.com/books/ngrams/books/datasetsv2.html) and
# preprocessed into two files:
# - `data/mentions_yearly_counts.tsv` contains the number of mentions of
#   different terms per year and the number of books retrieved where the term
#   appeared each year
#   (one row per term per year)
# - `data/yearly_total_counts.csv` contains the total number of mentions of all
#   terms per year as well as the number of pages and books retrived each year
#   (one row per year)
#'
# 1. Load the `readr` package.
#    Read in `data/mentions_yearly_counts.tsv` using `read_tsv()` and assign
#    the resulting tibble to `terms_mentions`.
#    Set the parameters of `read_tsv()` in order to make sure of the following:
#    - column names should be, in order: `term`, `year`, `n_mentions`,
#      `book_count`
#    - column types should be, in order: `character`, `integer`, `integer`,
#      `integer`
#    Hint: you can use parameters `col_names` and `col_types` to achieve this.
#    `terms_mentions` should print to:
#    # A tibble: 53,393 x 4
#       term   year n_mentions book_count
#       <chr> <int>      <int>      <int>
#     1 1817   1524         31          1
#     2 1817   1575         17          1
#     3 1817   1607          3          1
#     4 1817   1637          2          1
#     5 1817   1662          1          1
#     6 1817   1675          5          1
#     7 1817   1693          8          1
#     8 1817   1705          1          1
#     9 1817   1708          1          1
#    10 1817   1713          1          1
#    # … with 53,383 more rows
## Do not modify this line!
library(readr)
terms_mentions <- read_tsv("data/mentions_yearly_counts.tsv", 
                           col_names = c("term", "year", "n_mentions", "book_count"),
                           col_types = list(col_character(), col_integer(), col_integer(), col_integer()))



# 2. Read in `data/yearly_total_counts.csv` using `read_csv()` and assign the
#    resulting tibble to `total_mentions`.
#    Set the parameters of `read_csv()` in order to make sure of the following:
#    - column names should be, in order: `year`, `total_mentions`,
#      `total_page_count`, `total_book_count`
#    - column types should be, in order: `integer`, `double`, `integer`,
#      `integer`
#    Hint: you can use parameters `col_names` and `col_types` to achieve this.
#    Note: the reason you should read in the `total_mentions` as a `double`
#    column is that it contains very large integers that don't fit within the
#    bounds of numbers represented by the `integer` type in R. Using a
#    double-precision number is our only recourse.
#    `total_mentions` should print to:
#    # A tibble: 425 x 4
#        year total_mentions total_page_count total_book_count
#       <int>          <dbl>            <int>            <int>
#     1  1505          32059              231                1
#     2  1507          49586              477                1
#     3  1515         289011             2197                1
#     4  1520          51783              223                1
#     5  1524         287177             1275                1
#     6  1525           3559               69                1
#     7  1527           4375               39                1
#     8  1541           5272               59                1
#     9  1563         213843              931                1
#    10  1564          70755              387                1
#    # … with 415 more rows
## Do not modify this line!
total_mentions <- read_csv("data/yearly_total_counts.csv",
                           col_names = c("year", "total_mentions", "total_page_count", "total_book_count"),
                           col_types = list(col_integer(), col_double(), col_integer(), col_integer()))


# 3. Load the `dplyr` package. In order to join the `total_mentions`
#    Left join the `total_mentions` on `terms_mentions` by `year` and assign
#    the resulting tibble to `mentions`.
#    Hint: you can use `left_join()`.
#    `mentions` should print to:
#    # A tibble: 53,393 x 7
#       term   year n_mentions book_count total_mentions total_page_count total_book_count
#       <chr> <int>      <int>      <int>          <dbl>            <int>            <int>
#     1 1817   1524         31          1         287177             1275                1
#     2 1817   1575         17          1         186706             1067                1
#     3 1817   1607          3          1         381763             1600                2
#     4 1817   1637          2          1         681719             2315                3
#     5 1817   1662          1          1         239762             1471                3
#     6 1817   1675          5          1        1644156             8918               14
#     7 1817   1693          8          1        1038415             7426               16
#     8 1817   1705          1          1        4908749            28840               60
#     9 1817   1708          1          1        6481151            37416               70
#    10 1817   1713          1          1        4720647            25961               77
#    # … with 53,383 more rows
## Do not modify this line!
library(dplyr)
mentions <- terms_mentions %>%
  left_join(total_mentions, by = "year")
mentions

# 4. Check that your join was successful by using `anti_join()` to drop all
#    observations in `terms_mentions` that have a match in `mentions` and
#    assign the resulting tibble to `diagnosis`. If the join went as expected
#    `diagnosis` should be an empty tibble and print to:
#    # A tibble: 0 x 4
#    # … with 4 variables: term <chr>, year <int>, n_mentions <int>,
#    # book_count <int>
## Do not modify this line!
diagnosis <- terms_mentions %>%
  anti_join(mentions)
diagnosis

# 5. Do the following:
#    - starting with `mentions`, add a column `frac_total` that computes the
#    frequency of mentions of each term per year (divides the number of
#    mentions of each term per year by the total number of mentions of all
#    terms that year),
#    - select only columns `term`, `year`, `n_mentions`, `total_mentions` and
#    `frac_total`.
#    Assign the resulting tibble to `relative_mention_counts`.
#    Hint: you can use `mutate()` and `select()`.
#    `relative_mention_counts` should print to:
#    # A tibble: 53,393 x 5
#       term   year n_mentions total_mentions  frac_total
#       <chr> <int>      <int>          <dbl>       <dbl>
#     1 1817   1524         31         287177 0.000108
#     2 1817   1575         17         186706 0.0000911
#     3 1817   1607          3         381763 0.00000786
#     4 1817   1637          2         681719 0.00000293
#     5 1817   1662          1         239762 0.00000417
#     6 1817   1675          5        1644156 0.00000304
#     7 1817   1693          8        1038415 0.00000770
#     8 1817   1705          1        4908749 0.000000204
#     9 1817   1708          1        6481151 0.000000154
#    10 1817   1713          1        4720647 0.000000212
#    # … with 53,383 more rows
## Do not modify this line!
relative_mention_counts <- mentions %>%
  mutate(frac_total = n_mentions / total_mentions) %>%
  select(term, year, n_mentions, total_mentions, frac_total)
relative_mention_counts

# 6. Load the `forcats` package.
#    To prepare the tibble to build the figure with:
#    - keep only the terms `"1883"`, `"1910"` and `"1950"`,
#    - transform the terms from characters to a factor in which the levels
#      are in reversed alphabetical order ("1950", "1910" and "1883")
#    Assign the result to `examples_mention_counts`.
#    Hint: you can use `filter()`, `mutate()` and `fct_rev()` to reverse the
#    order of levels of a factor.
#    Note: the order matters to us to reproduce the same colors as the original
#    figure without setting them explicitely when generating the plot.
#    `examples_mentions_counts` should print to:
#    # A tibble: 825 x 5
#       term   year n_mentions total_mentions frac_total
#      <fct> <int>      <int>          <dbl>      <dbl>
#     1 1883   1515          1         289011 0.00000346
#     2 1883   1520          1          51783 0.0000193
#     3 1883   1524         15         287177 0.0000522
#     4 1883   1574          4          62235 0.0000643
#     5 1883   1575          3         186706 0.0000161
#     6 1883   1584          1         151925 0.00000658
#     7 1883   1607          2         381763 0.00000524
#     8 1883   1637          5         681719 0.00000733
#     9 1883   1643          1         177489 0.00000563
#    10 1883   1644          3        1018174 0.00000295
#    # … with 815 more rows
## Do not modify this line!
library(forcats)
examples_mention_counts <- relative_mention_counts %>%
  filter(term %in% c(1883, 1910, 1950)) %>%
  mutate(term = fct_rev(as.factor(term)) )
examples_mention_counts
  


# 7. Load the `ggplot2` and `scales` packages.
#    Generate a plot to reproduce the large window of figure 3a and assign the
#    result to `paper_figure`.
#    To do so, you can, in the following order:
#    - create a plot from `examples_mention_counts` using `ggplot()` with the
#    appropriate columns assigned in the aesthetic's `x`, `y` and `color`
#    arguments,
#    - add the lines using `geom_line()`,
#    - add `scale_y_continuous(label = percent)` to set the y-axis ticks to
#      the percent format,
#    - limit the coordinates to show only the mentions across the timeframe
#     `1850`-`2012` using `coord_cartesian()` and its argument `xlim`,
#    - use `labs()` to:
#         - set `title` to `"Are we forgetting the past faster?"`
#         - set `x` to `"Year"'
#         - set `y` to `"Frequency of mention of each term"`
#         - set `color` to `Term`
#    - finally add `theme_light()` for a clear plot
## Do not modify this line!
library(ggplot2)
library(scales)
paper_figure <- ggplot(data = examples_mention_counts, mapping = aes(x = year, y = frac_total, col = term)) +
  geom_line() +
  scale_y_continuous(label = percent) +
  coord_cartesian(xlim = c(1850, 2012)) +
  labs(title = "Are we forgetting the past faster?",
       x = "Year",
       y = "Frequency of mention of each term",
       color = "Term") +
  theme_light()
paper_figure



