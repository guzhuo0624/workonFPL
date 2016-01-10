#lang racket

(require rackunit)
(require rackunit/text-ui)
(require "lab7.ss")

(define-test-suite lab7-test-suite
  
  (test-equal?
   "map1"
   (map1 abs '(1 -2 -4))
   '(1 2 4))
  
  (test-equal?
   "map1-tail"
   (map1-tail abs '(1 -2 -4))
   '(1 2 4))
  
  (test-equal?
   "mmap-cons"
   (mmap cons '(1 2 3) '((1) (2) (3)))
   '((1 1) (2 2) (3 3)))

  (test-equal?
   "mmap-+"
   (mmap + '(1 2 3) '(1 2 3) '(1 2 3))
   '(3 6 9))

  (test-equal?
   "deep-map"
   (deep-map abs '(-1 ((-2 3 ((-4)) 5) -6 -7))) 
   '(1 ((2 3 ((4)) 5) 6 7)))

  )
(run-tests lab7-test-suite)