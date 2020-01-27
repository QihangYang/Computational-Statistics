#' HW3: map5
#'
#' In this exercise, we will play around with `got_chars` data from `repurrrsive` package. For this exercise, you are not allowed to use `for`, `while`, or `repeat` loops.
#'
#' 1. Load the `purrr` and `repurrrsive` packages. Use `map_chr` to extract all the `name` from `got_chars`, store them into a vector of characters called `name_list`.
#'    Then, use `map` to extract all the `aliases` from `got_chars`, store them into a list called `nick_name_list`.
## Do not modify this line!
library(purrr)
library(repurrrsive)
name_list <- map_chr(got_chars, "name")
nick_name_list <- map(got_chars, "aliases")





#' 2. Make a function called `hello` with argument `x` (e.g., `hello(x)`). Inside the `hello` function, use `paste` to concatenate `Hello `, `x` and `!\n`, the `sep` should be empty.
#'    Use `map_chr` and `hello` functions to save sentences like `Hello ` + name in name_list + `!\n` into a vector `hello_sentences`.
## Do not modify this line!
hello <- function(x){
	paste("Hello ", x, "!\n", sep = "")
}
hello_sentences <- map_chr(name_list, hello)



#' 3. Use `map_chr` and `paste` functions to add ` or ` to collapse aliases of each person. Store returned values into list `nick_name_list_update`.
#'    For instance, the first element will be `"Prince of Fools or Theon Turncloak or Reek or Theon Kinslayer"`
## Do not modify this line!
nick_name_list_update <- map_chr(nick_name_list, ~ paste(.x, collapse = " or "))


#' 4. Use `map2_chr` on `name_list` and `nick_name_list_update` along with `paste` to insert `can be called` when mapping.
#'    For instance, if the first element of `name_list` is `"A"`, and the corresponding element of `nick_name_list_update` is `"B or C"`,
#'    you are supposed to get `"A can be called B or C"`.
#'    Store the resulting vector of characters into `sentences_list`.
## Do not modify this line!
sentences_list <- map2_chr(name_list, nick_name_list_update, ~ paste(.x, "can be called", .y))



