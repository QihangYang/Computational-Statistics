# HW7: Relational data
#'
# In this exercise, you will familiarize yourself with
# relational data and its manipulation.
#'
# Throughout the exercise:
#    - Use `theme_light()` for the plots.
#    - Do not change the default position of the plot title.
#    - Do not print the plot.
#'
# In this exercise, you have to recreate the figures found at
# the left of the instructions.
# We suggest functions you can use to create the plots, but
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Load the `tidyverse`, `readr`, and `lubridate` packages.
#    Use the function `read_csv()` to read the dataset
#    `booking.csv`, `guest.csv`, `rate.csv`, and `room.csv`
#    from path `data/guest_house/`.
#    Store the corresponding dataframe into a tibble
#    `booking`, `guest`, `rate`, and `room`.
## Do not modify this line!
library(tidyverse)
library(readr)
library(lubridate)
booking <- read_csv("data/guest_house/booking.csv")
guest <- read_csv("data/guest_house/guest.csv")
rate <- read_csv("data/guest_house/rate.csv")
room <- read_csv("data/guest_house/room.csv")


# 2. Create a tibble `room_earning` from table `booking` and `rate`
#    using `left_join()`.
#    For each `booking_date` and `room_no`, there should be a column
#    `earning` containing the earning of this room.
#    The column `booking_date` should be class `"Date"`.
#    To do that, you can use:
#    - `left_join()` to join tables `booking` and `rate`.
#      Note that you should join by two columns.
#    - `mutate()` to create a new column `earning` that
#      is the multiplication of `nights` and `amount`.
#    - `mdy()` to transform the `booking_date` to class `"Date"`.
#    - `arrange()` to order the tibble.
#    - `select()` to select the columns.
#    The first rows of its print should be :
#    # A tibble: 347 x 5
#      booking_date room_no guest_id nights earning
#      <date>         <dbl>    <dbl>  <dbl>   <dbl>
#    1 2016-11-03       101     1027      7     336
#    2 2016-11-03       102     1179      2     112
#    3 2016-11-03       103     1106      2     144
#    4 2016-11-03       104     1238      3     168
#    5 2016-11-03       105     1540      7     588
#    6 2016-11-03       106     1021      3     168
#    7 2016-11-03       107     1623      3     168
#    8 2016-11-03       108     1136      1      56
#    9 2016-11-03       109     1585      4     288
#   10 2016-11-03       201     1613      6     288
#    # … with 337 more rows
## Do not modify this line!
room_earning  <- booking %>%
  left_join(rate, by = c("room_type_requested" = "room_type", "occupants" = "occupancy")) %>%
  mutate(earning = nights * amount) %>%
  mutate(booking_date = mdy(booking_date)) %>%
  arrange(booking_date) %>%
  select(booking_date, room_no, guest_id, nights, earning)
room_earning


# 3. Create a tibble `room_earning_filtered` from `room_earning`.
#    This tibble will only have data whose `room_no` is
#    smaller than `200` and `booking_date` between `2016-11-15`
#    and `2019-12-15`(including both).
#    To do that, you can use:
#    - `filter()` to filter the `room_no` that is smaller than
#      `200`.
#    - `filter()` to filter the date.
#    - `mutate()` and `as.character()` to transform the `room_no`
#      from `"numeric"` to `"character"`.
#    The first rows of its print should be :
#    # A tibble: 76 x 5
#      booking_date room_no guest_id nights earning
#      <date>       <chr>      <dbl>  <dbl>   <dbl>
#    1 2016-11-15   101         1344      1      48
#    2 2016-11-15   105         1127      5     280
#    3 2016-11-15   103         1041      4     288
#    4 2016-11-15   109         1624      1      72
#    5 2016-11-15   102         1598      2     144
#    6 2016-11-15   106         1208      5     280
#    7 2016-11-16   101         1185      1      48
#    8 2016-11-16   109         1249      3     216
#    9 2016-11-17   101         1187      5     240
#   10 2016-11-17   104         1477      2     144
#    # … with 66 more rows
## Do not modify this line!
room_earning_filtered <- room_earning %>%
  filter(room_no < 200) %>%
  filter(between(booking_date, as.Date("2016-11-15"), as.Date("2019-12-15"))) %>%
  mutate(room_no = as.character(room_no))
room_earning_filtered


# 4. Plot line plot: the earnings of room by date
#    using `room_earning_filtered`.
#    The x axis should be date labelled as `"Booking Date"`
#    with ticks `"11/15"`, `"12/01"`, `"12/15"`.
#    The y axis should be earning labelled as `"Earning (dollars)"`
#    with ticks `100`, `200`, `300` (default setting).
#    To do that, you can use:
#    - `ggplot()` to initialize a ggplot object. You can set its arguments
#      `data` and `mapping` to plot the `booking_date` and `earning` column
#      of the `room_earning_filtered`.
#      Use `aes` to set parameters `mapping`.
#    - `geom_line()` to plot the line plot.
#    - `scale_x_date()` to set the ticks of x axis to
#      `"11/15"`, `"12/01"`, `"12/15"`.
#    - `labs()` to format the labels such that:
#      - `title = "Most rooms have earning around 100 to 300"`
#      - `x = "Booking date"`
#      - `y = "Earning (dollars)"`
#    - `facet_wrap` to be faceted by `room_no`.
#    - `theme_light()` to set light theme (i.e. a light backgroung).
#    Save the plot into `room_earning_plot`.
## Do not modify this line!
room_earning_plot <- ggplot(data = room_earning_filtered,
                            mapping = aes(x = booking_date,
                                          y = earning)) +
  geom_line() +
  scale_x_date(breaks = as.Date(c("2016-11-15", "2016-12-01", "2016-12-15")), date_labels = "%m/%d") +
  facet_wrap(~ room_no) +
  labs(title = "Most rooms have earning around 100 to 300",
       x = "Booking date",
       y = "Earning (dollars)") +
  theme_light()
room_earning_plot


# 5. Create a tibble `guest_spending` that stores the total spending and
#    total number of nights staying for each guest by their full name
#    from tibble `guest` and `room_earning` using `right_join`.
#    You can use :
#      - `mutate()` and `paste()` to concatenate `first_name` and
#        `last_name` in `guest`.
#      - `right_join()` to join the aforementioned tibble with
#        `room_earning`.
#      - `group_by()` to group by name.
#      - `summarize()` to compute the total spending `spending`
#        and total number of nights staying `nights`.
#      - `ungroup()` to ungroup the tibble.
#      - `top_n()` to select 10 rows with top spendings.
#      - `arrange()` to order the tibble by descending order of
#        total spending.
#      - `fct_reorder()` to set `name` to factor and order the
#        level by ascending order of total spending.
#    The first rows of its print should be :
#    # A tibble: 10 x 3
#      name                  nights spending
#      <fct>                  <dbl>    <dbl>
#    1 Sir Edward Garnier        11      780
#    2 Robert Halfon             10      768
#    3 Angela Rayner             14      744
#    4 Karin Smyth               11      696
#    5 Sir Alan Haselhurst       11      680
## Do not modify this line!
guest_spending <- guest %>%
  right_join(room_earning, by = c("id" = "guest_id")) %>%
  mutate(name = paste(first_name, last_name, sep = " ")) %>%
  group_by(name) %>%
  summarize(nights = sum(nights), spending = sum(earning)) %>%
  ungroup() %>%
  top_n(10) %>%
  arrange(desc(spending)) %>%
  mutate(name = as.factor(fct_reorder(name, spending)))
  
guest_spending


# 6. Plot the bar plot of `spending` by `name` using
#    dataset `guest_spending`.
#    The bars should be horizontal and ordered by total spending
#    from highest (on top of the figure) to lowest.
#    The x axis should be `"Spending (dollars)"` without label
#    with ticks `0`, `200`, `400`, `600`, `800`(default setting).
#    The y axis should be  `"Name"` with ticks
#    `"Sir Edward Garnier"`, `"Robert Halfon"`, `"Angela Rayner"`,
#    ..., `"Craig Tracey"` from top to bottom(default setting).
#    To do that, use:
#    - `ggplot()` to initialize a ggplot object.
#      Set the `date` and `mapping` parameter correctly.
#    - `geom_col()` to plot the box plot.
#    - `coord_flip()` to flip the axises.
#    - `labs()` to format the labels such that:
#      - `title = "Top 10 guests all spent more than 600"`
#      - `y = "Spending (dollars)"`
#      - `x = "Name"`
#    - `theme_light()` to set light theme.
#    Save the plot into `guest_spending_plot`.
## Do not modify this line!
guest_spending_plot <- ggplot(data = guest_spending,
                              mapping = aes(x = name, y = spending)) +
  geom_col() +
  coord_flip() +
  labs(title = "Top 10 guests all spent more than 600",
       x = "Name",
       y = "Spending (dollars)") +
  theme_light()
guest_spending_plot


