# HW4: OOP_account
#'
# In this exercise, we will create a class `account`.
#'
# 1. Create a constructor `new_account(number)` that takes in a length 2 numeric
#    vector and initiates an object of class `account` using `structure`.
#    Class `account` should have an attribute `units` which is always the character vector `c('USD', 'EUR')`.
#    The value should be the amount of money in each currency.
#    Don't forget to use `stopifnot` to check if `number` is numeric or not and if the length of number is different from 2.
#    For example, `new_account(c(5, 0))` will create an account with 5 USD.
#    `new_account(c(0, 5))` will create an account with 5 EUR.
#    `new_account(c(5, 10))` will create an account with 5 USD and 10 EUR.
## Do not modify this line!
new_account <- function(number){
	stopifnot(is.numeric(number))
	stopifnot(length(number) == 2)
	attr(number, "units") <- c("USD", "EUR")
	structure(number, class = "account")
}


# 2. Use `pmatch` to reate a function `get_unit_index(units)` to get the index of input `units` in `c('USD, 'EUR')`.
#    You are supposed to use this function in the following questions.
#    For example, `get_unit_index('EUR') = 2`. `get_unit_index('US') = 1`.
#    `get_unit_index('U','E') = c(1, 2)`.
## Do not modify this line!
get_unit_index <- function(units){
	return(pmatch(units, c("USD", "EUR")))
}



# 3. Create a helper function `account(number, units)` that takes in a scalar or vector `number`
#    with corresponding `units` which initiates an object of class `account`.
#    `units` might include `EUR`, `USD`.
#    For example, `account(5, 'USD')` will create an account with 5 USD.
#    `account(5, 'EUR')` will create an account with 5 EUR.
#    `account(c(5, 10), c('EUR', 'USD'))` will create an account with 5 EUR and 10 USD.
#    Create an account with 100 USD and 100 EUR. Save it as `my_account`.
## Do not modify this line!
account <- function(number, units){
	numbers = c(0,0)
	numbers[get_unit_index(units)] <- number
	new_account(numbers)
}
my_account <- account(c(100,100), c("USD", "EUR"))



# 4. Creat two generic functions `deposit(account, number, units)` and `withdraw(account, number, units)`
#    that takes in a scalar or vector `number` with corresponding `units`.
#    `units` might include `EUR`, `USD`.
#    Methods `deposit.account` and `withdraw.account` should return an object of class `account` with correct amounts.
#    Deposit 50 USD and withdraw 50 EUR for `my_account`.
## Do not modify this line!
deposit <- function(account, number, units){
	UseMethod("deposit")
}
deposit.account <- function(account, number, units){
	account[get_unit_index(units)] <- account[get_unit_index(units)] + number
	return(account)
}
withdraw <- function(account, number, units){
	UseMethod("withdraw")
}
withdraw.account <- function(account, number, units){
	account[get_unit_index(units)] <- account[get_unit_index(units)] - number
	return(account)
}
my_account <- deposit.account(my_account, 50, "USD")
my_account <- withdraw.account(my_account, 50, "EUR")



# 5. Write a new `summary` method for class `account`. `summary(account, units)` should return a named vector
#    which has the same length and names as `units`.
#    The reurn value should be the total amount of the `account` in `units`.
#    For simplicity, 1 EUR = 1.1 USD.
#    For example, `summary(my_account, c('USD', 'EUR'))` should return a named vector with values `c(150, 50)`.
#    `summary(my_account, 'USD')` should return a named vector with value `205`.
## Do not modify this line!
summary.account <- function(account, units){
	usd <- account[1]
	eur <- account[2]
	res <- vector(length = length(units))
	names(res) <- units
	if (length(units) == 1)
		if(get_unit_index(units) == 1)
			res[1] <- usd + eur * 1.1
		else 
			res[1] <- usd /1.1 + eur
	else 
		if(units[1] == "USD"){
			res[1] <- usd 
			res[2] <- eur
		}
		else{
			res[1] <- eur
			res[2] <- usd
		}
	return(res)
}


# 6. Now let's consider a subclass `minimum_balance_account` which should maintain a pre-determined minimum balance.
#    Create a constructor `new_minimum_balance_account(number, minimum)` that takes in legnth 2 numeric vectors and
#    initiates an object of subclass `minimum_balance_account` using `structure`.
#    Subclass `minimum_balance_account` should have an attribute `units` which is always
#    the character vector `c('USD', 'EUR')` and an attribute `minimum` which is a numeric vector.
#    The value should be the amount of money in each currency.
#    Don't forget to use `sopifnot` to check if `number` and `minimum` are numeric or not.
#    For example, `new_minimum_balance_account(c(5, 0), c(1, 0))` will create an account
#    with 5 USD and minimum balance 1 USD.
## Do not modify this line!
new_minimum_balance_account <- function(number, minimum){
	stopifnot(is.numeric(number))
	stopifnot(is.numeric(minimum))
	stopifnot(length(number) == 2)
	stopifnot(length(minimum) == 2)
	attr(number, "units") <- c("USD", "EUR")
	attr(number, "minimum") <- minimum
	structure(number, class = "minimum_balance_account")
}




# 7. Create a helper function `minimum_balance_account(number, units, minimum, minimum_units)`
#    that takes in a scalar or vector `number` and `minimum`
#    with corresponding `units` and `minimum_units` which initiates an object of subclass `minimum_balance_account`.
#    `units` and `minimum_units` might include `EUR`, `USD`.
#    For example, `minimum_balance_account(5, 'USD', 1, 'USD')` will create an account
#    with 5 USD and minimal balance 1 USD.
## Do not modify this line!
minimum_balance_account <- function(number, units, minimum, minimum_units){
	x <- c(0,0)
	x[get_unit_index(units)] <- number
	y <- c(0,0)
	y[get_unit_index(minimum_units)] <- minimum
	new_minimum_balance_account(x, y)
}




# 8. Add method for `withdraw` and modify `deposit.account` if needed such that:
#    a. The returned value should be the same class of input `account`.
#    b. Function `deposit` can accpet `minimum_balance_account` and return correct object.
#    c. If withdraw will cause the balance lower than the minimum balance,
#       report an error 'Minimum balance must be maintained.'.
#    d. Use `withdraw.account` in `withdraw.minimum_balance_account`.
## Do not modify this line!
withdraw.minimum_balance_account <- function(account, number, units){
	account <- withdraw.account(account, number, units)
	if(any(account < attr(account, "minimum")))
		stop("Minimum balance must be maintained.")
	return(account)
}


