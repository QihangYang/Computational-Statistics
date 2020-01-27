# HW6: football
#'
# In this problem, we will continue to play with the football dataset from HW5.
# Throughout the exercise:
#    - Use `%>%` to structure your operations.
#    - Do NOT use `for`, `while` or `repeat` loops.
#'
# In this exercise, you have to recreate the figures found at 
# the left of the instructions.
# We suggest functions you can use to create the plots, but 
# you are free to use the method you are the most comfortable with.
# Make sure that the figures look exactly like the ones you are supposed to create.
#'
# 1. Load the following packages: `ggplot2`, `viridis`, `lubridate` and
#    `tidyverse`. Load the file `data/football.csv` and save it into tibble `fu`.
#    Draw a box plot of total home goals from 2001 to 2019 of team England,
#    Germany, France, Belgium, Italy and Spain.
#    To do that, first create a tibble `fu1` containing three columns
#    `home_team`, `year` and `total`. You can use :
#      - `year()` to extract year from `date` and `filter()` to filter years
#      from 2001 to 2019, and to only keep the 6 countries in `home_team` column.
#      - `group_by()` and `dplyr::summarise()` to count the total goals of each team
#      in each year.
#    `fu1` should print to :
#    # A tibble: 114 x 3
#    # Groups:   home_team [6]
#    home_team  year total
#    <chr>     <dbl> <dbl>
#    1 Belgium    2001    16
#    2 Belgium    2002     6
#    3 Belgium    2003    11
#    4 Belgium    2004     3
#    5 Belgium    2005    14
#    6 Belgium    2006     8
#    7 Belgium    2007     7
#    8 Belgium    2008     7
#    9 Belgium    2009    12
#    10 Belgium    2010     6
#    # … with 104 more rows
## Do not modify this line!
library(ggplot2)
library(viridis)
library(lubridate)
library(tidyverse)
fu <- read_csv("data/football.csv")
fu1 <- fu %>%
  mutate(year = year(date)) %>%
  filter(between(year, 2001, 2019)) %>%
  filter(home_team %in% c("England", "Germany", "France", "Belgium", "Italy", "Spain")) %>%
  group_by(home_team, year) %>%
  summarise(total = sum(home_score))
fu1


# 2. Then, to draw the plot of `fu1`, use:
#     - `ggplot` to initialize a ggplot object and specify the variables to plot.
#     -  use `fill` to fill the color of boxes to `home_team`.
#     - `geom_boxplot` to plot boxplot, set argument `alpha` to 0.6.
#        It will make the color lighter.
#     - `scale_fill_viridis` to use viridis color scale.
#        Set `discrete` to TRUE.
#     - `labs()` to format the labels such that:
#      - `title = "Six European National Teams Home Goals from 2000 to 2019"`
#      - `x = "Teams"`
#      - `y = "Goals Overall (n)"`
#    Save the `ggplot` object to `plot1`.
## Do not modify this line!
plot1 <- ggplot(data = fu1, mapping = aes(x = home_team, y = total, fill = home_team)) +
  geom_boxplot(alpha = 0.6) +
  scale_fill_viridis(discrete = TRUE) +
  labs(title = "Six European National Teams Home Goals from 2000 to 2019",
       x = "Teams",
       y = "Goals Overall (n)")
plot1  


# 3. Before plotting, first create a tibble `fu2` containing the relevant data.
#    You can use:
#      - `select()` to select the relevant columns.
#        Make sure you use `dplyr::select`.
#      - `mutate()` and `year()` to change the column `date` to its
#        corresponding year
#      - `filter()` to filter years from 2013~2019 and `home_team`
#        as England.
#    `fu2` should look like the following:
#    # A tibble: 38 x 4
#    home_team home_score date        year
#    <chr>          <dbl> <date>     <dbl>
#    1 England            1 2014-03-05  2014
#    2 England            3 2014-05-30  2014
#    3 England            1 2014-06-14  2014
#    4 England            1 2014-09-03  2014
#    5 England            5 2014-10-09  2014
#    6 England            3 2014-11-15  2014
#    7 England            4 2015-03-27  2015
#    8 England            2 2015-09-08  2015
#    9 England            2 2015-10-09  2015
#    10 England            2 2015-11-17  2015
#    # … with 28 more rows
## Do not modify this line!
fu2 <- fu %>%
  select(home_team, home_score, date) %>%
  mutate(year = year(date)) %>%
  filter(between(year, 2014, 2019)) %>%
  filter(home_team == "England")
fu2


# 4. Load the package `ggridges` for plotting.
#    Draw a ridge line plot to analyze the distribution of goals of England in
#    home games from 2013 to 2019.
#    To draw the plot, use:
#     - `ggplot` to initialize a ggplot object and specify the variables to plot.
#        You should plot `home_score` against `year`, group by `home_score`,
#        and set `fill` to `home_score`.
#     - `geom_density_ridges` to plot ridge lines, with argument `alpha` set
#        to 0.6. This will make the color lighter.
#     - `labs()` to format the labels such that:
#      - `title = "England National Team Home Goals Distribution 
#                  in International Contests from 2013 to 2019"`
#      - `subtitle = "They've crossed the low valley and kept high level recently"`
#      - `x = "Year"`
#      - `y = "England Goals Overall (n)"`
#    Save the `ggplot` object to `plot2`.
## Do not modify this line!
library(ggridges)
plot2 <- ggplot(data = fu2, mapping = aes(x = year, y = home_score, group = home_score, fill = home_score)) +
  geom_density_ridges(alpha = 0.6) +
  labs(title = "England National Team Home Goals Distribution\n 
       in International Contests from 2013 to 2019",
       subtitle = "They've crossed the low valley and kept high level recently",
       x = "Year",
       y = "England Goals Overall (n)")
plot2


# 5. Draw a bar plot representing the number of games that
#    team England, Germany, France, Belgium, Italy and Spain
#    participated as home team in the following contests:
#    'FIFA World Cup', 'UEFA Euro', 'UEFA Nations League', 'Nations Cup'
#    and 'Kirin Cup' since 2000.
#    Before plotting, please do data manipulations to create a tibble `fu3`
#    containing the relevant data.
#    To do that, you can use:
#      - `select()` to select the three columns `"home_team", "tournament", "date"`.
#      - `mutate()` and `factor()` to convert the `tournament` column
#         into factors with given levels.
#      - `drop_na()` to drop the NA values.
#      - `filter()` to get only the relevant teams and years since 2000.
#    It should print to :
#    # A tibble: 89 x 3
#    home_team tournament     date
#    <chr>     <fct>          <date>
#    1 France    FIFA World Cup 2002-05-31
#    2 England   FIFA World Cup 2002-06-02
#    3 Italy     FIFA World Cup 2002-06-03
#    4 France    FIFA World Cup 2002-06-06
#    5 Italy     FIFA World Cup 2002-06-08
#    6 Belgium   FIFA World Cup 2002-06-14
#    7 England   FIFA World Cup 2002-06-21
#    8 France    UEFA Euro      2004-06-13
#    9 England   UEFA Euro      2004-06-17
#    10 Italy     UEFA Euro      2004-06-18
#    # … with 79 more rows
## Do not modify this line!
fu3 <- fu %>%
  select(home_team, tournament, date) %>%
  mutate(tournament = factor(tournament, levels = c("FIFA World Cup", "UEFA Euro", "UEFA Nations League", "Nations Cup", "Kirin Cup"))) %>%
  drop_na() %>%
  filter(home_team %in% c("England", "Germany", "France", "Belgium", "Italy", "Spain")) %>%
  filter(year(date) > 2000)
fu3


# 6. In the bar plot, each group of columns represent a team
#    and different column for different tournament should be
#    shown in different colors.
#    Then, create the plot using :
#     - `ggplot()` to initialize a ggplot object and specify the `home_team`
#        to plot and setting `fill` to tournament.
#     - `geom_bar()` to plot the bar plot, setting argument `position` to
#        `dodge` and `alpha` to `0.75`.
#     - `scale_fill_viridis(discrete=TRUE)` to use the viridis color scale.
#     - `theme()` to set the x-axis label rotate 45 degrees.
#        (Hint : Use `element_text` to set `axis.text.x` correctly)
#     - `labs()` to format the labels such that:
#      - `title = "Six European National Team International Home Game Participation
#         Distribution from 2013 to 2019"`
#      - `subtitle = "Germany stands out in game numbers in World Cup participation"`
#      - `x = "Teams"`
#      - `y = "Number of Home Games"`
#    Save the `ggplot` object to `plot3`.
## Do not modify this line!
plot3 <- ggplot(data = fu3, mapping = aes(x = home_team, fill = tournament)) +
  geom_bar(position = "dodge", alpha = 0.75) +
  scale_fill_viridis(discrete = TRUE) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Six European National Team International Home Game Participation\n
       Distribution from 2013 to 2019",
       subtitle = "Germany stands out in game numbers in World Cup participation",
       x = "Teams",
       y = "Number of Home Games")
plot3


# 7. Draw a histogram of the national teams with more than 8 attendances
#    in World Cup history.
#    (Note: you need to calculate the attendance of these teams in all World Cup)
#    Before plotting, please do data manipulations to create a tibble `fu4`.
#    containing the relevant data.
#    To do that, you can use :
#      - `filter()` and `str_detect` to filter by `World Cup` tournaments.
#         Note : Don't take into account the `qualifications` games.
#      - `pivot_longer()` to stretch the game records so that each row is
#         team-wise record.
#      - `group_by()` and `distinct()` to count the attendance of the team
#         in each World Cup year.
#         (Note: it is counted only one attendance no matter how many
#          games the team played in that year)
#      - `dplyr::mutate()` to get the total number of attendances as column `attendance`.
#      - `filter()` to only get the teams with more than 8 attendances.
#      - `arrange()` and `desc()` to order the result in descending order of `attendance`.
#    `fu4` should print to :
#    # A tibble: 244 x 3
#    # Groups:   team [18]
#    year team   attendance
#    <dbl> <chr>       <int>
#    1  1930 Brazil         21
#    2  1934 Brazil         21
#    3  1938 Brazil         21
#    4  1950 Brazil         21
#    5  1954 Brazil         21
#    6  1958 Brazil         21
#    7  1962 Brazil         21
#    8  1966 Brazil         21
#    9  1970 Brazil         21
#    10  1974 Brazil         21
#    # … with 234 more rows
## Do not modify this line!
fu4 <- fu %>%
  filter(str_detect(tournament, "World Cup")) %>%
  filter(str_detect(tournament, "qualification", negate = TRUE)) %>%
  pivot_longer(c(home_team, away_team), names_to = "team_type", values_to = "team") %>%
  mutate("year" = year(date)) %>%
  select(year, team)  %>%
  group_by(team) %>%
  distinct() %>%
  mutate("attendance" = n()) %>%
  filter(attendance > 8) %>%
  arrange(desc(attendance))
fu4


# 8. Then, create the histogram. You can use :
#     - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#     - `geom_bar()` to plot histogram plot, setting argument `fill` to
#       `"lightsalmon1"`, `color` to `"black"` and `stat` to `"count"`.
#       This will give boundary to each column. Plus, please
#       set `bins` to 10. (You can change the parameters to see differences).
#     - `coord_flip()` to flip the x,y axis so country names can be shown properly.
#     - `labs()` to format the labels such that:
#      - `title = "National Team Attendance Distribution in World Cup History"`
#      - `x = "Teams"`
#      - `y = "Attendance in World Cup"`
#    Save the `ggplot` object to `plot4`.
## Do not modify this line!
plot4 <- ggplot(data = fu4, mapping = aes(x = team)) +
  geom_bar(fill = "lightsalmon1", color = "black", stat = "count") +
  coord_flip() +
  labs(title = "National Team Attendance Distribution in World Cup History",
       x = "Teams",
       y = "Attendance in World Cup")
plot4


