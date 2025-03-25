# 03/25/2025 12:36 PM
This session I plan to implement the expression prompt and handling the input
- The program will first prompt the user for a valid expression. If the expression is invalid, it will throw an error.
- Once the program receives a valid expression it will then parse it and add each operation and digit to a list for calculation in the order they are provided. The parsing will check for optional whitespace and whether or not the digit is an integer. 

Notes:
I have decided to check if the operations are valid first before trying to evaluate any of the expressions.
The way I am thinking of handling this is:
- first, check if all the operations are valid. otherwise throw an error
- check the digits (whether they are separated by white space or if they are an integer)
- evaluate the expression after all is clear

# 03/25/2025 2:04 PM

