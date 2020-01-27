# HW5: tidyr
#'
# 1. Load the `tidyr`, `dplyr` and `readr` packages.
#    Use `read_csv` to load the `useR2016.csv` data set from `data` folder and
#    save it as `useR2016`.
#    Use `select` to select columns `Q2` to `Q13_F` except `Q12`, and column `Q25`
#    as well. Save the selected dataset into a tibble `t1` of dimension 455 x 12.
#    To check your solution, `t1` prints to:
#    # A tibble: 455 x 12
#    Q2    Q3     Q7     Q8     Q11    Q13    Q13_B  Q13_C  Q13_D Q13_E Q13_F    Q25
#    <chr> <chr>  <chr>  <chr>  <chr>  <chr>  <chr>  <chr>  <chr> <chr> <chr>  <dbl>
#    Men   > 35   Docto… Acade… > 10 … I use… I wri… I wri… NA    NA    NA       442
#    Men   > 35   Maste… Non-a… 2-5 y… NA     NA     NA     NA    NA    NA       665
#    Women 35 or… Maste… Non-a… < 2 y… I use… NA     NA     NA    NA    NA       118
#    Men   35 or… Docto… Acade… NA     NA     NA     NA     NA    NA    NA       906
#    Men   35 or… Maste… Non-a… 2-5 y… I use… I wri… I wri… NA    NA    NA       650
#    Women 35 or… Docto… Non-a… 5-10 … I use… I wri… I wri… NA    I ha… NA       800
#    Men   > 35   Docto… Non-a… > 10 … I use… I wri… I wri… I co… I ha… I hav…    83
#    Women NA     Docto… Non-a… > 10 … I use… I wri… I wri… NA    I ha… NA       668
#    Women > 35   Docto… Acade… > 10 … I use… NA     I wri… I co… NA    NA       566
#    Men   35 or… Maste… Non-a… 2-5 y… I use… I wri… I wri… NA    I ha… I hav…   416
#    # … with 445 more rows
## Do not modify this line!
library(tidyr)
library(dplyr)
library(readr)
library(tibble)
useR2016 <- read_csv("data/useR2016.csv") 
t1 <- useR2016 %>%
  select(Q2 : Q13_F, Q25) %>%
  select(-(Q12))
t1



# 2. Build a tibble `t1_longer` of dimension 1767 x 8, which contains columns
#    `Q2`, `Q3`, `Q7`, `Q8`, `Q11`, `Q25`, `cases` and `comments`.
#    `cases` are reprensented by `Q13`, `Q13_B`, `Q13_C`, `Q13_D`, `Q13_E`, `Q13_F`,
#    and `comments`are the values contained in these columns, without the `NA` values.
#    To do that, you can use:
#      - `pivot_longer` to gather `t1` from `Q13` to `Q13_F`.
#      - `names_to` as 'cases' and `values_to` as 'comments' and also drop all NAs
#      (hint: look at the `values_drop_na` argument).
#    To check your solution, `t1` prints to:
#    # A tibble: 1,767 x 8
#    Q2    Q3      Q7         Q8      Q11      Q25 cases comments
#    <chr> <chr>   <chr>      <chr>   <chr>  <dbl> <chr> <chr>
#    Men   > 35    Doctorate… Academ… > 10 …   442 Q13   I use functions from exist…
#    Men   > 35    Doctorate… Academ… > 10 …   442 Q13_B I write R code designed to…
#    Men   > 35    Doctorate… Academ… > 10 …   442 Q13_C I write R functions for us…
#    Women 35 or … Masters o… Non-ac… < 2 y…   118 Q13   I use functions from exist…
#    Men   35 or … Masters o… Non-ac… 2-5 y…   650 Q13   I use functions from exist…
#    Men   35 or … Masters o… Non-ac… 2-5 y…   650 Q13_B I write R code designed to…
#    Men   35 or … Masters o… Non-ac… 2-5 y…   650 Q13_C I write R functions for us…
#    Women 35 or … Doctorate… Non-ac… 5-10 …   800 Q13   I use functions from exist…
#    Women 35 or … Doctorate… Non-ac… 5-10 …   800 Q13_B I write R code designed to…
#    Women 35 or … Doctorate… Non-ac… 5-10 …   800 Q13_C I write R functions for us…
#    # … with 1,757 more rows
## Do not modify this line!
t1_longer <- t1 %>%
  pivot_longer(Q13 : Q13_F) %>%
  rename(cases = name, comments = value) %>%
  drop_na(comments) 
t1_longer



# 3. Build a tibble `t1_longer_rename` of dimension 1767 x 8.
#    You may use `rename` to rename `t1_longer`.
#    - Assign `sex` to `Q2`.
#    - Assign `age` to `Q3`.
#    - Assign `degree` to `Q7`.
#    - Assign `academic_status` to `Q8`.
#    - Assign `experience` to `Q11`.
#    - Assign `value` to `Q25`.
#    To check your solution, `t1_longer_rename` prints to:
#    # A tibble: 1,767 x 8
#    sex   age    degree    academic_status experience value cases comments
#    <chr> <chr>  <chr>     <chr>           <chr>      <dbl> <chr> <chr>
#    Men   > 35   Doctorat… Academic        > 10 years   442 Q13   I use functions …
#    Men   > 35   Doctorat… Academic        > 10 years   442 Q13_B I write R code d…
#    Men   > 35   Doctorat… Academic        > 10 years   442 Q13_C I write R functi…
#    Women 35 or… Masters … Non-academic    < 2 years    118 Q13   I use functions …
#    Men   35 or… Masters … Non-academic    2-5 years    650 Q13   I use functions …
#    Men   35 or… Masters … Non-academic    2-5 years    650 Q13_B I write R code d…
#    Men   35 or… Masters … Non-academic    2-5 years    650 Q13_C I write R functi…
#    Women 35 or… Doctorat… Non-academic    5-10 years   800 Q13   I use functions …
#    Women 35 or… Doctorat… Non-academic    5-10 years   800 Q13_B I write R code d…
#    Women 35 or… Doctorat… Non-academic    5-10 years   800 Q13_C I write R functi…
#    # … with 1,757 more rows
## Do not modify this line!
t1_longer_rename <- t1_longer %>%
  rename(
    sex = Q2, 
    age = Q3,
    degree = Q7,
    academic_status = Q8,
    experience = Q11,
    value = Q25
  )
t1_longer_rename



# 4. Extract a tibble `separate_drop_redundant` from `t1_longer_rename` of dimension 1767 x 8.
#    This tibble doesn't contain the column `cases` anymore but the column `category`.
#    It is equal to `A` if `cases = Q13`, `B` if `cases = Q13_B`, `C` if `cases = Q13_C`
#    To do that you can separate `cases` into 2 columns called `case_name` and `category`
#    fill in NAs with `A` in `category`, and then delete `case_name`.
#    You may use:
#      - `separate` to separate column `cases` into `case_name` and `category`
#      from `t1_longer_rename`. Set `fill` as `right` and look at the `sep` argument.
#      - `replace_na` with `list(category = 'A')` to replace all NAs in `category` to `A`.
#      - `select` to drop column `case_name`.
#    To check your solution, `separate_drop_redundant` prints to:
#    # A tibble: 1,767 x 8
#    sex   age    degree   academic_status experience value category comments
#    <chr> <chr>  <chr>    <chr>           <chr>      <dbl> <chr>    <chr>
#    Men   > 35   Doctora… Academic        > 10 years   442 A        I use function…
#    Men   > 35   Doctora… Academic        > 10 years   442 B        I write R code…
#    Men   > 35   Doctora… Academic        > 10 years   442 C        I write R func…
#    Women 35 or… Masters… Non-academic    < 2 years    118 A        I use function…
#    Men   35 or… Masters… Non-academic    2-5 years    650 A        I use function…
#    Men   35 or… Masters… Non-academic    2-5 years    650 B        I write R code…
#    Men   35 or… Masters… Non-academic    2-5 years    650 C        I write R func…
#    Women 35 or… Doctora… Non-academic    5-10 years   800 A        I use function…
#    Women 35 or… Doctora… Non-academic    5-10 years   800 B        I write R code…
#    Women 35 or… Doctora… Non-academic    5-10 years   800 C        I write R func…
#    # … with 1,757 more rows
## Do not modify this line!
separate_drop_redundant <- t1_longer_rename %>%
  separate(cases,
           into = c("case_name", "category"),
           fill = "right") %>%
  replace_na(list(category = 'A')) %>%
  select(-case_name)
separate_drop_redundant


# 5. Extract a tibble `filter_na_unite` from `separate_drop_redundant`` of dimension 1764 x 7.
#    The dataset should not contain any NAs in `age` and `experience` (It filters out `NA`).
#    Then unite `age` and `experience` into  a column `age_and_experience` separated by ` && `.
#    To do that, you can use:
#      - `filter` to filter out NAs in `age` and `experience` from `separate_drop_redundant`.
#      - `unite` to unite `age` and `experience` into `age_and_experience`, make `sep` as ` && `.
#    To check your solution, `filter_na_unite` prints to:
#    # A tibble: 1,662 x 7
#    sex   age_and_experien… degree academic_status value category comments
#    <chr> <chr>             <chr>  <chr>           <dbl> <chr>    <chr>
#    Men   > 35 && > 10 yea… Docto… Academic          442 A        I use fu…
#    Men   > 35 && > 10 yea… Docto… Academic          442 B        I write …
#    Men   > 35 && > 10 yea… Docto… Academic          442 C        I write …
#    Women 35 or under && <… Maste… Non-academic      118 A        I use fu…
#    Men   35 or under && 2… Maste… Non-academic      650 A        I use fu…
#    Men   35 or under && 2… Maste… Non-academic      650 B        I write …
#    Men   35 or under && 2… Maste… Non-academic      650 C        I write …
#    Women 35 or under && 5… Docto… Non-academic      800 A        I use fu…
#    Women 35 or under && 5… Docto… Non-academic      800 B        I write …
#    Women 35 or under && 5… Docto… Non-academic      800 C        I write …
#    # … with 1,652 more rows
## Do not modify this line!
filter_na_unite <- separate_drop_redundant %>%
  filter(!is.na(age) & !is.na(experience)) %>%
  unite(age_and_experience, age, experience, sep = " && ")
filter_na_unite


# 6. Extract a tibble `first_100_rank` of dimension 100 x 8.
#    The dataset should contain the 100 datapoints with highest `value`, and contain
#    a column `row_number` that gives the rank of each datapoint (with 1 being the
#    lowest `value` and 100 the highest)
#    To do that, you can use
#      - `mutate` and `row_number` to rank `value` from `filter_na_unite`.
#      Name the new column as `row_number`.
#      - `filter` to filter out `row_number` less than or equal to `100`.
#    To check your solution, `first_100_rank` prints to:
#    # A tibble: 100 x 8
#    sex   age_and_experien… degree academic_status value category comments row_number
#    <chr> <chr>             <chr>  <chr>           <dbl> <chr>    <chr>       <int>
#    Men   > 35 && 5-10 yea… Docto… Non-academic       52 C        I write…       87
#    Men   > 35 && > 10 yea… Docto… Academic           18 A        I use f…       14
#    Men   > 35 && > 10 yea… Docto… Academic           18 B        I write…       15
#    Men   > 35 && > 10 yea… Docto… Academic           18 C        I write…       16
#    Men   > 35 && > 10 yea… Docto… Academic           18 D        I contr…       17
#    Men   > 35 && > 10 yea… Docto… Academic           18 E        I have …       18
#    Men   > 35 && > 10 yea… Docto… Academic           18 F        I have …       19
#    Women > 35 && > 10 yea… Maste… Non-academic       22 A        I use f…       26
#    Women > 35 && > 10 yea… Maste… Non-academic       22 B        I write…       27
#    Women > 35 && > 10 yea… Maste… Non-academic       22 C        I write…       28
#    # … with 90 more rows
## Do not modify this line!
first_100_rank <- filter_na_unite %>%
  mutate(row_number = row_number(value)) %>%
  filter(row_number <= 100)
first_100_rank



# 7. Extract from `t1_longer_rename` a tibble `experience_percentage` of dimension 2 x 5,
#    which contains a `sex` column and 4 additional columns representing the percentage
#    of people per experience level, and 2 rows for `Men` and `Women`.
#    The dataset should be grouped by `sex` with counted numbers
#    of each experience level.
#    Then the counts can be normalized into percentages.
#    Some tidying will make a nice table to show the final numbers.
#    To do that, you can use
#      - `drop_na` to drop NAs on `df_longer`.
#      - `group_by` using the `sex` variable.
#      - `count` to count the cases per experience level and use
#      the name argument as `count`.
#      - `mutate` to normalize the `count` column into a percentage using
#      `count / sum(count) * 100`.
#      - `pivot_wider` to convert from a long table into a wide table.
#    To check your solution, `experience_percentage` prints to:
#    # A tibble: 2 x 5
#    # Groups:   sex [2]
#    sex   `< 2 years` `> 10 years` `2-5 years` `5-10 years`
#    <chr>       <dbl>        <dbl>       <dbl>        <dbl>
#    Men          6.90         36.0        25.0         32.1
#    # … with 1 more row
## Do not modify this line!
experience_percentage <- t1_longer_rename %>%
  drop_na %>%
  group_by(sex, experience) %>%
  count(experience, name = "count") %>%
  group_by(sex) %>%
  mutate(count = count / sum(count) * 100) %>%
  pivot_wider(names_from = "experience", values_from = "count")
experience_percentage



