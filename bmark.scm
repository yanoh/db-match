(define (db-match? str1 str2)
  (call/cc
    (lambda (cc)
      (set! try-again-or-fail (lambda () (cc #f)))
      (match? (string->list str1) str2 '() (lambda (phs) (cc phs))))))

(define (db-match-next) (try-again-or-fail))

(define (match? pat str phs succeed)
  (cond
    ((and (null? pat) (zero? (string-length str))) (succeed phs))
    ((or  (null? pat) (zero? (string-length str))) (try-again-or-fail))
    (else
      (let* ((phnam (car pat))
             (phent (assoc phnam phs)))
        (if phent
          (let* ((phval (cdr phent))
                 (phlen (string-length phval)))
            (if (string-start-with? str phval)
              (match? (cdr pat) (substring str phlen (string-length str))
                      phs succeed)
              (try-again-or-fail)))
          (let* ((phval (choose (expand-prefix str)))
                 (phlen (string-length phval)))
            (match? pat str (cons (cons phnam phval) phs) succeed)))))))

(define (string-start-with? str pre)
  (let ((len (string-length pre)))
    (and (<= len (string-length str))
         (equal? (substring str 0 len) pre))))

(define (expand-prefix str)
  (letrec ((loop
             (lambda (len acc)
               (if (zero? len)
                 acc
                 (loop (- len 1) (cons (substring str 0 len) acc))))))
    (loop (string-length str) '())))

(define (choose lst)
  (if (null? lst)
    (try-again-or-fail)
    (let ((try-again-or-fail-0 try-again-or-fail))
      (call/cc
        (lambda (cc)
          (set! try-again-or-fail
                (lambda ()
                  (set! try-again-or-fail try-again-or-fail-0)
                  (cc (choose (cdr lst)))))
          (cc (car lst)))))))

(define try-again-or-fail '())

(letrec ((repeat
           (lambda (n thunk)
             (unless (zero? n)
               (thunk)
               (repeat (- n 1) thunk)))))
  (repeat 100000
          (lambda ()
            (unless (db-match? "abba" "dogcatcatdog")
              (display "fail\n")
              (exit)))))

(exit)
