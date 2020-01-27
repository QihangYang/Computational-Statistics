# HW7: NYC stock analysis
#'
# In this exercise, you will conduct complete data analysis on NYC stock price.
#'
# Dataset consists of following files:
# `prices.csv`: raw, as-is daily prices. Most of data spans from 2010 to the end 2016,
#             for companies new on stock market date range is shorter.
#             There have been approximmately 140 stock splits in that time,
#             this set doesn't account for that.
# `securities.csv`: general description of each company with division on sectors
# `fundamentals.csv`: metrics extracted from annual SEC 10K fillings (2012-2016),
#              should be enough to derive most of popular fundamental indicators.
#'
# 1. Do the following:
#      - load the `readr`, `dplyr` and `tidyr` package
#      - load `/course/data/prices.csv` using `read_csv()` and save it to `raw`.
#      - load `data/securities.csv` using `read_csv()` and save it to `sectors`.
#      - load `data/fundamentals.csv` using `read_csv()` and save it to `fund`.
#    `raw` should look like:
#    # A tibble: 851,264 x 7
#    date                symbol  open close   low  high  volume
#    <dttm>              <chr>  <dbl> <dbl> <dbl> <dbl>   <dbl>
#    1 2016-01-05 00:00:00 WLTW    123.  126.  122.  126. 2163600
#    2 2016-01-06 00:00:00 WLTW    125.  120.  120.  126. 2386400
#    3 2016-01-07 00:00:00 WLTW    116.  115.  115.  120. 2489500
#    4 2016-01-08 00:00:00 WLTW    115.  117.  114.  117. 2006300
#    5 2016-01-11 00:00:00 WLTW    117.  115.  114.  117. 1408600
#    6 2016-01-12 00:00:00 WLTW    116.  116.  114.  116. 1098000
#    7 2016-01-13 00:00:00 WLTW    116.  113.  113.  117.  949600
#    8 2016-01-14 00:00:00 WLTW    114.  114.  110.  115.  785300
#    9 2016-01-15 00:00:00 WLTW    113.  113.  112.  115. 1093700
#    10 2016-01-19 00:00:00 WLTW    114.  110.  110.  116. 1523500
#    # … with 851,254 more rows
#    `securities` should look like:
#    # A tibble: 505 x 8
#    `Ticker symbol` Security `SEC filings` `GICS Sector`
#    <chr>           <chr>    <chr>         <chr>
#    1 MMM             3M Comp… reports       Industrials
#    2 ABT             Abbott … reports       Health Care
#    3 ABBV            AbbVie   reports       Health Care
#    4 ACN             Accentu… reports       Information …
#    5 ATVI            Activis… reports       Information …
#    6 AYI             Acuity … reports       Industrials
#    7 ADBE            Adobe S… reports       Information …
#    8 AAP             Advance… reports       Consumer Dis…
#    9 AES             AES Corp reports       Utilities
#    10 AET             Aetna I… reports       Health Care
#    # … with 495 more rows, and 4 more variables: `GICS Sub
#    #   Industry` <chr>, `Address of Headquarters` <chr>, `Date first
#    #   added` <date>, CIK <chr>
#    `fund` should print to:
#    # A tibble: 1,781 x 79
#    X1 `Ticker Symbol` `Period Ending` `Accounts Payab…
#    <dbl> <chr>           <date>                     <dbl>
#    1     0 AAL             2012-12-31            3068000000
#    2     1 AAL             2013-12-31            4975000000
#    3     2 AAL             2014-12-31            4668000000
#    4     3 AAL             2015-12-31            5102000000
#    5     4 AAP             2012-12-29            2409453000
#    6     5 AAP             2013-12-28            2609239000
#    7     6 AAP             2015-01-03            3616038000
#    8     7 AAP             2016-01-02            3757085000
#    9     8 AAPL            2013-09-28           36223000000
#    10     9 AAPL            2014-09-27           48649000000
#    # … with 1,771 more rows, and 75 more variables: `Accounts
#    #   Receivable` <dbl>, `Add'l income/expense items` <dbl>, `After Tax
#    #   ROE` <dbl>, etc...
## Do not modify this line!
library(readr)
library(dplyr)
library(tidyr)
raw <- read_csv("/course/data/prices.csv")
securities <- read_csv("data/securities.csv")
fund <- read_csv("data/fundamentals.csv")



# 2. Load the `stringr` and `lubridate` packages.
#    Currently, the date in `raw` are in `UTC` time. We want to convert them
#    to New York time zone.
#    To do so, you can:
#      - use `mutate()` to convert the date column
#      - use `force_tz()` to format the date, with argument
#      ` tz` set to `America/New_York`.
#  Save the generated tibble into `raw_time`.
#  `raw_time$date` should be in this format:
#  [1] "2016-01-05 EST" "2016-01-06 EST" "2016-01-07 EST" "2016-01-08 EST"..
#  [6] "2016-01-12 EST" "2016-01-13 EST" "2016-01-14 EST" "2016-01-15 EST"..
## Do not modify this line!
library(stringr)
library(lubridate)
raw_time <- raw %>% 
  mutate(date = force_tz(date, tz = "America/New_York"))
raw_time



# 3. Load the package `forcats`.
#    In `securities`, keep the companies belonging to the top 6 sectors
#    (by frequency of occurence), as well as those whose `GICS Sub Industry`
#    falls into `"Gold"` or `"Real Estate`" (i.e., `GICS Sub Industry` contains
#    either `"Gold"` or `"REITs"`).
#    You need to do it in three steps:
#      - First, use `mutate()` and `factor()` to convert the `GICS Sector`
#        variable of `securities` from character to a factor. Its levels should
#        be the `unique()` values of `GICS Sector`.
#      - Second, create a tibble named `securities_sectored` that contain
#        only the companies that do not belong to those that you want (see below).
#        Note that `securities_sectored` should contain an additional column
#        `GICS Sector truncated` that contains the top 6 factors in `GICS Sector`
#        and all the others lumped into an additional level `"Other"`.
#      - Third, use `anti_join()` on `securities` and `securities_sectored` to
#        create `securities_selected`, which contains only the rows that actually
#        meet the requirements above by deleting the rows from `securities`
#        that are in `securities_sectored`.
#    To achieve the second step, you can use:
#        - `mutate()` along with `fct_infreq()` and `fct_lump()` to
#          reorder the sectors by frequency of occurence and lump
#          all except the top 6 into a single level `"Other"`.
#        - `filter()` to select the sectors that do not belong to the
#          top 6 (i.e., the ones with the level `"Other"`).
#        - `filter()`  along with `str_detect()` to additionally filter out
#           the observations whose `GICS Sub Industry` contains neither
#           `"Gold"` nor `"REITs"`. In the pattern, you can use a
#           regular expression with or (represented by the alternation
#           symbol `"|"`) to do that.
#    To help you, `securities` is as in part 1, except that the `GICS Sector`
#    column is a factor whose levels print to
#    `Levels: Industrials ... Telecommunications Services`.
#    `securities_sectored` should print to:
#    # A tibble: 94 x 9
#    `Ticker symbol` Security `SEC filings` `GICS Sector`
#    <chr>           <chr>    <chr>         <fct>
#    1 AES             AES Corp reports       Utilities
#    2 APD             Air Pro… reports       Materials
#    3 ALB             Albemar… reports       Materials
#    4 LNT             Alliant… reports       Utilities
#    5 AEE             Ameren … reports       Utilities
#    6 AEP             America… reports       Utilities
#    7 AWK             America… reports       Utilities
#    8 APC             Anadark… reports       Energy
#    9 APA             Apache … reports       Energy
#    10 T               AT&T Inc reports       Telecommunic…
#    # … with 84 more rows, and 5 more variables: `GICS Sub
#    #   Industry` <chr>, `Address of Headquarters` <chr>, `Date first
#    #   added` <date>, CIK <chr>, `GICS Sector truncated` <fct>
#    `securities_selected` should print to:
#    # A tibble: 411 x 8
#    `Ticker symbol` Security `SEC filings` `GICS Sector`
#    <chr>           <chr>    <chr>         <fct>
#    1 MMM             3M Comp… reports       Industrials
#    2 ABT             Abbott … reports       Health Care
#    3 ABBV            AbbVie   reports       Health Care
#    4 ACN             Accentu… reports       Information …
#    5 ATVI            Activis… reports       Information …
#    6 AYI             Acuity … reports       Industrials
#    7 ADBE            Adobe S… reports       Information …
#    8 AAP             Advance… reports       Consumer Dis…
#    9 AET             Aetna I… reports       Health Care
#    10 AMG             Affilia… reports       Financials
#    # … with 401 more rows, and 4 more variables: `GICS Sub
#    #   Industry` <chr>, `Address of Headquarters` <chr>, `Date first
#    #   added` <date>, CIK <chr>
## Do not modify this line!
library(forcats)
securities <- securities %>%
  mutate(`GICS Sector` = factor(`GICS Sector`, levels = unique(`GICS Sector`))) 

securities_sectored <- securities%>%
  mutate(`GICS Sector truncated` = fct_lump(fct_infreq(`GICS Sector`), n = 6)) %>%
  filter(`GICS Sector truncated` == "Other") %>%
  filter(!str_detect(`GICS Sub Industry`, "Gold|REITs"))
securities_sectored

securities_selected <- securities %>%
  anti_join(securities_sectored)
securities_selected


#    4. Convert the column name of `fund` from `Ticker Symbol`
#    to `Ticker symbol`. (This makes sure there is consistency between
#    column names of the different tables!).
#    Then create new column `Period Ending Year` to extract the year from
#    `Period Ending`. Then Drop NA values of `fund`. Select columns `Ticker symbol`,
#    `Period Ending Year` and `Gross Margin`.
#    Save the new tibble as `fund_time`.
#    To do that, you can use:
#      - `dplyr::rename()` to convert the column name.
#      - `mutate()` to create column `Period Ending Year`, inside `mutate()`:
#         - use `str_replace_all()` to first convert "/" to "-".
#         - `mdy()` with `tz` set to `"America/New_York"` to convert the date
#            to EDT time zone.
#         - `year()` to extract the year.
#         (You can use pipe %>% on `Period Ending` inside `mutate()`)
#      - `drop_na()` to drop the rows that contain `NA` values.
#      - `dplyr::select()` to select the intested columns.
#    `fund_time` should look like:
#    # A tibble: 1,299 x 3
#    `Ticker symbol` `Period Ending Year` `Gross Margin`
#    <chr>                          <dbl>          <dbl>
#    1 AAL                             2012             58
#    2 AAL                             2013             59
#    3 AAL                             2014             63
#    4 AAL                             2015             73
#    5 AAP                             2012             50
#    6 AAP                             2013             50
#    7 AAP                             2015             45
#    8 AAP                             2016             45
#    9 AAPL                            2013             38
#    10 AAPL                            2014             39
#    # … with 1,289 more rows
## Do not modify this line!
fund_time <- fund %>%
  rename("Ticker symbol" = `Ticker Symbol`) %>%
  mutate("Period Ending Year" = (`Period Ending` %>%
           str_replace_all("/", "-") %>%
           mdy(tz = "America/New_York") %>%
           year()
           )) %>%
  drop_na() %>%
  select(`Ticker symbol`, `Period Ending Year`, `Gross Margin`)
fund_time


# 5. Select the following columns from `securities_selected`:
#       `Ticker symbol`, `Security`, `GICS Sector`
#    Join the two tibbles `securities_selected` and `fund_time` by `Ticker symbol`.
#    Drop the `fund_time` rows with `NA` if the corresponding `Ticker symbol`
#    in `securities_selected` is not in `fund_time`.
#    To do that, you can use:
#      - `dplyr::select()` to select correponding columns.
#      - `inner_join()` to automatically drop rows in a tibble when not matched
#         with other tibble. Set the argument `by` to `Ticker symbol`.
#    Save the concatenated tibble to `securities_fund`.
#    `securities_fund` should print to:
#    # A tibble: 988 x 5
#    `Ticker symbol` Security `GICS Sector` `Period Ending …
#    <chr>           <chr>    <fct>                    <dbl>
#    1 MMM             3M Comp… Industrials               2013
#    2 MMM             3M Comp… Industrials               2014
#    3 MMM             3M Comp… Industrials               2015
#    4 ABT             Abbott … Health Care               2012
#    5 ABT             Abbott … Health Care               2013
#    6 ABT             Abbott … Health Care               2014
#    7 ABT             Abbott … Health Care               2015
#    8 ABBV            AbbVie   Health Care               2013
#    9 ABBV            AbbVie   Health Care               2014
#    10 ABBV            AbbVie   Health Care               2015
#    # … with 978 more rows, and 1 more variable: `Gross Margin` <dbl>
## Do not modify this line!
securities_fund <- securities_selected %>%
  select(`Ticker symbol`, Security, `GICS Sector`) %>%
  inner_join(fund_time, by = "Ticker symbol")
securities_fund



# 6. Load the library `ggplot2`.
#    Generate histograms of `Gross Margin` in different sectors in different periods
#    and assign the plot to variable `gross_margin`.
#    To do so, you can:
#      - create the plot by calling `ggplot()` on `securities_fund`,
#        with `mapping = aes()`, in which argument `fill` should set to `Period
#        Ending Year` and `x` should set to `Gross Margin`.
#      - adding `geom_histogram()` with `binwidth` set to `10`, `color` set to
#        `black` and `fill` set to `orange`.
#      - then facet on `GICS Sector` using `facet_wrap()`.
#      - `labs()` to format the labels such that:
#           - `title = "Gross margin distributed differently in different sectors"`
#           - `x = "Gross Margin (%)"`
#           - `y = "Count (n)"`
#      - then add the light theme using `theme_light()`.
## Do not modify this line!
library(ggplot2)
gross_margin <- ggplot(data = securities_fund, mapping = aes(x = `Gross Margin`, fill = `Period Ending Year`)) +
  geom_histogram(binwidth = 10, color = "black", fill = "orange") +
  facet_wrap(~ `GICS Sector`) +
  labs(title = "Gross margin distributed differently in different sectors",
       x = "Gross Margin (%)",
       y = "Count (n)") +
  theme_light()
gross_margin


# 7. Join the two tibbles `raw_time` with `securities_fund` to get each
#    company's stock price trend in each year with its corresponding
#    `Gross Margin` in that year.
#    (Note: the column you want to join the tables by is `Ticker symbol`,
#    make sure they have the exact same name before joining).
#    To do that, you can do the following:
#       - first convert the column name `symbol` of `raw_time` to `Ticker symbol`.
#         (Hint: use `dplyr::rename()`).
#       - use `mutate()`, and `year()` to extract the year of the price happening.
#       - use `dplyr::select()` to select only the following columns:
#            `Ticker symbol`, `close`, `open`, `date`,`year`
#       - use `left_join` with argument `by` set to `Ticker symbol`.
#       - use `filter()` to delete the rows where the `Perior Ending Year` is not
#         corresponding to the date of the price.
#    Save the generated tibble into `full_stock`.
#    `full_stock` should print to:
#    # A tibble: 246,615 x 9 
#    `Ticker symbol`  close   open date                 year Security
#    <chr>            <dbl>  <dbl> <dttm>              <dbl> <chr>
#    1 AAL               5.12   5.2  2012-01-03 00:00:00  2012 America…
#    2 AAP              69.1   71.1  2012-01-03 00:00:00  2012 Advance…
#    3 ABT              56.7   56.6  2012-01-03 00:00:00  2012 Abbott …
#    4 ADS             103.   103.   2012-01-03 00:00:00  2012 Allianc…
#    5 AKAM             32.9   33.0  2012-01-03 00:00:00  2012 Akamai …
#    6 ALK              73.9   76.4  2012-01-03 00:00:00  2012 Alaska …
#    7 AME              42.2   43.3  2012-01-03 00:00:00  2012 AMETEK …
#    8 AMT              58.8   60.5  2012-01-03 00:00:00  2012 America…
#    9 APH              46.0   46.5  2012-01-03 00:00:00  2012 Ampheno…
#    10 ARNC              9.23   8.94 2012-01-03 00:00:00  2012 Arconic…
#    # … with 246,605 more rows, and 3 more variables: `GICS
#    #   Sector` <fct>, `Period Ending Year` <dbl>, `Gross Margin` <dbl>
## Do not modify this line!
full_stock <- raw_time %>%
  rename("Ticker symbol" = symbol) %>%
  mutate(year = year(date)) %>%
  select(`Ticker symbol`, close, open, date, year) %>%
  left_join(securities_fund, by = "Ticker symbol") %>%
  filter(`Period Ending Year` == year)
full_stock



# 8. Generate the stock close price trend plot in 2010~2016 of the
#    following company:
#      "Aetna Inc", "Amazon.com Inc", "Facebook", "Whole Foods Market",
#      "FedEx Corporation", "Boeing Company", "The Walt Disney Company".
#    To do that, please do data manipulations first and create
#    a tibble `filtered_company`. You can use:
#       - `filter()` and `%in%` to filter the selected companies.
#    `filtered_company` should print to:
#    # A tibble: 5,292 x 9
#    `Ticker symbol` close  open date                 year Security
#    <chr>           <dbl> <dbl> <dttm>              <dbl> <chr>
#    1 AMZN            257.  256.  2013-01-02 00:00:00  2013 Amazon.…
#    2 BA               77.1  76.6 2013-01-02 00:00:00  2013 Boeing …
#    3 DIS              51.1  50.8 2013-01-02 00:00:00  2013 The Wal…
#    4 FB               28    27.4 2013-01-02 00:00:00  2013 Facebook
#    5 FDX              94.2  93.5 2013-01-02 00:00:00  2013 FedEx C…
#    6 WFM              92.0  93.1 2013-01-02 00:00:00  2013 Whole F…
#    7 AMZN            258.  257.  2013-01-03 00:00:00  2013 Amazon.…
#    8 BA               77.5  77.0 2013-01-03 00:00:00  2013 Boeing …
#    9 DIS              51.2  51.0 2013-01-03 00:00:00  2013 The Wal…
#    10 FB               27.8  27.9 2013-01-03 00:00:00  2013 Facebook
#    # … with 5,282 more rows, and 3 more variables: `GICS Sector` <fct>,
#    #   `Period Ending Year` <dbl>, `Gross Margin` <dbl>
## Do not modify this line!
filtered_company <- full_stock %>%
  filter(Security %in% c("Aetna Inc", "Amazon.com Inc", "Facebook", "Whole Foods Market",
                         "FedEx Corporation", "Boeing Company", "The Walt Disney Company"))
filtered_company


# 9. Generate the stock close price trend plot in 2016 of the following company:
#    "Aetna Inc", "Amazon.com Inc", "Facebook", "Extra Space Storage",
#    "FedEx Corporation", "JPMorgan Chase & Co.", "Oracle Corp.".
#    To do that, use:
#      - `ggplot()` on `filtered_company`, with `mapping = aes()`,
#        in which argument `y` should set to `close` and `x` should set to `date`.
#      - `geom_line(aes())` in which `color` is set to `Security`.
#      - `labs()` to format the labels such that:
#          - `title = "Six company daily stock close price from 2010 ~ 2016"`
#          - `x = "date"`
#          - `y = "Daily close price (USD)"`
#      - use `theme_light()` to set the theme.
## Do not modify this line!
trend <- ggplot(data = filtered_company, mapping = aes(x = date, y = close)) +
  geom_line(aes(color = Security)) +
  labs(title = "Six company daily stock close price from 2010 ~ 2016",
       x = "date",
       y = "Daily close price (USD)") +
  theme_light()
trend



# 10. Caculate the annual "Rate of Return" (RoR) on the securities in `full_stock`.
#     "Rate of Return" is defined as the net gain or loss on an investment
#      over a specified time period, calculated as a percentage of
#      the investment’s initial cost.
#      (Namely, RoR = (current value - initial value) / initial value)
#      To calculate this index on securities in `full_stock`, you can:
#         - group the stock prices by `Period Ending Year` and `Ticker symbol`
#           using `group_by()`
#         - select the record of start of the year and end of the year
#           by using `filter()` to select `date` equal to `min(date)` or
#           `max(date)`
#         - `mutate()` the `date` to `"open"` if it is equal to `min(date)`,
#           otherwise `"close"`. (use `ifelse()` inside `mutate()`)
#         - use `pivot_longer()` to extract `"open"` and `"close"` from `date`.
#           To do that, inside `pivot_longer()`, set `c("open", "close")`
#           as first argument, and then `names_to` as `"status"`, `values_to`
#           as `"price"`. This will add two columns recording the opening
#           and closing price for each row.
#         - use `filter()` to select the right `status` for each row by
#           condition `date == status`.
#         - use`summarize()` to calculate the `RoR` for each stock in
#           each year. Inside `summarize()`, use `diff()` to calculate the
#           price difference of open price and close price and divide the
#           difference by `price[1]` which represents the open price.
#         - use `left_join()` to add the annual `RoR` to `securities_fund`
#           by joining with `securities_fund` on `Ticker symbol` and
#           `Period Ending Year`.
#           (Set `by` to `c("Ticker symbol", "Period Ending Year")`.)
#         - use `droplevels()` drop the unselected sectors.
#     Save the generated tibble into `return_stock`.
#     `return_stock` should print to:
#     # A tibble: 980 x 6
#     # Groups:   Period Ending Year [5]
#     `Period Ending … `Ticker symbol`  Return Security `GICS Sector`
#     <dbl> <chr>             <dbl> <chr>    <fct>
#     1             2012 AAL              1.60   America… Industrials
#     2             2012 AAP              0.0170 Advance… Consumer Dis…
#     3             2012 ABT              0.158  Abbott … Health Care
#     4             2012 ADS              0.406  Allianc… Information …
#     5             2012 AKAM             0.241  Akamai … Information …
#     6             2012 ALK             -0.436  Alaska … Industrials
#     7             2012 AME             -0.133  AMETEK … Industrials
#     8             2012 AMT              0.278  America… Real Estate
#     9             2012 APH              0.390  Ampheno… Information …
#     10             2012 ARNC            -0.0291 Arconic… Industrials
#     # … with 970 more rows, and 1 more variable: `Gross Margin` <dbl>
## Do not modify this line!
return_stock <- full_stock %>%
  group_by(`Period Ending Year`, `Ticker symbol`) %>%
  filter(date == min(date) | date == max(date)) %>%
  mutate(date = ifelse(date == min(date), "open", "close")) %>%
  pivot_longer(c("open", "close"), names_to = "status", values_to = "price") %>%
  filter(date == status) %>%
  summarize("Return" = diff(price) / price[1]) %>%
  left_join(securities_fund, by = c("Ticker symbol", "Period Ending Year")) %>%
  droplevels()
return_stock


# 11. Calculate the mean, 0.25 quantile and 0.75 quantile of `Return` for
#     each `GICS Sector`.
#     To do that, use:
#         - `group_by()` to group the stocks by `GICS Sector`.
#         - `summarize()` to calculate `mean_return` using `mean()`,
#            25% quantile `q1` using `quantile()` with `probs` set to `0.25`,
#            75% quantile `q2` using `quantile()` with `probs` set to `0.75`.
#         - `mutate()` to reorder the factor `GICS Sector` using `fct_reorder()`
#            according to `mean_return`.
#     Save the generated tibble into `summary_stock`.
#     The first four lines of `summary_stock` should print to:
#     # A tibble: 8 x 4
#     `GICS Sector`          mean_return         q1     q2
#     <fct>                        <dbl>      <dbl>  <dbl>
#     1 Industrials                 0.153  -0.0291     0.315
#     2 Health Care                 0.192   0.0325     0.323
#     3 Information Technology      0.196  -0.00665    0.350
#     4 Consumer Discretionary      0.121  -0.0513     0.294
## Do not modify this line!
summary_stock <- return_stock %>%
  group_by(`GICS Sector`) %>%
  summarize(mean_return = mean(Return),
            q1 = quantile(Return, probs = 0.25),
            q2 = quantile(Return, probs = 0.75)) %>%
  mutate(`GICS Sector` = fct_reorder(`GICS Sector`, mean_return))
summary_stock



