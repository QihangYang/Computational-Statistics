# HW5: Data manipulation
#'
# 1. Load the `tidyr` and `dplyr` package and use `data` to read in the `billboard` data which describes
#    Song rankings for billboard top 100 in the year 2000.
#    Now let's start analyze the dataset!
#    For the following exercises, use the pipe operator `%>%` as much as you can.
## Do not modify this line!
library(tidyr)
library(dplyr)
data(billboard)



# 2. Let's take a look at the `billboard` data, we notice that there're 79 columns in total
#    and 76 columns to represent the rankings of each week.
#    Put the week name into one column called `week` and store the ranking
#    into another column called `rank`, keep the first three column names, save the new tibble
#    dataframe into `t1`, which will have 24,092 rows and 5 columns.
#    Hint: you can use `pivot_longer` and `starts_with`.
#    To check your solution, it should print to:
#    # A tibble: 24,092 x 5
#      artist track                   date.entered week   rank
#      <chr>  <chr>                   <date>       <chr> <dbl>
#    1 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk1      87
#    2 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk2      82
#    3 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk3      72
#    4 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk4      77
#    5 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk5      87
#    6 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk6      94
#    7 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk7      99
#    8 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk8      NA
#    9 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk9      NA
#    10 2 Pac  Baby Don't Cry (Keep... 2000-02-26   wk10     NA
#    # ... with 24,082 more rows
## Do not modify this line!
t1 <- billboard %>%
  pivot_longer(-c("artist","track", "date.entered"), names_to = "week", values_to = "rank")
t1

# 3. We can notice that in `t1`,
#    1. The rank includes a lot of `NA` values,
#    2. The `wk` in front of each `week` is redundant.
#    So now do the same thing as the previous question, but this time drop the `NA` values and
#    change `wk<number>` to `<number>` for the `week` column as well.
#    Hint: to do so, you can start from `billboard` dataset and use `pivot_longer` along with the
#    `names_prefix` and `values_drop_na` arguments.
#    Save your result into `t2`.
#    Your new `t2` should have 5307 rows and 5 columns.
#    To check your solution, it should print to:
#    # A tibble: 5,307 x 5
#       artist  track                   date.entered week   rank
#       <chr>   <chr>                   <date>       <chr> <dbl>
#    1 2 Pac   Baby Don't Cry (Keep... 2000-02-26   1        87
#    2 2 Pac   Baby Don't Cry (Keep... 2000-02-26   2        82
#    3 2 Pac   Baby Don't Cry (Keep... 2000-02-26   3        72
#    4 2 Pac   Baby Don't Cry (Keep... 2000-02-26   4        77
#    5 2 Pac   Baby Don't Cry (Keep... 2000-02-26   5        87
#    6 2 Pac   Baby Don't Cry (Keep... 2000-02-26   6        94
#    7 2 Pac   Baby Don't Cry (Keep... 2000-02-26   7        99
#    8 2Ge+her The Hardest Part Of ... 2000-09-02   1        91
#    9 2Ge+her The Hardest Part Of ... 2000-09-02   2        87
#    10 2Ge+her The Hardest Part Of ... 2000-09-02   3        92
#    # ... with 5,297 more rows
## Do not modify this line!
t2 <- billboard %>%
  pivot_longer(-c("artist","track", "date.entered"), names_to = "week", values_to = "rank", names_prefix = "wk", values_drop_na = TRUE)
t2


# 4. Now we want to check the highest rank increase within one week.
#    For example for the first track `Baby Don't Cry (Keep...`, its weekly ranking is
#    87, 82, 72, 77, 87, 94, 99, so the highest rank increase will be 82-72=10 from week2 to week3.
#    For each track, compute its highest rank increase, save the answer in the column `highest_rank_increase`.
#    To do that, you can use:
#    - `mutate` and `lag` to calculate the rank difference.
#    - `filter` to filter out the information for week 1
#    (because week 1 is the first week for which the song has a rank thus there is no rank increase).
#    - `summarize`and `group_by` to find out the maximum of rank difference.
#    Save your answer into `t2_rank`, which should include 313 rows and 4 columns:
#    `artist`, `track`, `date.entered` and `highest_rank_increase`.
#    To check your solution, it should print to:
#    # A tibble: 313 x 4
#    # Groups:   artist, track [313]
#    artist         track                   date.entered highest_rank_increase
#    <chr>          <chr>                   <date>                       <dbl>
#    1 2 Pac          Baby Don't Cry (Keep... 2000-02-26                      10
#    2 2Ge+her        The Hardest Part Of ... 2000-09-02                       4
#    3 3 Doors Down   Kryptonite              2000-04-08                      11
#    4 3 Doors Down   Loser                   2000-10-21                      10
#    5 504 Boyz       Wobble Wobble           2000-04-15                      23
#    6 98^0           Give Me Just One Nig... 2000-08-19                      17
#    7 A*Teens        Dancing Queen           2000-07-08                       1
#    8 Aaliyah        I Don't Wanna           2000-01-29                      22
#    9 Aaliyah        Try Again               2000-03-18                      15
#    10 Adams, Yolanda Open My Heart           2000-08-26                       8
#    ... with 303 more rows
## Do not modify this line!
t2_rank <- t2 %>%
  mutate(rank_increase = lag(rank) - rank) %>%
  filter(week != 1) %>%
  group_by(artist, track, date.entered) %>%
  summarize(highest_rank_increase = max(rank_increase))
t2_rank


# 5. We want to have `year`, `month` and `date` information seperately.
#    We can use `seperate` function to seperate  `2000-02-26` of `date.entered` into `year` :`2000`,
#    `month`: `02`, and `date`: `26`.
#    Save your result into `t3`.
#    Your new dataframe should not have `data.entered` column and should have 5307 rows and seven columns in total:
#    `artist`, `track`, `year`, `month`, `date`, `week` and `rank`.
#    To check your solution, it should print to:
#    # A tibble: 5,307 x 7
#       artist  track                   year  month date  week   rank
#       <chr>   <chr>                   <chr> <chr> <chr> <chr> <dbl>
#    1 2 Pac   Baby Don't Cry (Keep... 2000  02    26    1        87
#    2 2 Pac   Baby Don't Cry (Keep... 2000  02    26    2        82
#    3 2 Pac   Baby Don't Cry (Keep... 2000  02    26    3        72
#    4 2 Pac   Baby Don't Cry (Keep... 2000  02    26    4        77
#    5 2 Pac   Baby Don't Cry (Keep... 2000  02    26    5        87
#    6 2 Pac   Baby Don't Cry (Keep... 2000  02    26    6        94
#    7 2 Pac   Baby Don't Cry (Keep... 2000  02    26    7        99
#    8 2Ge+her The Hardest Part Of ... 2000  09    02    1        91
#    9 2Ge+her The Hardest Part Of ... 2000  09    02    2        87
#    10 2Ge+her The Hardest Part Of ... 2000  09    02    3        92
#    # ... with 5,297 more rows
## Do not modify this line!
t3 <- t2 %>%
  separate(date.entered,
           into = c("year", "month", "date"))
t3

# 6. Use `group_by` to group `t3` by `artist`, `track` and `month`.
#    Use `summarize` to add another column called `highest_rank`,
#    which represent the highest rank in year 2000 for each song.
#    Save your result into `t4` which will have 317 rows and 4 columns.
#    To check your solution, it should print to:
#    # A tibble: 317 x 4
#    # Groups:   artist, track [317]
#     artist         track                   month highest_rank
#     <chr>          <chr>                   <chr>        <dbl>
#    1 2 Pac          Baby Don't Cry (Keep... 02              72
#    2 2Ge+her        The Hardest Part Of ... 09              87
#    3 3 Doors Down   Kryptonite              04               3
#    4 3 Doors Down   Loser                   10              55
#    5 504 Boyz       Wobble Wobble           04              17
#    6 98^0           Give Me Just One Nig... 08               2
#    7 A*Teens        Dancing Queen           07              95
#    8 Aaliyah        I Don't Wanna           01              35
#    9 Aaliyah        Try Again               03               1
#    10 Adams, Yolanda Open My Heart           08              57
#    # ... with 307 more rows
## Do not modify this line!
t4 <- t3 %>%
  group_by(artist, track, month) %>%
  summarize(highest_rank = min(rank))
t4


# 7. Let's go back to the original `billborad`, we want to analyze the highest ranks of the songs
#    in their first week of realse.
#    Fisrt use `filter` to filter out the `NA` values in `wk1` if there's any.
#    Then use `arrange` to output the songs in the ranking order for `wk1` (increasing order of rank).
#    Finally use `select` to include only the columns we're interested in:
#    `artist`, `track`, `date.entered` and `wk1_rank`
#    Save your result into `t5`, which has 317 rows and 4 columns.
#    To check your solution, it should print to:
#    # A tibble: 317 x 4
#       artist                           track             date.entered wk1_rank
#       <chr>                            <chr>             <date>          <dbl>
#    1 Santana                          Maria, Maria      2000-02-12         15
#    2 Hanson                           This Time Around  2000-04-22         22
#    3 Pink                             There U Go        2000-03-04         25
#    4 Carey, Mariah                    Crybaby           2000-06-24         28
#    5 "Elliott, Missy \"Misdemeanor\"" Hot Boyz          1999-11-27         36
#    6 Martin, Ricky                    She Bangs         2000-10-07         38
#    7 Backstreet Boys, The             Shape Of My Heart 2000-10-14         39
#    8 Dixie Chicks, The                Goodbye Earl      2000-03-18         40
#    9 Madonna                          Music             2000-08-12         41
#    10 N'Sync                           Bye Bye Bye       2000-01-29         42
#    # ... with 307 more rows
## Do not modify this line!
t5 <-  billboard %>%
  filter(!is.na(wk1)) %>%
  arrange(wk1) %>%
  select(artist, track, date.entered, wk1_rank = wk1)
t5


# 8. Now let's only focusing on the songs released in 2000, use your result in question 2 `t1`.
#    Use `filter` and `startsWith` to filter out the songs released in 1999.
#    Then use `group_by` and `summarize` to calculate the average of ranks of songs for each artist.
#    Your answer should include 2 columns :`artist` and `avg_rank` and 204 rows.
#    Save your reult into `t6`.
#    To check your solution, it should print to:
#    # A tibble: 204 x 2
#       artist              avg_rank
#       <chr>                  <dbl>
#    1 2 Pac                   85.4
#    2 2Ge+her                 90
#    3 3 Doors Down            37.6
#    4 504 Boyz                56.2
#    5 98^0                    37.6
#    6 A*Teens                 97
#    7 Aaliyah                 30.3
#    8 Adams, Yolanda          67.8
#    9 Adkins, Trace           76.3
#    10 Aguilera, Christina     22.1
#    # ... with 194 more rows
#'
## Do not modify this line!
t6 <- t1 %>%
  separate(date.entered, into = c("year", "month", "date")) %>%
  filter(year == 2000) %>%
  group_by(artist) %>%
  summarize(avg_rank = mean(rank, na.rm = TRUE))
t6



