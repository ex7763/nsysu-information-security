(setf *random-state* (make-random-state t))

(defun rewrite-num (num r)
  (if (= (mod num 2) 0)
      (rewrite-num (/ num 2) (+ r 1))
      (list r num)))
      
(defun my-random (num)
  (+ (random (- num 3)) 2))
  
(defun miller-rabin (num repeat)
  (if(<= num 3)
     (cond ((= num 3) 1)
            ((= num 2) 1)
            ((= num 1) 0)
            ((<= num 0) 0))
           (if (and (> num 3) (= (mod num 2) 0))
               0
               (let* ((a (+ (random (- num 3)) 2))
                      (tmp (rewrite-num num 0))
                      (r (car tmp))
                      (d (cdr tmp))
                      (x (mod (expt a d) num)))
                 (dotime (count repeat 1)
                         (if (or (= x 1) (= x (- num 1)))
                             (dotime (count2 (- r 1) 1)
                                     (setf x (mod (expt x 2) n))
                                     (if (= x 1)
                                         0
                                         
                 
                 ))))

(miller-rabin 3 2)
