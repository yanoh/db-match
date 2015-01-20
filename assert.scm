(define (assert-true id val)
  (if val
    (display (string-append (symbol->string id) ": OK\n"))
    (display (string-append (symbol->string id) ": NG\n"))))

(define (assert-false id val) (assert-true id (not val)))

(define (assert-equal id expected actual)
  (if (equal? expected actual)
    (display (string-append (symbol->string id) ": OK\n"))
    (begin
      (display (string-append (symbol->string id) ": NG ("))
      (display expected)
      (display " expected, but got ")
      (display actual)
      (display ")\n"))))
