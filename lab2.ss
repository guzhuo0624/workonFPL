#lang scheme

(require test-engine/scheme-tests)
; throughout this module we represent a vector by a list
; and a matrix by a list of lists of numbers
; you may assume all list sizes are such that we have
; well-defined matrices.
; An empty matrix is an empty list.

; (dot-product v1 v2) -> number
; v1, v2: list of number, of the same size
; return the dot product of v1 and v2
; a recursive version
(define dot-product-rec
  (λ (xs ys)
    (if (empty? xs)
        0
        (+ (* (first xs) (first ys)) (dot-product-rec (rest xs) (rest ys)))))) 

; no recursion! use map and apply
(define dot-product 
  (λ (v1 v2)
    (apply + (map * v1 v2))))
(check-expect (dot-product-rec '(1 -2 6) '(-2 0 1)) 4)
(check-expect (dot-product '(1 -2 6) '(-2 0 1)) 4)

; (add v1 v2) -> list of number 
; v1, v2: list of number
; return v1 + v2
; a recursive version 
(define vector-add-rec 
  (λ (v1 v2)
    (if (empty? v1)
        empty
        (cons (+ (first v1) (first v2)) (vector-add-rec (rest v1) (rest v2))))))
; no recursion: use map
(define vector-add
  (λ (v1 v2)
    (map + v1 v2)))
(check-expect (vector-add '(1 2 3) '(-1 3 -2)) '(0 5 1))
(check-expect (vector-add-rec '(1 2 3) '(-1 3 -2)) '(0 5 1))

; (add m1 m2) -> list of list of number
; m1, m2: list of list of number, of same dimensions
; return m1 + m2 for matrices m1, m2
; no recursion: use map
(define add 
  (λ (v1 v2)
    (map vector-add v1 v2)))

(define m1 '((1 0 2)
             (2 1 4)
             (-1 1 -1)))
(define m2 '((1 2 3)
             (4 5 6)
             (7 8 9)))
(define m3 '((2 2 5)
             (6 6 10)
             (6 9 8)))
(define m4 '((15 18 21)
             (34 41 48)
             (-4 -5 -6)))
(check-expect (add m1 m2) m3)

; (scalar-vector-mult k v) -> list of number
; k: number
; v: list of number
; return the scalar multiplication kv
; no recursion: use map (and a lambda expression)
(define scalar-vector-mult
  (λ (k v)
    (map (λ (x) (* k x)) v)))

(check-expect (scalar-vector-mult 2 '(2 3 4)) '(4 6 8))

; (scalar-mult k m) -> list of list of number
; k: number
; m: list of list of number
; return the scalar multiplication km
; no recursion: use map (and a lambda expression)
(define scalar-mult 
  (λ (k m)
    (map (λ (x) (scalar-vector-mult k x)) m))) 
(define m5 '((2 0 4)
             (4 2 8)
             (-2 2 -2)))
(check-expect (scalar-mult 2 m1) m5)

; (transpose m) -> list of list of number
; m: list of list of number, non-empty
; return the transpose of matrix m
; a recursive version
(define transpose-rec 
  (λ (m)
    (if (eq? (cdr m) '())
        (map list (first m))
        (map append (map list (first m)) (transpose-rec (rest m))))))
;think, think, think!
;implement transpose non recursively!
;this one's tricky! 
(define transpose 
  (λ (m)
    (apply map append (map (λ (x) (map list x)) m))))
    
(define m1tr '((1 2 -1)
               (0 1 1)
               (2 4 -1)))
(check-expect (transpose-rec m1) m1tr)

; (mult m1 m2) -> list of list of number
; m1, m2: list of list of number
; return the matrix multiplication m1xm2
; no recursion: use maps, lambda expressions and the above
; transpose functions
(define mult 
  (λ (m1 m2)
    (map (λ (x) (map (λ (y) (dot-product x y)) (transpose m2))) m1)))

(check-expect (mult m1 m2) m4)
(test)