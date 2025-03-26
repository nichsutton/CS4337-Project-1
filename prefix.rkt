#lang racket
(define prompt?
   (let [(args (current-command-line-arguments))]
     (cond
       [(= (vector-length args) 0) #t]
       [(string=? (vector-ref args 0) "-b") #f]
       [(string=? (vector-ref args 0) "--batch") #f]
       [else #t])))


(define test_exp "+*2$1+$2 1")

  
; reads the expression from the user
(define expression_input (read-line))

; HELPER FUNCTION (split_exp) - converts digits in a string format to an actual number ("8" -> 8)
(define (convert_str_to_num str)
  (if (regexp-match? #px"^\\d+$" str)
      (string->number str)
      str))

; this splits the expression into a list of operators and digits (str -> lst)
; returns the list of all multi-digit nums, single digit nums, and operators
(define (split_exp str)
  (regexp-match* #px"\\d+|\\S" str))

; HELPER VALUE (check_operations) - this code does NOT yet confirm if the expression is actually valid.
(define valid_operations '("+" "*" "/" "-" "$"))

; this checks if the split expression is valid (lst -> #t or #f)
; uses regex to find the digits
(define (check_operations lst)
  (andmap (lambda (c)
         (or (regexp-match? #px"^\\d+$" c) 
              (member c valid_operations))) lst))

; main evaluation function that runs all checks on the expression input (input_expression -> #t or #f) throws an error if #f
(define (validate_expression str)
  (check_operations (split_exp str)))
  

