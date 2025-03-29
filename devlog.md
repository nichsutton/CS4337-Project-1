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

# 03/27/2025 11:03 PM - Session Start
This session I plan finish the list creation so it includes the "-" and "$" operators in groups such that one element will become "-5" or "$4"
I also plan to finish the calculation process with both interative and batch mode.
I plan to finish the error handling for dividing by zeros and if there are too few operators, operands, or an incorrect order.

- I have finished the list creation
- now I need to check if the expression in syntacitally correct
- - To do this I need to check if each operator is unary or binary to decide how many operands it takes. I need to check if each operator correctly calculates their operands such that there are no operands remaining. I also implemented the convert_str_to_num function
- The expression validation for syntax is now finished.
- Now I need to check dividing by zero errors and start outputting errors to the screen. (this cannot be done until I implement the actual calculations)
- now I need to implement the calculator to compute results without using the history reference first

# 03/28/2025 1:39 AM - Session End
I have finished most of the error checking and have been researching methods to implement the actual calculation process. I have been able to group history tagged numbers with their "$" and store them in the list. For my next session I plan to finish the calculation process on both the batch and interaction version, and finish the project. This includes the history retrieval when given the "$n" input, int -> float conversions, and any unforeseen errors that may need to be accounted for.

# 03/28/2025 11:36 AM - Session Start
This session I plan to completely finish the prefix calculation so that it returns an output with a usage history.

The prefix-calculator function works as such:
- First makes sure the input is valid and ready to be calculated
- Find out if the current value is an operator and if it is binary or unary 
- If it is binary we get the next 2 values needed to compute the operation with recursion
- If it is unary we only get the 1 value
- Then we apply the corresponding calculation function to complete the operation for that operator
- If the value is a history reference we make sure it is not out of bounds 
- If it a value reference we obtain the value at that reference index
- This function is run through a main function that loops through each expression and adding it to the history

Notes:
- First i need to create functions that apply the operation on the operands
- implemented the calculation, but there are still bugs where it solves parts of an invalid expression until it reaches an operator or operand that becomes invalid.
- I have also noticed that when an error occurs it will sometimes crash the program. Researching methods to fix this led me to use the "with-handlers" function to allow a cleaner user experience.
- most of the bugs have been ironed out, but there is still a slight error when dividing by 0s. it will not solve it, but briefly show the history value such that it did. 
- The history bug is now fixed. I solved this by using error instead of displayln, then using with-handlers to interpret the error message and display it.

# 03/28/2025 9:23 PM - Session End
I have accomplish my goal for this session. There was one bug which I was unable to solve that will reset the history if a syntax error occurs. I suspect this is being caused by the error handling. Other than that, the program should run as expected.
