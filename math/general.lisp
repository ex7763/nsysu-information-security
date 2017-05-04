(defun square (n)
  (* n n))

(defun big-mod (b p m)
  (cond ((= p 0) 1)
        ((= p 1) (mod b m))
        ((= (mod p 2) 0)
         (mod (square (big-mod b (/ p 2) m)) m))
        (t
         (mod (* (mod b m) (big-mod b (- p 1) m)) m))))
