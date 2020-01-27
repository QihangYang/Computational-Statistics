# HW7: relational data
#'
# In this exercise, we will walk you through a complete process of manipulating
# relational data. We suggest the functions you can use to create the tibbles
# and the plots, but you are free to use the methods you are the most comfortable with.
# Make sure that the outputs look exactly like the ones you are supposed to create.
#'
# Throughout the exercise:
#    - Do NOT use `for`, `while` or `repeat` loops.
#    - Use `%>%` to structure your operations.
#    - Use `theme_light()` for the plots.
#'
# 1. Load the packages `tidyverse`, `lubridate` and `GGally`.
#    Use `read_csv()` to read the datasets:
#       - `data/department_info.csv` into a tibble `department`.
#       - `data/employee_info.csv` into a tibble `employee`.
#       - `data/student_counselling_info.csv` into a tibble `s_admission`.
#       - `/course/data/student_performance_info.csv` into a tibble `s_performance`.
#    All datasets are located in the directory `data/` with the exception of the last one.
#    Background:
#       - `department` has information about departments in the university,
#         including `Department_ID`, `Department_Name` and `DOE` (date of
#         establishment).
#       - `employee` has information about professors, including `Employee_ID`,
#         `DOB` (date of birth), `DOJ` (date of university joining) and
#         `Department_ID` where the professors belong to.
#       - `s_admission` has information about admission of students, including
#         `Student_ID`, `DOA` (date of admission), `DOB`, `Department_Choices`
#         (choices student made during counselling) and `Department_Admission`
#         (department offered to student).
#       - `s_performance` has information about performance details of a student,
#         including `Student_ID`, `Semester_Name`, `Paper_ID`, `Paper_Name` and
#         `Marks` (marks scored in examination).
#    After preprocessing all the tibbles, we will have a final tibble `engie`,
#    with integrated information of students at the Engineering School.
## Do not modify this line!
library(tidyverse)
library(lubridate)
library(GGally)
department <- read_csv("data/department_info.csv")
employee <- read_csv("data/employee_info.csv")
s_admission <- read_csv("data/student_counselling_info.csv")
s_performance <- read_csv("/course/data/student_performance_info.csv")



# 2. We will start by cleaning and aggregating some new columns for our interest.
#    Create a tibble `employee_new` of size 1000 x 5 with columns `Employee_ID`,
#    `Department_ID`, `age`, `seniority` and `seniority_level`, where `age` is
#    the age of the professor, `seniority` is the year of teaching, and
#    `seniority_level` shows whether a professor is junior (`seniority` <= 10)
#    or senior (`seniority` > 10).
#    To do this, you can use:
#       - `mutate()` to create the columns
#          - `age` and `seniority` from `DOB` and `DOJ` repectively by
#            - Creating an interval with `%--%`, `today()` and `dyears()`.
#            - Rounding the years to integers with `round()`.
#          - `seniority_level` to categorize `seniority` by
#            - Cutting `seniority` with `cut()`, setting
#              - `breaks = min(seniority), 10, max(seniority)`;
#              - `labels = c("junior", "senior")`;
#              - `include.lowest = TRUE`.
#       - `dplyr::select()` to select the desired columns.
#    To check your result, `employee_new` prints to:
#    # A tibble: 1,000 x 5
#       Employee_ID Department_ID   age seniority seniority_level
#       <chr>       <chr>         <dbl>     <dbl> <fct>
#     1 IU196557    IDEPT4938        37        10 junior
#     2 IU449901    IDEPT2357        34        10 junior
#     3 IU206427    IDEPT4670        48        11 senior
#     4 IU688905    IDEPT2601        46        18 senior
#     5 IU634582    IDEPT7626        28        20 senior
#     6 IU138624    IDEPT3778        40        13 senior
#     7 IU932068    IDEPT4132        34         6 junior
#     8 IU572796    IDEPT1142        42        12 senior
#     9 IU134670    IDEPT7626        39        18 senior
#    10 IU393717    IDEPT1825        47        10 junior
#    # … with 990 more rows
## Do not modify this line!
employee_new <- employee %>%
  mutate(age = round((DOB %--% today()) / dyears()), seniority = round((DOJ %--% today()) / dyears())) %>%
  mutate(seniority_level = cut(seniority, breaks = c(min(seniority), 10, max(seniority)), labels = c("junior", "senior"), include.lowest = TRUE)) %>%
  select(Employee_ID, Department_ID, age, seniority, seniority_level)
employee_new

# 3. Create a tibble `s_admission_new` of size 4000 x 4 with columns `Student_ID`,
#    `Department_Admission`, `age` and `school_year`, where `age` is the age of
#    the student and `school_year` is the class standing, which can be "graduate",
#    "senior", "junior", sophomore" or "freshman".
#    To do this, you can use:
#       - `mutate()` to create the columns
#          - `age` from `DOB` by
#            - Creating an interval with `%--%`, `today()` and `dyears()`.
#            - Rounding the years to integers with `round()`.
#          - `school_year` that categorizes `DOA` by
#            - Making `DOA` a factor with `factor()`.
#            - Collapsing the levels "2013-07-01" and "2014-07-01" into
#              "graduate" with `fct_collapse()`.
#            - Recoding the other levels with `fct_recode()` to make
#              - "2015-07-01" into "senior";
#              - "2016-07-01" into "junior";
#              - "2017-07-01" into "sophomore";
#              - "2018-07-01" into "freshman".
#       - `dplyr::select()` to select the desired columns.
#    To check your result, `s_admission_new` prints to:
#    # A tibble: 4,000 x 4
#       Student_ID  Department_Admission   age school_year
#       <chr>       <chr>                <dbl> <chr>
#     1 SID20131143 IDEPT7783               24 graduate
#     2 SID20131151 IDEPT6347               24 graduate
#     3 SID20131171 IDEPT1836               24 graduate
#     4 SID20131176 IDEPT8473               24 graduate
#     5 SID20131177 IDEPT5528               24 graduate
#     6 SID20131184 IDEPT5109               24 graduate
#     7 SID20131189 IDEPT8473               24 graduate
#     8 SID20131191 IDEPT3115               24 graduate
#     9 SID20131208 IDEPT6347               23 graduate
#    10 SID20131220 IDEPT2601               24 graduate
#    # … with 3,990 more rows
## Do not modify this line!
s_admission_new <- s_admission %>%
  mutate(age = round((DOB %--% today()) / dyears())) %>%
  mutate(school_year = factor(DOA)) %>%
  mutate(school_year = fct_collapse(school_year, 
                                    graduate = c("2013-07-01", "2014-07-01"))) %>%
  mutate(school_year = fct_recode(school_year,
                                  senior = "2015-07-01", 
                                  junior = "2016-07-01",
                                  sophomore = "2017-07-01", 
                                  freshman = "2018-07-01")) %>%
  select(Student_ID, Department_Admission, age, school_year)
s_admission_new


# 4. Create a tibble `s_performance_new` of size 3819 x 4 with columns
#    `Student_ID`, `mean_score`, `min_score` and `max_score`. `mean_score`,
#    `min_score` and `max_score` are aggregated across semesters and papers.
#    To do this, you can use:
#       - `group_by()` to group the data by `Student_ID`.
#       - `summarize()` to calculate the mean, minimum and maximum of `Marks`.
#    To check your result, `s_performance_new` prints to:
#    # A tibble: 3,819 x 4
#       Student_ID  mean_score min_score max_score
#       <chr>            <dbl>     <int>     <int>
#     1 SID20131143       71.7        22       100
#     2 SID20131151       72.6        40       100
#     3 SID20131171       70.9        20        99
#     4 SID20131176       70.9        42       100
#     5 SID20131177       70.3        29       100
#     6 SID20131184       66.3        19        99
#     7 SID20131189       64.3        40        99
#     8 SID20131191       69.8        21       100
#     9 SID20131208       68.9        40       100
#    10 SID20131220       69.1        21        98
#    # … with 3,809 more rows
## Do not modify this line!
s_performance_new <- s_performance %>%
  group_by(Student_ID) %>%
  summarize(mean_score = mean(Marks),
            min_score = min(Marks),
            max_score = max(Marks)) 
s_performance_new


# 5. Filter the tibble `department` for the Engineering School where
#    `Department_Name` has a match with the string "Engineering" (case insensitive).
#    Store the result into a tibble `department_engie` of size 17 x 2 with columns
#    `Department_ID` and `Department_Name`.
#    To do this, you can use:
#       - `filter()` to filter `Department_Name` for the Engineering School.
#         - `str_detect()` to detect the string `"Engineering"`
#           - `fixed()` to modify the matching pattern so that case differences
#             would be ignored.
#       - `dplyr::select()` to select the desired columns.
#    To check your result, `department_engie` prints to:
#    # A tibble: 17 x 2
#       Department_ID Department_Name
#       <chr>         <chr>
#     1 IDEPT4670     Aerospace Engineering
#     2 IDEPT5528     Biosciences and Bioengineering
#     3 IDEPT3115     Chemical Engineering
#     4 IDEPT4938     Civil Engineering
#     # … with 13 more rows
## Do not modify this line!
department_engie <- department %>%
  filter(str_detect(Department_Name, fixed("Engineering", ignore_case = TRUE))) %>%
  select(Department_ID, Department_Name)
department_engie

# 6. Join the tibbles `employee_new` and `department_engie` to create a tibble
#    `employee_joined` of size 422 x 6 with columns `Employee_ID`, `Department_ID`,
#    `age`, `seniority`, `seniority_level` and `Department_name`.
#    To do this, you can use `inner_join()` with the key `"Department_ID"`.
#    (Note that inner joins are used in this exercise to preserve integrity. For
#    instance, there is no employee record for three engineering departments.
#    Using some other types of joins will force NA's here.)
#    To check your result, `employee_joined` prints to:
#    # A tibble: 422 x 6
#       Employee_ID Department_ID   age seniority seniority_level Department_Name
#       <chr>       <chr>         <dbl>     <dbl> <fct>           <chr>
#     1 IU196557    IDEPT4938        37        10 junior          Civil Engineering
#     2 IU449901    IDEPT2357        34        10 junior          Energy Science and Engineering
#     3 IU206427    IDEPT4670        48        11 senior          Aerospace Engineering
#     4 IU572796    IDEPT1142        42        12 senior          Centre for Aerospace Systems Design and Engi…
#     5 IU393717    IDEPT1825        47        10 junior          Mechanical Engineering
#     6 IU826824    IDEPT8313        31        12 senior          Metallurgical Engineering & Materials Science
#     7 IU917848    IDEPT2357        43        17 senior          Energy Science and Engineering
#     8 IU423398    IDEPT4938        29        13 senior          Civil Engineering
#     9 IU710285    IDEPT3115        49         9 junior          Chemical Engineering
#    10 IU740065    IDEPT1423        30        20 senior          Computer Science & Engineering
#    # … with 412 more rows
## Do not modify this line!
employee_joined <- employee_new %>%
  inner_join(department_engie, by = "Department_ID")
employee_joined


# 7. With department and faculty information joined, we can investigate the
#    faculty make-up of each department. To facilitate comparison, we would also
#    like to know the size of the departments. From `employee_joined`, create
#    a tibble `department_size` of size size 14 x 2 with columns `Department_Name`
#    and `n`, where `n` is the department size in ascending order.
#    To do this, you can use:
#       - `dplyr::count()` to count `Department_Name` (the number of rows for
#          each department is the number of faculty).
#       - `arrange()` to sort the department size (i.e., `n`).
#    To check your result, `department_size` prints to:
#    # A tibble: 14 x 2
#      Department_Name                                                 n
#      <chr>                                                       <int>
#    1 Centre of Studies in Resources Engineering (CSRE)              23
#    2 Centre for Urban Science and Engineering (C-USE)               24
#    3 Centre for Aerospace Systems Design and Engineering (CASDE)    26
#    4 Centre for Environmental Science and Engineering (CESE)        28
#    # … with 10 more rows
## Do not modify this line!
department_size <- employee_joined %>%
  count(Department_Name) %>%
  arrange(n)
department_size


# 8. We will use `department_size` in the previous question as a helper tibble
#    for sorting the levels of `Department_Name` in `employee_joined`. Update
#    the original `employee_joined` tibble so that `Department_Name` becomes a
#    `factor` whose levels are sorted by department size.
#    To do this, you can use:
#       - `mutate()` to create (update) the column `Department_Name` by
#         - Making `Department_Name` a factor with `factor()`.
#           - Set `levels` of `Department_Name` as `Department_Name` in
#             `department_size` with `pull()`.
#    To check your result, the new `employee_joined` prints to:
#    # A tibble: 422 x 6
#       Employee_ID Department_ID   age seniority seniority_level Department_Name
#       <chr>       <chr>         <dbl>     <dbl> <fct>           <fct>
#     1 IU196557    IDEPT4938        37        10 junior          Civil Engineering
#     2 IU449901    IDEPT2357        34        10 junior          Energy Science and E…
#     3 IU206427    IDEPT4670        48        11 senior          Aerospace Engineering
#     4 IU572796    IDEPT1142        42        12 senior          Centre for Aerospace…
#     5 IU393717    IDEPT1825        47        10 junior          Mechanical Engineeri…
#     6 IU826824    IDEPT8313        31        12 senior          Metallurgical Engine…
#     7 IU917848    IDEPT2357        43        17 senior          Energy Science and E…
#     8 IU423398    IDEPT4938        29        13 senior          Civil Engineering
#     9 IU710285    IDEPT3115        49         9 junior          Chemical Engineering
#    10 IU740065    IDEPT1423        30        20 senior          Computer Science & E…
#    # … with 412 more rows
## Do not modify this line!
employee_joined <- employee_joined %>%
  mutate(Department_Name = factor(Department_Name, levels = pull(department_size, Department_Name)))
employee_joined


# 9. One important aspect of faculty make-up is seniority. Using `employee_joined`,
#    draw horizontal stacked bar charts for `Department_Name` with distribution
#    of `seniority_level` for each department.
#    To do this, you can use:
#       - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#       - `geom_bar()` to draw bar charts.
#       - `coord_flip()` to make the bar charts horizontal.
#       - `labs()` to format the labels such that:
#          - `title = "Number of Senior and Junior Professors by Department"`
#          - `subtitle = paste("Most departments have more senior professors.",
#                              "Exceptions are CASDE and Chemical Engineering.",
#                              sep = "\n")`
#          - `x = "Department's Name"`
#          - `fill = "Seniority Level"`
#          - `y = "Count (n)"`
#    Store the plot into a `ggplot` object `g1`.
## Do not modify this line!
g1 <- ggplot(employee_joined, 
             mapping = aes(x = Department_Name, fill = seniority_level)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Number of Senior and Junior Professors by Department",
       subtitle = paste("Most departments have more senior professors.",
                        "Exceptions are CASDE and Chemical Engineering.", sep = "\n"),
       x = "Department's Name",
       fill = "Seniority Level",
       y = "Count (n)") +
 theme_light()
g1

# 10. Join the tibbles `s_admission_new`, `s_performance_new` and `department_engie`
#     to create a new tibble `student_joined` of size 1740 x 8 with columns
#     `Student_ID`, `Department_Admission`, `age`, `school_year`, `mean_score`,
#     `min_score` and `max_score` and `Department_Name`.
#     To do this, you can use:
#        - `inner_join()` with the key `"Student_ID"` to join `s_admission_new`
#          with `s_performance_new`.
#        - `inner_join()` with the key `"Department_Admission"` in the left table
#          and `"Department_ID"` in the right table to join `department_engie`.
#     To check your result, `student_joined` prints to:
#     # A tibble: 1,740 x 8
#        Student_ID Department_Admi…   age school_year mean_score min_score
#        <chr>      <chr>            <dbl> <chr>            <dbl>     <int>
#      1 SID201311… IDEPT7783           24 graduate          71.7        22
#      2 SID201311… IDEPT8473           24 graduate          70.9        42
#      3 SID201311… IDEPT5528           24 graduate          70.3        29
#      4 SID201311… IDEPT8473           24 graduate          64.3        40
#      5 SID201311… IDEPT3115           24 graduate          69.8        21
#      6 SID201312… IDEPT1825           24 graduate          70.0        40
#      7 SID201312… IDEPT5564           24 graduate          66.9        24
#      8 SID201313… IDEPT2054           23 graduate          68.8        40
#      9 SID201313… IDEPT2054           24 graduate          72.5        42
#     10 SID201314… IDEPT3115           24 graduate          70.2        40
#     # … with 1,730 more rows, and 2 more variables: max_score <int>,
#     #   Department_Name <chr>
## Do not modify this line!
student_joined <- s_admission_new %>%
  inner_join(s_performance_new, by = "Student_ID") %>%
  inner_join(department_engie, by = c("Department_Admission" = "Department_ID"))
student_joined


# 11. The tibble `student_joined` contains complete information about students
#     at the Engineering School. For initial exploration, draw horizontal
#     boxplots for `mean_score` vs. `school_year`. The boxplots should be sorted
#     by descending medians.
#     To do this, you can use:
#        - `ggplot()` to initialize a ggplot object and specify the variables to plot.
#          - `fct_reorder()` to order the levels of `school_year` by `mean_score`.
#        - `geom_boxplot()` to draw boxplots.
#        - `coord_flip()` to make the boxplots horizontal.
#        - `labs()` to format the labels such that:
#           - `title = "Student Academic Performance by Class Standing at Engineering School"`
#           - `subtitle = "Distribution is similar across years."`
#           - `x = "Class Standing"`
#           - `y = "Mean Paper Score"`
#     Store the plot into a `ggplot` object `g2`.
## Do not modify this line!
g2 <- ggplot(data = student_joined,
             mapping = aes(x = fct_reorder(school_year, mean_score), y = mean_score)) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Student Academic Performance by Class Standing at Engineering School",
       subtitle = "Distribution is similar across years.",
       x = "Class Standing",
       y = "Mean Paper Score") +
  theme_light()
g2


# 12. We would like to explore what could affect a student's academic performance
#     from the faculty aspect, particularly in seniority of professors. Create
#     a tibble `employee_senior` from `employee_joined` of size 14 x 2 with
#     columns `Department_ID` and `seniority`, where `seniority` is the median
#     seniority for each department.
#     To do this, you can use:
#        - `group_by()` to group data by `Department_ID`.
#        - `summarize()` to compute an overall median of `seniority`.
#     To check your result, `employee_senior` prints to:
#     # A tibble: 14 x 2
#        Department_ID seniority
#        <chr>             <dbl>
#      1 IDEPT1142          10.5
#      2 IDEPT1423          14
#      3 IDEPT1825          13
#      4 IDEPT2054          14.5
#     # … with 10 more rows
## Do not modify this line!
employee_senior <- employee_joined %>%
  group_by(Department_ID) %>%
  summarize(seniority = median(seniority))
employee_senior



# 13. Join the tibbles `student_joined` and `employee_senior` to create a final
#     `school_year`, `mean_score`, `min_score`, `max_score`, `Department_Name`
#     and `seniority`.
#     To do this, you can use:
#        - `inner_join()` with the key `"Department_Admission"` in the left table
#          and `"Department_ID"` in the right table to join `employee_senior`.
#        - `dplyr::select()` to select the desired columns.
#     To check your result, `engie` prints to:
#     # A tibble: 1,429 x 8
#        Student_ID   age school_year mean_score min_score max_score
#        <chr>      <dbl> <fct>            <dbl>     <int>     <int>
#      1 SID201311…    24 graduate          71.7        22       100
#      2 SID201311…    24 graduate          70.3        29       100
#      3 SID201311…    24 graduate          69.8        21       100
#      4 SID201312…    24 graduate          70.0        40       100
#      5 SID201313…    23 graduate          68.8        40       100
#      6 SID201313…    24 graduate          72.5        42       100
#      7 SID201314…    24 graduate          70.2        40        99
#      8 SID201314…    24 graduate          69.4        23        98
#      9 SID201315…    24 graduate          69.8        41       100
#     10 SID201315…    24 graduate          63.3        20        97
#     # … with 1,419 more rows, and 2 more variables: Department_Name <chr>,
#     #   seniority <dbl>
## Do not modify this line!
engie <- student_joined %>%
  inner_join(employee_senior, by = c("Department_Admission" = "Department_ID")) %>%
  select(Student_ID, age, school_year, mean_score, min_score, max_score, Department_Name, seniority)
engie


# 14. With the final tibble `engie`, we are interested in the relationships
#     between professor seniority and student academic performance.
#     Draw pair plots of the variables `seniority`, `mean_score`, `min_score`
#     and `max_score`.
#     To do this, you can use:
#        - `ggpairs()` to draw pair plots for columns of interests
#        - `labs()` to format the labels such that:
#          - `title = "Correlation between Professor Seniority and Student Academic Performance"`
#          - `subtitle = "No significant correlation is found."`
#     Store the plot into a `ggplot` object `g3`.
## Do not modify this line!
g3 <- ggpairs(data = engie, 
              columns = c("seniority", "mean_score", "min_score", "max_score")) +
  labs(title = "Correlation between Professor Seniority and Student Academic Performance",
       subtitle = "No significant correlation is found.") +
  theme_light()
g3



