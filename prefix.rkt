#lang racket
(define batch?
   (let [(args (current-command-line-arguments))]
     (cond
       [(= (vector-length args) 0) #t]
       [(string=? (vector-ref args 0) "-b") #f]
       [(string=? (vector-ref args 0) "--batch") #f]
       [else #t])))

; converts digits in a string format to an actual number ("8" -> 8)
(define (convert_str_to_num str)
  (if (regexp-match? #px"^\\d+$" str)
      (string->number str)
      str))

; this splits the expression into a list of operators and digits (str -> lst)
; returns the list of all multi-digit nums, single digit nums, and operators
(define (split_exp str)
  (map convert_str_to_num (regexp-match* #px"\\$\\d+|\\d+|[-+*/]" str)))

(define valid_operations '("+" "*" "/" "-"))
(define binary_ops '("+" "*" "/"))
(define unary_ops '("-"))

(define (valid-number? val)
  (or (number? val)
    (and (string? val)
      (regexp-match? #px"^\\$\\d+$" val)
    )
  )
)

; this function makes sure the syntax is valid (e.i if the operators and operands are in a valid order)
(define (parse_prefix_syntax lst)
  (cond
    [(null? lst) #f]
    [(member (car lst) binary_ops)
      (let ([remaining (cdr lst)])
        (define next (parse_prefix_syntax remaining))
        (if next (parse_prefix_syntax next) #f))]
    [(member (car lst) unary_ops)
      (let ([remaining (cdr lst)]) 
        (parse_prefix_syntax remaining)
    )]
    [else
      (if (valid-number? (car lst)) (cdr lst) #f)
    ]
  )
)

; simple runner function to execute the parse_prefix_syntax function
(define (check_syntax lst)
  (let ([expression (parse_prefix_syntax lst)])
    (and expression (null? expression))
  )
)

; this checks if the split expression is valid (lst -> #t or #f)
; uses regex to find the digits
(define (check_operations lst)
  (andmap (lambda (c)
    (or (number? c)
      (and (string? c) (or (member c valid_operations) (regexp-match? #px"^\\$\\d+$" c)))))
      lst))

; main evaluation function that runs all checks on the expression input (input_expression -> #t or #f) throws an error if #f
(define (validate_expression str)
  (cond
    [(not (check_operations (split_exp str)))
      (error "Error: Invalid operations or values used.")
      #f
    ]
    [(not (check_syntax (split_exp str)))
      (error "Error: Invalid prefix syntax.")
      #f
    ]
    [else #t]
  )
)

; this function applies the operator on two operands
(define (binary-calculation op val1 val2)
  (cond
    [(string=? op "+") (+ val1 val2)]
    [(string=? op "*") (* val1 val2)]
    [(and (string=? op "/") (zero? val2))
      (displayln "Error: Cannot divide by 0")
    ]
    [(string=? op "/") (/ val1 val2)]
    [else (error "Error: Invalid Operation")]
  )
)

; this function applies the operator on one operand
(define (unary-calculation op val1)
  (cond
    [(string=? op "-") (- val1)]
    [else (error "Error: Invalid Operation")]
  )
)

; this is the main calculator function that computes each expression
(define (prefix-calculator exp-lst history)
  (cond
    [(number? (car exp-lst))
      (values (car exp-lst) (cdr exp-lst))
    ]
    [(string? (car exp-lst))
      (let ([current (car exp-lst)])
        (cond
          ; if the current operator is a binary operator
          ; perform the calculations with recursion per needed operand
          [(member current binary_ops)
            (let*-values (
              [(op1 remaining1) (prefix-calculator (cdr exp-lst) history)]
              [(op2 remaining2) (prefix-calculator remaining1 history)])
            (values (binary-calculation current op1 op2) remaining2))
          ]
          ; if the current operator is a unary operator
          ; only do recursion once
          [(member current unary_ops)
            (let*-values (
              [(op remaining) (prefix-calculator (cdr exp-lst) history)])
              (values (unary-calculation current op) remaining))
          ]
          ; if the operand is a history reference
          ; convert the reference num to from str to number
          ; make sure it is not out of bound, then return the corresponding value
          [(regexp-match? #px"^\\$\\d+$" current)
            (let* (
              [history-ref (string->number (substring current 1))]
              [history-lst-reversed (reverse history)]
              [history-lst-length (length history-lst-reversed)])

              (if (and (>= history-ref 1) (<= history-ref history-lst-length))
                (values (list-ref history-lst-reversed (- history-ref 1)) (cdr exp-lst))
                (error "Error: History reference out of bounds")))]))]))

; the main function that runs the program and updates the calculation history 
(define (main history)
  (let ([user-input (read-line)])
    (cond
      [(string-ci=? user-input "quit") (void)]
      [else 
        (if (validate_expression user-input)
            ; process errors with messages or run the program if able 
            (with-handlers ([exn? (lambda (e) (displayln (exn-message e)) (main history))])
              (let-values ([(value remaining) (prefix-calculator (split_exp user-input) history)])
                (let* ([updated_history (cons value history)])
                  (if (not batch?)
                    (display (real->double-flonum value))
                    (begin
                      (display (length updated_history))
                      (display ": ")
                      (display (real->double-flonum value))
                    )
                  )
                  (newline)
                  (main updated_history))))
            (main history))])))

; runs the program
(main '())
  

