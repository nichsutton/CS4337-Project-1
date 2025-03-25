#lang racket
(define prompt?
   (let [(args (current-command-line-arguments))]
     (cond
       [(= (vector-length args) 0) #t]
       [(string=? (vector-ref args 0) "-b") #f]
       [(string=? (vector-ref args 0) "--batch") #f]
       [else #t])))


(define test_exp "+*2p1+$2")

; code used for checking if each operation exists in the set of valid operations to use (returns true or false)
; this code does NOT yet confirm if the expression is actually valid.
(define valid_operations '("+" "*" "/" "-" "$"))
(define (check_operations lst)
  (andmap (lambda (c)
         (or (char-numeric? c)
              (member (string c) valid_operations))) lst))
         
  
(define expression_input (read-line))

(define (validate_expression expression)
  (displayln (string-split expression)))
  

