# HW5: data manipulation
#'
# For this exercise, we will use a dataset related to mammalian sleep.
# You are not supposed to use any `for`, `while`, `repeat` or `sort` for this exercise.
#'
# 1. Load the dataset `msleep` by :
#      `library(ggplot2)`
#      `data(msleep)`
## Do not modify this line!
library(ggplot2)
data(msleep)



# 2. Calculate the proportion of each group of animals based on their diet
#    (the column `vore` tells you if an animal is carnivore, herbivore etc...)
#    into a new column called `vore_prop`.
#    To do that, you can use:
#         - `count()` to count the number of animals within each `vore`.
#         - `mutate()` to calulate the proportion of each `vore`.
#    To check your result, the first three lines of `vore_prop` print to:
#    # A tibble: 5 x 3
#    vore    count   prop
#    <chr>   <int>  <dbl>
#      1 carni      19 0.229
#    2 herbi      32 0.386
#    3 insecti     5 0.0602
## Do not modify this line!
library(dplyr)
library(tidyr)
vore_prop <- msleep %>%
  count(vore) %>%
  rename("count" = n) %>%
  mutate("prop" = count / sum(count))
vore_prop

# 3. We want to calculate the mean of each column among each animal group.
#    Specifically, we want a tibble containing the following information:
#    `vore`, `sleep_total`, `sleep_rem`, `sleep_cycle`, `awake`, `brainwt`, `bodywt`
#    where each of these variables is the mean among the group.
#    To do that, you can use:
#          - `group_by()` to group animals into groups based on `vore`.
#          - `summarize_if()` to calculate the mean of each property.
#    To check your result, the first three lines of `vore_means` print to:
#    # A tibble: 5 x 7
#    vore    sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
#    <chr>         <dbl>     <dbl>       <dbl> <dbl>   <dbl>   <dbl>
#    1 carni         10.4       2.29       0.373 13.6  0.0793   90.8
#    2 herbi          9.51      1.37       0.418 14.5  0.622   367.
#    3 insecti       14.9       3.52       0.161  9.06 0.0216   12.9
## Do not modify this line!
vore_means <- msleep %>%
  group_by(vore) %>%
  summarize_if(is.numeric, mean, na.rm = TRUE)
vore_means


# 4. Select the animals whose order is `Primates` and save the resulting tibble into
#    `primate`.
#    To do that, you can use:
#         - `filter()` function to select the animals whose order `==` Primates.
#    To check your solution, the first five lines of `primate` print to:
#    # A tibble: 12 x 11
#     name     genus   vore  order conservation sleep_total sleep_rem sleep_cycle awake brainwt bodywt
#     <chr>    <chr>   <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>   <dbl>  <dbl>
#     1 Owl mon… Aotus   omni  Prim… <NA>                17         1.8      NA       7    0.0155  0.48
#     2 Grivet   Cercop… omni  Prim… lc                  10         0.7      NA      14   NA       4.75
#     3 Patas m… Erythr… omni  Prim… lc                  10.9       1.1      NA      13.1  0.115  10
#     4 Galago   Galago  omni  Prim… <NA>                 9.8       1.1       0.55   14.2  0.005   0.2
#     5 Human    Homo    omni  Prim… <NA>                 8         1.9       1.5    16    1.32   62
## Do not modify this line!
primate <- msleep %>%
  filter(order == "Primates")
primate



# 5. We want to calculate the brain to body weight proportion (called brain_pro, 
#    i.e. the ratio between the brain weight and the body weight) of each primate,
#    and create a tibble `brain_primate` containing `name`, `genus`, `brainwt`, `bodywt`,
#    and all the sleep properties `sleep_total`, `sleep_rem`, `sleep_cycle`.
#    While calculating, drop the rows with `NA` brain weight.
#    To do that, you can use:
#      - `select()` to select wanted columns, along with `matches()` to  extract columns
#      with same name pattern and `starts_with()` to extract name with same start letters.
#      - `mutate()` to add column `brain_pro`.
#    (Note: to use the correct version of `select`, write `select <- dplyr::select` beforehand).
#    (Note: to use the correct version of `matches`, write `matches <- dplyr::matches` as well).
#    To check your solution, the first three lines of `brain_primate` print to:
#    # A tibble: 9 x 8
#      name            genus        brainwt bodywt sleep_total sleep_rem sleep_cycle brain_pro
#      <chr>           <chr>          <dbl>  <dbl>       <dbl>     <dbl>       <dbl>     <dbl>
#     1 Owl monkey      Aotus         0.0155  0.48         17         1.8      NA       0.0323
#     2 Patas monkey    Erythrocebus  0.115  10            10.9       1.1      NA       0.0115
#     3 Galago          Galago        0.005   0.2           9.8       1.1       0.55    0.0250
## Do not modify this line!
select <- dplyr::select
brain_primate <- primate %>%
  select(name, genus, brainwt, bodywt, starts_with("sleep")) %>%
  drop_na(brainwt) %>%
  mutate("brain_pro" = brainwt / bodywt)
brain_primate




