# 03/25/2025 12:36 PM - Session Start
This session I plan to implement the expression prompt and handling the input
- The program will first prompt the user for a valid expression. If the expression is invalid, it will throw an error.
- Once the program receives a valid expression it will then parse it and add each operation and digit to a list for calculation in the order they are provided. The parsing will check for optional whitespace and whether or not the digit is an integer. 

Notes:
I have decided to check if the operations are valid first before trying to evaluate any of the expressions.
The way I am thinking of handling this is:
- first, check if all the operations are valid. otherwise throw an error
- check the digits (whether they are separated by white space or if they are an integer)
- evaluate the expression after all is clear

# 03/25/2025 2:04 PM - Session End
I have accomplished a portion of my goal this session. I have made progress towards the expression validation by checking for valid operations.
For my next session I will continue working on the expression validation by taking into account the order of the operators and digits.

# 03/25/2025 9:48 PM - Session Start
This session I plan to continue working on my expression validation. I also plan to check if the expression can be solved without error, and possibly assemble the overall structure of the prefix calculator.

Notes:
- There was an error with using char-numeric? for multi-digit numbers, so I had to use a regex expression instead to capture them
- The same was done to check the expression for operation errors since it was much easier to implement
- the convert to number function was added, and will be used later to perform actual calculations on
- Not sure how to handle $n yet since the history feature is not implemented

# 03/25/2025 11:19 PM - Session End
This session I was unable to fully check if an expression can be solved without errors, but I was able to detect operational errors.
I have made good progress towards the overall structure, successfully splitting the expression into a list and creating a function to turn
string numbers into integer numbers. One main issue I have encountered is the $n value, I will revisit these function to take it into account once I have implemented the history feature. Next session I will start on the actual calculations for the expression.


