(load "./db-match.scm")
(load "./assert.scm")

(define (list-match str1 str2)
  (let ((acc '()))
    (let ((phs (db-match? str1 str2)))
      (when phs
        (set! acc (cons (reverse phs) acc))
        (db-match-next)))
    (reverse acc)))

(assert-equal 'Ex-X '(( (#\a . "1"  ) (#\b . "112211") )
                      ( (#\a . "11" ) (#\b . "1221"  ) )
                      ( (#\a . "111") (#\b . "22"    ) ))
              (list-match "aba" "11122111"))

(assert-equal 'Ex-Y '(( (#\a . "1"  ) (#\b . "1" ) (#\c . "1223221") )
                      ( (#\a . "1"  ) (#\b . "11") (#\c . "22322"  ) )
                      ( (#\a . "11" ) (#\b . "1" ) (#\c . "22322"  ) )
                      ( (#\a . "111") (#\b . "2" ) (#\c . "232"    ) )
                      ( (#\a . "111") (#\b . "22") (#\c . "3"      ) ))
              (list-match "abcba" "11122322111"))

(assert-equal 'Ex-Z '(( (#\a . "d"    ) (#\b . "ogcat") (#\c . "rat") )
                      ( (#\a . "do"   ) (#\b . "gcat" ) (#\c . "rat") )
                      ( (#\a . "dog"  ) (#\b . "cat"  ) (#\c . "rat") )
                      ( (#\a . "dogc" ) (#\b . "at"   ) (#\c . "rat") )
                      ( (#\a . "dogca") (#\b . "t"    ) (#\c . "rat") ))
              (list-match "abcab" "dogcatratdogcat"))

(exit)
