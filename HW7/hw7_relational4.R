# HW7: relational + regex + ggplot
#'
# Throughout the exercise:
#    - Do NOT use `for`, `while` or `repeat` loops.
#    - Use `%>%` to structure your operations.
#    - Use `theme_light()` for the plots.
#    - For graphs with titles, make the format as
# `theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))`.
#'
# 1. Load the packages `tidyverse` and `lubridate`.
#    Use `read_csv()` to read the datasets from data folder:
#       - `movies.csv` into a tibble `movie`.
#       - `ratings.csv` into a tibble `ratings`.
#    To check your solution, `movies` prints to:
#    # A tibble: 27,254 x 3
#    movieId title                              genres
#    <dbl> <chr>                              <chr>
#    1       1 Toy Story (1995)                   Adventure|Animation|Children|Comedy|Fanta..
#    2       2 Jumanji (1995)                     Adventure|Children|Fantasy
#    3       3 Grumpier Old Men (1995)            Comedy|Romance
#    4       4 Waiting to Exhale (1995)           Comedy|Drama|Romance
#    5       5 Father of the Bride Part II (1995) Comedy
#    6       6 Heat (1995)                        Action|Crime|Thriller
#    7       7 Sabrina (1995)                     Comedy|Romance
#    8       8 Tom and Huck (1995)                Adventure|Children
#    9       9 Sudden Death (1995)                Action
#    10      10 GoldenEye (1995)                   Action|Adventure|Thriller
#    # … with 27,244 more rows
#    `ratings` prints to:
#    # A tibble: 50,000 x 4
#    userId movieId rating  timestamp
#    <dbl>   <dbl>  <dbl>      <dbl>
#    1  36660     280    4    834049053
#    2  91867    2657    5    971578971
#    3 107259    2566    2    944169497
#    4 129338    4161    2.5 1137405482
#    5 128693    2355    4    984620012
#    6  97984    4052    3.5 1112061639
#    7  97700    3949    4   1274039326
#    8  10443   94839    2   1420951497
#    9  81462    4105    3   1092108684
#    10   6031     593    4    834163850
#    # … with 49,990 more rows
## Do not modify this line!
library(tidyverse)
library(lubridate)
movies <- read_csv("data/movies.csv")
ratings <- read_csv("data/ratings.csv")



# 2. Turn `timestamp` in the `ratings` dataset into normal format
#    (e.g. year-month-day).
#    To do this, you can use:
#      - `as.POSIXct()` to turn `timestamp` into
#        normal format, and specify the argument `origin = "1970-01-01"`.
#      - `with_tz()`to change the time zone to UTC ,by passing
#        `tzone = "UTC"`.
#    Store the returned dataset into `ratings`.
#    To check your result, `ratings` prints to:
#    # A tibble: 50,000 x 5
#    userId movieId rating  timestamp date
#    <dbl>   <dbl>  <dbl>      <dbl> <dttm>
#    1  36660     280    4    834049053 1996-06-06 08:17:33
#    2  91867    2657    5    971578971 2000-10-15 03:02:51
#    3 107259    2566    2    944169497 1999-12-02 21:18:17
#    4 129338    4161    2.5 1137405482 2006-01-16 09:58:02
#    5 128693    2355    4    984620012 2001-03-15 01:33:32
#    6  97984    4052    3.5 1112061639 2005-03-29 02:00:39
#    7  97700    3949    4   1274039326 2010-05-16 19:48:46
#    8  10443   94839    2   1420951497 2015-01-11 04:44:57
#    9  81462    4105    3   1092108684 2004-08-10 03:31:24
#    10   6031     593    4    834163850 1996-06-07 16:10:50
#    # … with 49,990 more rows
## Do not modify this line!
ratings <- ratings %>%
  mutate(date = as.POSIXct(timestamp, origin = as.Date("1970-01-01"))) %>%
  mutate(date = with_tz(date, tzone = "UTC"))
ratings


# 3. Create a tibble `average_rating_in_different_years` of dimension 20x2.
#    The procedure should first create a new column called `year_of_rating` that
#    gets the year of the rating and converted into a factor variable. Then we
#    group the dataset by `year_of_rating` and summarize the dataset such that
#    we calculate the average ratings of
#    each year and store averages in a column called `average_rating_of_year`.
#    To do that, you can use:
#      - `mutate()` and `as.factor()` to coerce the year of `date` into a
#        factor variable.
#      - `group_by()` to group by `year_of_rating`.
#      - `summarize` to summarize the mean of ratings of different year and
#        store the value into `average_rating_of_year`.
#    To check your result, `average_rating_in_different_years` prints to:
#    # A tibble: 20 x 2
#    year_of_rating average_rating_of_year
#    <fct>                           <dbl>
#    1 1996                             3.56
#    2 1997                             3.56
#    3 1998                             3.49
#    4 1999                             3.59
#    5 2000                             3.59
#    6 2001                             3.52
#    7 2002                             3.51
#    8 2003                             3.50
#    9 2004                             3.42
#    10 2005                             3.41
#    # … with 10 more rows
## Do not modify this line!
average_rating_in_different_years <- ratings %>%
  mutate(year_of_rating = as.factor(year(date))) %>%
  group_by(year_of_rating) %>%
  summarize(average_rating_of_year = mean(rating))
average_rating_in_different_years


# 4. Draw a point plot of `average_rating_of_year` vs. `year_of_rating`.
#    Name the title as `"2004 and 2005 have lower average ratings"`,
#    subtitle as `"While 2014 has highest average ratings"`.
#    To do this, you can use:
#      - `geom_point()` to draw a point plot of `average_rating_of_year`
#        vs. `year_of_rating`.
#      - `labs()` to name the title as
#        `"2004 and 2005 have lower average ratings"`,
#        the subtitle as `"While 2014 has highest average ratings"`,
#        the x-axis as `"Year"`,
#        the y-axis as `"Average rating"`.
#    Store the plot into a variable `g1`.
## Do not modify this line!
g1 <- ggplot(data= average_rating_in_different_years,
             mapping = aes(x = year_of_rating, y = average_rating_of_year)) +
  geom_point() +
  labs(title = "2004 and 2005 have lower average ratings",
       subtitle = "While 2014 has highest average ratings",
       x = "Year",
       y = "Average rating") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g1

# 5. Extract the year of movies from `title` column in the `movies` dataset.
#    Store the values into a new column called `year` and convert values into numeric.
#    To do this, you can use:
#      - `mutate()`, `map_chr` and `as.numeric()` to generate a new column called `year`
#        and transform values into numeric.
#        (hint: pay attention to `substr()` to extract the characters that we want.)
#    Store the returned dataset into `movies`.
#'
#    *Optional material*: The `title` column format is relatively clean here. What if
#    we have 4-digit years and 2-digit years mix (e.g. 1995, 96, 02, 2005, etc.)?
#    Then the method above will not work and how should we modify the code or use other methods?
#    Way 1: Locate the index of `(` and `)` then use `substr` to extract years.
#    Way 2: Use regular expression. For instance, you can combine `gsub()` with
#    `pattern = ".+\\(([0-9]+)\\)"`, `replacement = "\\1"`, and `x = title` in order to
#    extract the year.
#    Here, `gsub()` matches to argument pattern within each element of a character
#    vector, and then replace the designed pattern.
#    The pattern is `".+\\(([0-9]+)\\)"`.
#    `.` means the string starts with a character and `.+` means there are one or more characters.
#    `\\(` and `\\)` means there really exist parenthese. `\\` is just the syntax for escaping.
#    `([0-9]+)` means there exists a string of characters that can be converted to numeric.
#    The replacement is `\\1`.
#    `\\1` means we only need to keep the characters that can be converted to numeric.
#    If interested, please go to the following website for more detials:
#    https://stringr.tidyverse.org/articles/regular-expressions.html.
#'
#    To check your result, `movies` prints to:
#    # A tibble: 27,254 x 4
#    movieId title                           genres                                   year
#    <dbl> <chr>                           <chr>                                   <dbl>
#    1       1 Toy Story (1995)                Adventure|Animation|Children|Comedy|Fa…  1995
#    2       2 Jumanji (1995)                  Adventure|Children|Fantasy               1995
#    3       3 Grumpier Old Men (1995)         Comedy|Romance                           1995
#    4       4 Waiting to Exhale (1995)        Comedy|Drama|Romance                     1995
#    5       5 Father of the Bride Part II (1… Comedy                                   1995
#    6       6 Heat (1995)                     Action|Crime|Thriller                    1995
#    7       7 Sabrina (1995)                  Comedy|Romance                           1995
#    8       8 Tom and Huck (1995)             Adventure|Children                       1995
#    9       9 Sudden Death (1995)             Action                                   1995
#    10      10 GoldenEye (1995)                Action|Adventure|Thriller                1995
#    # … with 27,244 more rows
## Do not modify this line!
movies <- movies %>%
  mutate(year = map_dbl(gsub(pattern = ".+\\(([0-9]+)\\)", replacement = "\\1", x = title), as.numeric))
movies

  
# 6. Convert the `genres` column in `movies` dataset into characters.
#    Then separate the genres of a same movie such that the same movie is split
#    into several entries with different kinds of genres.
#    To do this, you can use:
#      - `mutate()` and `as.character` to convert `genres` into characters.
#      - `separate_rows` to split up the `genres`.
#    Store the returned dataset into `movies`.
#    To check your result, `movies` prints to:
#    # A tibble: 54,374 x 4
#    movieId title                   genres     year
#    <dbl> <chr>                   <chr>     <dbl>
#    1       1 Toy Story (1995)        Adventure  1995
#    2       1 Toy Story (1995)        Animation  1995
#    3       1 Toy Story (1995)        Children   1995
#    4       1 Toy Story (1995)        Comedy     1995
#    5       1 Toy Story (1995)        Fantasy    1995
#    6       2 Jumanji (1995)          Adventure  1995
#    7       2 Jumanji (1995)          Children   1995
#    8       2 Jumanji (1995)          Fantasy    1995
#    9       3 Grumpier Old Men (1995) Comedy     1995
#    10       3 Grumpier Old Men (1995) Romance    1995
#    # … with 54,364 more rows
## Do not modify this line!
movies <- movies %>%
  mutate(genres = as.character(genres)) %>%
  separate_rows(genres, sep = "\\|")
movies

# 7. Join the `movies` and `ratings` together by `movieId`. Remove `movieId`, `userId`
#    and `timestamp` columns after join.
#    To do this, you can use:
#      - `inner_join()` to join two dataset.
#      - `select()` to remove specified columns.
#    Store returned dataset to `ratings_of_movies`.
#    To check your result, `ratings_of_movies` prints to:
#    # A tibble: 132,725 x 5
#    title            genres     year rating date
#    <chr>            <chr>     <dbl>  <dbl> <dttm>
#    1 Toy Story (1995) Adventure  1995    3.5 2005-03-17 20:22:12
#    2 Toy Story (1995) Adventure  1995    3   1999-07-06 18:41:32
#    3 Toy Story (1995) Adventure  1995    3   2009-08-18 18:31:29
#    4 Toy Story (1995) Adventure  1995    4.5 2009-08-20 06:36:02
#    5 Toy Story (1995) Adventure  1995    5   1997-01-26 14:23:23
#    6 Toy Story (1995) Adventure  1995    5   2001-01-18 17:22:03
#    7 Toy Story (1995) Adventure  1995    3.5 2004-03-06 07:59:24
#    8 Toy Story (1995) Adventure  1995    4   1996-10-24 22:12:42
#    9 Toy Story (1995) Adventure  1995    4   1997-11-20 12:59:43
#    10 Toy Story (1995) Adventure  1995    4   2005-01-27 20:49:25
#    # … with 132,715 more rows
## Do not modify this line!
ratings_of_movies <- movies %>%
  inner_join(ratings, by ="movieId") %>%
  select(-c(movieId, userId, timestamp)) 
ratings_of_movies

# 8. Draw a horizontal boxplot of `rating` vs. `genres`.
#    To do this, you can use:
#      - `geom_boxplot()` to draw a boxplot of `rating` vs. `genres`.
#      - `labs()` to name the title as:
#        `"Most movie genres have median ratings from 3.5 to 4"`,
#        name the x-axis as `"Genres"`,
#        name the y-axis as `"Ratings"`.
#      - `coord_flip()` to flip x and y.
#    Store the plot into a variable `g2`.
## Do not modify this line!
g2 <- ggplot(data = ratings_of_movies,
             mapping = aes(x = genres,
                           y = rating)) +
  
  geom_boxplot() +
  labs(title = "Most movie genres have median ratings from 3.5 to 4",
       x = "Genres",
       y = "Ratings") +
  coord_flip() +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g2
  



# 9. Group by the `genres` columns in `ratings_of_movies`. Then summrize the mean of
#    `rating` and number of `rating` of different `genres`. Store average of rating
#    values into a column `average_rating`, number of `rating`
#    into a column `number_of_ratings`.
#    Finally convert the `genres` into a factor variable.
#    To do this, you can use:
#      - `group_by` to group by `genres`.
#      - `summarize` to calculate the mean of
#        `rating` and number of `rating` of different `genres`. Store average of
#        rating values into a column `average_rating`, number of `rating`
#        into a column `number_of_ratings`.
#      - `mutate()` and `as.factor` to convert `genres` into a factor variable.
#    Store the returned dataset into `average_rating_of_genres`.
#    To check your result, `average_rating_of_genres` prints to:
#    # A tibble: 20 x 3
#    genres             average_rating number_of_ratings
#    <fct>                        <dbl>             <int>
#    1 (no genres listed)            4.5                  1
#    2 Action                        3.43             13970
#    3 Adventure                     3.49             10875
#    4 Animation                     3.59              2807
#    5 Children                      3.38              4133
#    6 Comedy                        3.42             18701
#    7 Crime                         3.68              8265
#    8 Documentary                   3.74               588
#    9 Drama                         3.67             22331
#    10 Fantasy                       3.49              5252
#    # … with 10 more rows
## Do not modify this line!
average_rating_of_genres <- ratings_of_movies %>%
  group_by(genres) %>%
  summarize(average_rating = mean(rating), number_of_ratings = n()) %>%
  mutate(genres = as.factor(genres))
average_rating_of_genres
  


# 10.Draw a point plot of `average_rating` vs. `number_of_ratings`, colored by `genres`.
#    Draw a smooth curve that passes through points using `loess` method.
#    Name the title as
#    `"When number of ratings is over 5000, the average ratings start to be constant around 3.5"`.
#    To do this, you can use:
#      - `geom_point()` to draw a point plot of `average_rating` vs. `number_of_ratings`,
#        color by `genres`.
#      - `geom_smooth()` to draw a smooth curve using method as `loess`.
#      - `labs()` to name the title as
#        `"When number of ratings is over 5000, the average ratings start to be constant around 3.5"`.
#        the x-axis as `"Number of ratings"`,
#        the y-axis as `"Average rating"`,
#        the color legend as `"Genres"`.
#    Store the plot into a variable `g3`.
## Do not modify this line!
g3 <- ggplot(data = average_rating_of_genres,
             mapping = aes(x = number_of_ratings, y = average_rating)) +
  geom_point(aes(col = genres)) +
  geom_smooth(method = "loess") +
  labs(title = "When number of ratings is over 5000, the average ratings start to be constant around 3.5",
       x = "Number of ratings",
       y = "Average rating",
       color = "Genres") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g3  



# 11.Calculate the interval of time passed between the `date` corresponding the
#    rating and the release `year` from `ratings_of_movies` dataset,
#    and store this interval into a column called `interval`. You can assume
#    that a film released in a given year was actually released on January 1st.
#    Then, convert the units of `interval` into years and store its
#    values into a new column called `years_passed`.
#    Finally, filter out rows with `years_passed` less or equal to 60.
#    To do this, you can use:
#      - `mutate()` to create two required columns.
#        (hint 1: pay attention to `make_datetime()` to convert the release year
#        into a date and remembers that dates/datetimes can
#        be substracted to create intervals)
#        (hint 2: intervals can be divided by durations, and the `dyears()`
#        function can help your compute the number of years that have passed)
#      - `filter` to filter out rows with `years_passed` less or equal to 60.
#       Store the returned dataset to `ratings_over_time`.
#    To check your result, `ratings_over_time` prints to:
#    # A tibble: 130,087 x 7
#    title           genres     year rating date                interval      years_passed
#    <chr>           <chr>     <dbl>  <dbl> <dttm>              <drtn>               <dbl>
#    1 Toy Story (199… Adventure  1995    3.5 2005-03-17 20:22:12 3728.8488 da…        10.2
#    2 Toy Story (199… Adventure  1995    3   1999-07-06 18:41:32 1647.7788 da…         4.51
#    3 Toy Story (199… Adventure  1995    3   2009-08-18 18:31:29 5343.7719 da…        14.6
#    4 Toy Story (199… Adventure  1995    4.5 2009-08-20 06:36:02 5345.2750 da…        14.6
#    5 Toy Story (199… Adventure  1995    5   1997-01-26 14:23:23  756.5996 da…         2.07
#    6 Toy Story (199… Adventure  1995    5   2001-01-18 17:22:03 2209.7236 da…         6.05
#    7 Toy Story (199… Adventure  1995    3.5 2004-03-06 07:59:24 3352.3329 da…         9.18
#    8 Toy Story (199… Adventure  1995    4   1996-10-24 22:12:42  662.9255 da…         1.82
#    9 Toy Story (199… Adventure  1995    4   1997-11-20 12:59:43 1054.5415 da…         2.89
#    10 Toy Story (199… Adventure  1995    4   2005-01-27 20:49:25 3679.8677 da…        10.1
#    # … with 130,077 more rows
## Do not modify this line!
ratings_over_time <- ratings_of_movies %>%
  mutate(interval = (date - make_datetime(year = year)) / ddays()) %>%
  mutate(years_passed = (date - make_datetime(year = year))/ dyears()) %>%
  filter(years_passed <= 60)
ratings_over_time


# 12.Draw a "straight" line plot of `rating` vs. `years_passed`, colored by `genres`.
#    Name the title as `"The average rating usually increases with time"`,
#    subtitle as `"One exception is animation movies"`,
#    x-axis as `"Years between release and rating"`,
#    y-axis as `"Average rating"`,
#    legend as `"Genres"`.
#    To do this, you can use:
#      - `ggplot()` to setup your plot `rating` vs. `years_passed`, colored by `genres`.
#      - `geom_smooth()` to draw a "straight" line plot using method as `"lm"`.
#      - `labs()` to name the title `"The average rating usually increases with time"`,
#        subtitle as `"One exception is animation movies"`,
#        x-axis as `"Years between release and rating"`,
#        y-axis as `"Average rating"`,
#        color legend as `"Genres"`.
#    Store the plot into a variable `g4`.
#'
## Do not modify this line!
g4 <- ggplot(data = ratings_over_time, mapping = aes(x = years_passed, y = rating, col = genres)) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "The average rating usually increases with time",
       subtitle = "One exception is animation movies",
       x = "Years between release and rating",
       y = "Average rating",
       color = "Genres") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5), plot.subtitle = element_text(hjust = 0.5))
g4



