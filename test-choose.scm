(load "./db-match.scm")

(define (test-driver)
  (let ((choice (enumerate-choice-if
                  (lambda (choice) (even? (apply + choice)))
                  '(1 2 3) '(4 5) '(6 7 8))))
    (when choice
      (display choice)
      (display " match!\n")
      (try-again-or-fail))))

(define (enumerate-choice-if pred . args)
  (call/cc
    (lambda (cc)
      (set! try-again-or-fail (lambda () (cc #f)))
      (enumerate-choice-if-aux
        pred args (lambda (choice) (cc choice))))))

(define (enumerate-choice-if-aux pred lst success)
  (letrec ((multi-choose
             (lambda (rest acc)
               (if (null? rest)
                 (reverse acc)
                 (let ((n (choose (car rest))))
                   (multi-choose (cdr rest) (cons n acc)))))))
    (let ((choice (multi-choose lst '())))
      (cond
        ((pred choice) (success choice))
        (else
          (display choice)
          (display " unmatch...\n")
          (try-again-or-fail))))))

(test-driver)
(exit)

;; [output]
;; (1 4 6) unmatch...
;; (1 4 7) match!
;; (1 4 8) unmatch...
;; (1 5 6) match!
;; (1 5 7) unmatch...
;; (1 5 8) match!
;; (2 4 6) match!
;; (2 4 7) unmatch...
;; (2 4 8) match!
;; (2 5 6) unmatch...
;; (2 5 7) match!
;; (2 5 8) unmatch...
;; (3 4 6) unmatch...
;; (3 4 7) match!
;; (3 4 8) unmatch...
;; (3 5 6) match!
;; (3 5 7) unmatch...
;; (3 5 8) match!
