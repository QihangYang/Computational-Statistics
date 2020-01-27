# HW7: email
#'
# In this exercise, you will perform data analysis with emails within 184 people
# from year 1998 to 2001.
# 1. Let's first read in the required datasets.
#    Load the `readr` package.
#      - Use `read_csv()` to load the `people.csv` data set from `data` folder
#        and assign it to a tibble `people`. This data set contains information
#        about the 184 people who sent emails between each other.
#      - Use `read_csv()` to load the `email.csv` data set from `data` folder
#        and assign it to a tibble `email`. This data set contains information about
#        each email sent: time, sender and receiver.
## Do not modify this line!
library(readr)
people <- read_csv("data/people.csv")
email <- read_csv("data/email.csv")



# 2. `onset` variable in `email` is the time when the email is sent, but we can
#    see that it is shown in a weird way. It turns out that it represents how
#    many seconds from the start time. Let's convert it to normal
#    time stamps.
#    Note: `1998-01-01` is encoded as 883612800 in `onset`.
#      - Load the `dplyr` package.
#      - Load the `lubridate` package
#      - Use `mutate()` to create a new variable `time` in `email` dataset.
#    We can obtain `time` by following the next three steps:
#      - Substract the `onset` by 883612800 to get the seconds difference with
#        `1998-01-01`.
#      - Use `as.POSIXct()` to change the seconds difference into normal timestamp.
#        Specify the argument `origin = "1998-01-01"`.
#      - Use `with_tz()`to change the time zone to UTC ,by passing
#        `tzone = "UTC"`.
#    Save your generated tibble into `email_w_time` whose first few rows should
#    look like:
#    A tibble: 38,131 x 9
#    onset terminus  tail  head onset.censored terminus.censor… duration edge.id
#    <dbl>    <dbl> <dbl> <dbl> <lgl>          <lgl>               <dbl>   <dbl>
#    9.58e8   9.58e8    30    30 FALSE          FALSE                   0       1
#    9.59e8   9.59e8    30    30 FALSE          FALSE                   0       1
#    9.59e8   9.59e8    30    30 FALSE          FALSE                   0       1
#    9.64e8   9.64e8    30    30 FALSE          FALSE                   0       1
#    9.70e8   9.70e8    30    30 FALSE          FALSE                   0       1
#    9.70e8   9.70e8    30    30 FALSE          FALSE                   0       1
#    9.73e8   9.73e8    30    30 FALSE          FALSE                   0       1
#    9.74e8   9.74e8    30    30 FALSE          FALSE                   0       1
#    9.79e8   9.79e8    30    30 FALSE          FALSE                   0       1
#    9.85e8   9.85e8    30    30 FALSE          FALSE                   0       1
#    … with 38,121 more rows, and 1 more variable: date <dttm>
## Do not modify this line!
library(dplyr)
library(lubridate)
email_w_time <- email %>%
  mutate(date = as.POSIXct(onset - 883612800, origin = "1998-01-01")) %>%
  mutate(date = with_tz(date, tzone = "UTC"))
email_w_time


# 3. Now let's take a look into the `people` dataset.
#    We can see some missing values in `person_name` column, but we can get a
#    person's name using his/her `email_id`.
#    For example, Albert Meyers's email ID is just `"albert.meyers"`.
#    To fill in missing values with email ID, let's first create a function
#    `email_id_to_name` to tranform `"albert.meyers"` into `"Albert Meyers"`.
#    You need to:
#      - Load the `stringr` package.
#      - Load the `purrr` package.
#      - Create a function  function `email_id_to_name` that take a string input
#    named `email_id` and returns the name extracted from the email id.
#    To do that, you can use:
#      - `str_split()` to extract the first and last name from `email_id`,
#        split by `"\\."`.
#      - `map_char` and `paste0()` to combine the first and last name using
#        `collapse = " "`.
#      - `str_trim()` to remove whitespace from start and end of string.
#      - `str_to_title()` to capitalize each word.
#    Name your.
## Do not modify this line!
library(stringr)
library(purrr)
email_id_to_name <- function(email_id){
  email_id <- email_id %>%
    str_split("\\.") %>%
    map_chr( ~ paste0(.x, collapse = " ")) %>%
    str_trim(side = "both") %>%
    str_to_title()
    
  return(email_id)
} 


# 4. Now let's implement the function you just created to our `people` tibble.
#    If `person_name` is not missing, do not modify it. If it is missing, change
#    `person_name` to the output of `email_id_to_name` by taking `email_id` as
#    input, you can use `email_id %>% email_id_to_name`.
#    To do that, you can use:
#      - `mutate()` and `ifelse()` to change the column `person_name`.
#      - `is.na()` to check if the `person_name` is missing.
#    Save your generated tibble into `people_new`, whose first few rows should
#    look like:
#    A tibble: 184 x 5
#    vertex.names email_id        person_name      role           dept
#    <dbl>        <chr>           <chr>            <chr>          <chr>
#    1          albert.meyers   Albert Meyers    Employee       Specialist
#    2          a..martin       Thomas Martin    Vice President NA
#    3          andrea.ring     Andrea Ring      NA             NA
#    4          andrew.lewis    Andrew Lewis     Director       NA
#    5          andy.zipper     Andy Zipper      Vice President Enron Online
#    6          a..shankman     Jeffrey Shankman President      Enron Global Mkts
#    7          barry.tycholiz  Barry Tycholiz   Vice President NA
#    8          benjamin.rogers Benjamin Rogers  Employee       Associate
#    9          bill.rapp       Bill Rapp        NA             NA
#    10         bill.williams   Bill Williams    NA             NA
#    … with 174 more rows
## Do not modify this line!
people_new <- people %>%
  mutate(person_name = ifelse(is.na(person_name), email_id %>% email_id_to_name, person_name))
people_new


# 5. We still have `NA` in `role` and `dept`. This time, we want to fill in the
#    missing values in `role` with `Employee` and missing values in `dept` as
#    `General`. Let's create a new tibble `people_new2` that fills such gaps...
#    and more!
#    First, load the `tidyr` package and create a vector `role_order =`
#    `c("Employee", "Trader", "Manager", "Managing Director", "Director",`
#    `"In House Lawyer", "Vice President", "President", "CEO")`
#    Now, can fill the missing roles and make it a factor using the levels
#    in `role_order`. To do that, you can use:
#      - `replace_na()` to fill in the missing values in these two columns.
#         Remember the missing values in `role` should now become `Employee`
#         and the missing values in `dept` should now become `General`.
#      - `mutate()` to change `role` into a factor with `factor()` and
#         specify `levels = role_order` to change `role` into a factor according
#         to our order.
#    Save your generated tibble into `people_new2` whose first few rows should
#    look like:
#    # A tibble: 184 x 5
#    vertex.names email_id        person_name      role           dept
#    <dbl>        <chr>           <chr>            <fct>          <chr>
#    1             albert.meyers   Albert Meyers    Employee       Specialist
#    2             a..martin       Thomas Martin    Vice President General
#    3             andrea.ring     Andrea Ring      Employee       General
#    4             andrew.lewis    Andrew Lewis     Director       General
#    5             andy.zipper     Andy Zipper      Vice President Enron Online
#    6             a..shankman     Jeffrey Shankman President      Enron Global Mkts
#    7             barry.tycholiz  Barry Tycholiz   Vice President General
#    8             benjamin.rogers Benjamin Rogers  Employee       Associate
#    9             bill.rapp       Bill Rapp        Employee       General
#    10            bill.williams   Bill Williams    Employee       General
#    … with 174 more rows
## Do not modify this line!
library(tidyr)
role_order =c("Employee", "Trader", "Manager", "Managing Director", "Director", "In House Lawyer", "Vice President", "President", "CEO")
people_new2 <- people_new %>%
  mutate(role = replace_na(role, "Employee")) %>%
  mutate(dept = replace_na(dept, "General")) %>%
  mutate(role = factor(role, levels = role_order))
people_new2


# 6. Let's combine the two datasets `email_w_time` and `people_new2` together,
#    we want to keep the information about every email and add the name, email ID,
#    role and department for the sender as well as for the receiver.
#    The numbers in `tail` and `head` represent different people. The key to join
#    this two tibbles are `tail` and `head` from `email_w_time`, and `vertex.names`
#    from `people_new2`. In other words, you need to use two `left_join()` to
#    add first the information of the receiver and then of the sender.
#    You will also need to update the names of the columns added by the joins.
#    To add information of a receiver, you can use:
#      - `left_join()` to combine `email_w_time` and `people_new2`, specify
#        `by = c("tail"="vertex.names")` because `tail` represents the receiver
#        of an email.
#      - `rename()` to change the column names to specify that they're the
#        receiver information: change `email_id` to `receiver_email`, `person_name`
#        to `receiver`, `role` to `receiver_role` and `dept` to `receiver_dept`.
#    Then, to add information of a sender, you can similarly use:
#      - `left_join()` to combine with `people_new` again, this time with
#        `by = c("head"="vertex.names")` .
#      - `rename()` to change the column names to specify that they're the
#         sender information: change `email_id` to `sender_email`, `person_name`
#         to `sender`, `role` to `sender_role` and `dept` to `sender_dept`.
#    Finally, you can use:
#       -  `select()` to only keep the `date`, sender information and receiver
#          information (each has 4 columns with email ID, name, role and department).
#      - `starts_with()` to select all the four columns of sender / receiver
#        information.
#    Save your generated tibble into `t1`, which should have 9 columns, in the order of
#    `date`, `sender_email` `sender`, `sender_role`, `sender_dept`, `receiver_email`,
#    `receiver`, `receiver_role`, `receiver_dept`.
#    The first fews rows of `t1` should look like:
#    A tibble: 38,131 x 9
#    date                sender_email sender sender_role sender_dept receiver_email
#    <dttm>              <chr>        <chr>  <fct>       <chr>       <chr>
#    2000-05-15 08:35:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-05-18 04:15:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-05-24 02:58:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-07-19 07:09:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-09-28 02:45:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-09-28 02:52:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-10-27 04:38:00 debra.perli… Debra… Employee    General     debra.perling…
#    2000-11-10 02:52:00 debra.perli… Debra… Employee    General     debra.perling…
#    2001-01-05 03:17:00 debra.perli… Debra… Employee    General     debra.perling…
#    2001-03-23 02:02:00 debra.perli… Debra… Employee    General     debra.perling…
#    … with 38,121 more rows, and 3 more variables: receiver <chr>,
#    receiver_role <fct>, receiver_dept <chr>
## Do not modify this line!
t1 <- email_w_time %>%
  left_join(people_new2, by = c("tail" = "vertex.names")) %>%
  rename("receiver_email" = email_id, "receiver" = person_name, "receiver_role" = role, "receiver_dept" = dept) %>%
  left_join(people_new2, by = c("head" = "vertex.names")) %>%
  rename("sender_email" = email_id, "sender" = person_name, "sender_role" = role, "sender_dept" = dept) %>%
  select(date, sender_email, sender, sender_role, sender_dept, receiver_email, receiver, receiver_role, receiver_dept)
t1



# 7. We noticed that there are emails that one person sent to him/her self
#    with the same `send_email` and `receiver_email`. We do not care about these
#    emails and want to filter them out.
#    - Use `filter` to filter out rows in `t1` whose `sender_email` is exactly
#    the same as `receiver_email`.
#    To simply our analysis with time the email is sent, we want to further
#    parse the information in `date` by creating new columns named `year`, `month`,
#    `day` and `hour`. To do that, you can use:
#      - `mutate()` to create the new columns `year`, `month`, `day` and `hour`.
#      - `year()` to extract `year` in `date`.
#      - `month()` to extract `month` in `date`.
#      - `day()` to extract `day` in `date`.
#      - `hour()` to extract `hour` in `date`.
#    Save your generated tibble into `t2`. The first few rows should look like:
#    A tibble: 34,427 x 13
#    date                sender_email sender sender_role sender_dept receiver_email
#    <dttm>              <chr>        <chr>  <fct>       <chr>       <chr>
#    2001-03-15 02:43:00 jeffrey.sha… Jeffr… President   Enron Glob… greg.whalley
#    2001-04-02 13:44:00 jeffrey.sha… Jeffr… President   Enron Glob… greg.whalley
#    2001-06-05 22:40:00 jeffrey.sha… Jeffr… President   Enron Glob… greg.whalley
#    2001-06-11 05:20:00 jeffrey.sha… Jeffr… President   Enron Glob… greg.whalley
#    2001-03-08 02:52:00 kim.ward     Kim W… Employee    General     jason.williams
#    2001-03-28 07:40:00 kim.ward     Kim W… Employee    General     jason.williams
#    2001-03-28 18:40:00 kim.ward     Kim W… Employee    General     jason.williams
#    2001-04-02 07:53:00 kim.ward     Kim W… Employee    General     jason.williams
#    2001-04-02 17:53:00 kim.ward     Kim W… Employee    General     jason.williams
#    2001-04-03 07:24:00 kim.ward     Kim W… Employee    General     jason.williams
#    … with 34,417 more rows, and 7 more variables: receiver <chr>,
#    receiver_role <fct>, receiver_dept <chr>, year <dbl>, month <dbl>, day <int>,
#    hour <int>
#    Now we have all the information we want. Let's try to answer some insteresting
#    questions in the following exercises:
## Do not modify this line!
t2 <- t1 %>%
  filter(sender_email != receiver_email) %>%
  mutate(year = year(date),
         month = month(date), 
         day = day(date), 
         hour = hour(date)) 
t2


# 8. Who are the top 3 people who sent emails the most? What are their roles and
#    departments?
#    To answer this, you can use:
#      - `group_by()` to group by `sender`, `sender_role` and `sender_dept`
#      - `summarize` by specify `count=n()` to count the number of emails
#      - `arrange()` to sort the tibble by count of emails in decreasing order
#      - `head()` to extract the first three rows.
#    Save your generated tibble into `p1` which should have the following structure:
#    A tibble: 3 x 4
#    sender          sender_role    sender_dept        count
#    <chr>           <fct>          <chr>              <int>
## Do not modify this line!
p1 <- t2 %>%
  group_by(sender, sender_role, sender_dept) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  head(3)
p1



# 9. During which period of day are people tend to send emails?
#    Use:
#      - `ggplot()` to initialize a ggplot object.
#        Set its arguments `data` and `mapping`.
#      - `geom_histogram()` to plot a histogram for `hour`.
#        Specify `bins = 24` to set the bins
#      - `labs()` to format the labels such that:
#        - `title = "People send more emails during noon"`.
#        - `x = "Hour"`.
#        - `y = "Count(n)"`.
#      - `theme_light()` to change the theme of plots.
#      - `theme()` to change the subtitle to the middle of the plot as well.
#        Set its argument `plot.title` using `element_text(hjust = 0.5)`.
#    Save your plot to `g1`.
## Do not modify this line!
library(ggplot2)
g1 <- ggplot(data = t2, mapping = aes(x = hour)) +
  geom_histogram(bins = 24) +
  labs(title = "People send more emails during noon",
       x = "Hour",
       y = "Count(n)") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g1
  


# 10. What is the trend of using emails? Do people use it more frequently in 1999 or 2001?
#    Let's first create a tibble to store the information.
#    Use:
#      - `filter()` to only keep the emails sent before `2002/01/01`.
#      - `group_by()` to group the data by `year`, `month` `sender` and
#      `sender_role`
#      - `summarize()` such that
#        - `date=min(date)` keep record of the earliest date in each group.
#        - `count=n()` the number of emails sent in that period.
#      - `arrange()` to order the rows by `date`.
#    Save your generated tibble into `p2`.
## Do not modify this line!
p2 <- t2 %>%
  filter(date < "2002/01/01") %>%
  group_by(year, month, sender_role) %>%
  summarize(date = min(date), count = n()) %>%
  arrange(date)
p2


# 11.Then let's visualize it. We want to plot the `count` against `date`
#    with colors spliting by `sender_role`.
#    Use:
#      - `ggplot()` to initialize a ggplot object.
#         Set its arguments `data`, `mapping`.
#      - `geom_point()` to plot a histogram for hour.
#      - `geom_smooth` to add a smoothing regression line.
#      - `labs()` to format the labels such that:
#        - `title = "People are using emails more frequently in 2001 than 1999"`.
#        - `x = "Date"`.
#        - `y = "Count(n)"`,
#        - `color = "Sender Role"`
#      - `theme_light()` to change the theme of plots.
#      - `theme()` to change the subtitle to the middle of the plot as well.
#        Set its argument `plot.title` using `element_text(hjust = 0.5)`.
#    Save your plot to `g2`.
#'
## Do not modify this line!
g2 <- ggplot(data = p2, mapping = aes(x = date, y = count, col = sender_role)) +
  geom_point() +
  geom_smooth(method = "loess") +
  labs(title = "People are using emails more frequently in 2001 than 1999",
       x = "Date",
       y = "Count(n)",
       color = "Sender Role") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g2




