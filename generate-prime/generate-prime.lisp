;;(load "../math/general.lisp")
;;(load "./miller-rabin.lisp")

;; the bits should mod 4 = 0
(defun generate-prime (bits)
  (let ((*print-base* 16)
        (digits (/ bits 4))
        (str (make-array 0
                         :element-type 'base-char
                         :fill-pointer 0
                         :adjustable t)))
    (with-output-to-string (string str)
      (let ((head-digit (random 16)))
        (setf head-digit (logior head-digit #b01100))
        (format str "~A" head-digit))
      (dotimes (i (- digits 1))
        (format str "~A" (logior (random 16) #b00001)))
      (let ((tmp (parse-integer str :radix 16)))
;; make test prime faster (maybe)
        (declare (integer tmp))
        (do ((i tmp (+ i 2)))
            ((prime? i) (return-from generate-prime  i)))))))
