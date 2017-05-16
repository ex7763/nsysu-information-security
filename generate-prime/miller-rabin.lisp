;;(load "../math/general.lisp")

(defun my-random (num)
  (+ (random (- num 3)) 2))

(defun non-square-root? (num m)
  (and (not (= num 1))
       (not (= num (- m 1)))
       (= 1 (mod (square num) m))))

(defun expmod (base exp m)
  (cond ((= exp 0) 1)
        ((non-square-root? base m) 0)
        ((= (mod exp 2) 0)
         (mod (square (expmod base (/ exp 2) m)) m))
         (t
          (mod (* base (expmod base (- exp 1) m)) m))))

(defun miller-rabin (num repeat)
  (cond ((= repeat 0) t)
        ((= (expmod (my-random num) (- num 1) num) 1)
         (miller-rabin num (- repeat 1)))
        (t
         nil)))

;;make prime? faster
;;1024bits <1.00 seconds
(defun prime-table-check (num)
  (with-open-file (str "./math/prime-table" :direction :input)
    (do ((prime (read str nil 'eof)
                (read str nil 'eof)))
        ((eql prime 'eof))
      (if (= (mod num prime) 0)
          (return-from prime-table-check t)))))

(defun prime? (num)
  (if (prime-table-check num)
      nil
      (miller-rabin num 10)))
