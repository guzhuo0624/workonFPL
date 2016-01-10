(module lab4 scheme

(define map1
  (λ (f lst)
      (if (empty? lst)
          empty
          (cons (f (first lst)) (map1 f (rest lst))))))
  
(define map1-tail
  (λ (f lst)
    (letrec ([maptail
              (λ (f lst r)
                (if (empty? lst)
                    r
                    (maptail f (rest lst) (append r (list (f (first lst)))))))])
      (maptail f lst '()))))

(define (ispair? function list)
    (and (pair? list)
         (or (function (car list))
             (ispair? function (cdr list)))))

(define mmap
  (λ (fst . lists)
    (if (ispair? null? lists)
        '()
        (cons (apply fst (map1 car lists))
              (apply mmap fst (map1 cdr lists))))))

(define deep-map 
  (λ (f l)
    (letrec ([deep 
              (λ (x)
                (if (null? x) 
                    x
                    (if (pair? x) 
                        (map1 deep x)
                        (f x))))])
  (map1 deep l))))

(provide map1 map1-tail mmap deep-map)


)