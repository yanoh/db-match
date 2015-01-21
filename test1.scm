(load "./db-match.scm")
(load "./assert.scm")

(assert-true  'Ex-1 (db-match? "aba" "foobarfoo"))
(assert-false 'Ex-2 (db-match? "aba" "foobarbaz"))
(assert-true  'Ex-3 (db-match? "abc" "foobarbaz"))
(assert-true  'Ex-4 (db-match? "aca" "foobarbazf"))

(assert-true  'Ex-5 (db-match? "aba" "dogcatdog"))
(assert-true  'Ex-6 (db-match? "aab" "dogdogcat"))
(assert-false 'Ex-7 (db-match? "baa" "dogdogcat"))
(assert-false 'Ex-8 (db-match? "aba" "doggycat"))
(assert-true  'Ex-9 (db-match? "aba" "doggycatdog"))

(assert-true  'Ex-A (db-match? "aba" "しんぶんし"))
(assert-false 'Ex-B (db-match? "abb" "しんぶんし"))
(assert-true  'Ex-C (db-match? "aba" "山本山"))
(assert-true  'Ex-D (db-match? "bab" "山本山"))

(assert-true  'Ex-E (db-match? "" ""))
(assert-false 'Ex-F (db-match? "a" ""))
(assert-false 'Ex-G (db-match? "" "dog"))
(assert-true  'Ex-H (db-match? "a" "dog"))
(assert-true  'Ex-I (db-match? "a" "dogcat"))
(assert-true  'Ex-J (db-match? "abccba" "dogcatratratcatdog"))

(exit)
