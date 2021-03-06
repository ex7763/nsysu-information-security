(setf *random-state* (make-random-state t))

(defun square (n)
  (* n n))

(defun big-mod (b p m)
  (cond ((= p 0) 1)
        ((= p 1) (mod b m))
        ((= (mod p 2) 0)
         (mod (square (big-mod b (/ p 2) m)) m))
        (t
         (mod (* (mod b m) (big-mod b (- p 1) m)) m))))

;;擴展式歐幾里得演算法（Extended Euclidean Algorithm）
;;求模反元素
(defun modular-inverse (a n)
  (let ((x 0) (r n)
        (newx 1) (newr a)
        (quotient 0)
        (tmp 0))
    (loop
       (when (= newr 0) (return))
       (setf quotient (truncate (/ r newr)))
       (setf tmp newx)
       (setf newx (- x (* quotient newx)))
       (setf x tmp)
       (setf tmp newr)
       (setf newr (- r (* quotient newr)))
       (setf r tmp))
    (when (/= r 1)
      (return-from modular-inverse 0))
    (if (< x 0)
        (return-from modular-inverse (+ x n))
        (return-from modular-inverse x))))

(defun octets-to-integer (octets)
  (declare (type (simple-array (unsigned-byte 8) (*)) octets))
  (let ((end (length octets)))
    (do ((index 0 (+ index 1))
         (sum 0))
        ((>= index end) sum)
      ;; ash = arithmetic shift
      (setf sum (+ (aref octets index) (ash sum 8))))))

(defun integer-to-octets (num)
  ;; integer-length =  bits of number
  (let* ((bytes-len (ceiling (integer-length num) 8))
         (octets (make-array bytes-len :element-type '(unsigned-byte 8))))
    (do ((count (- bytes-len 1) (- count 1))
         (index 0 (+ index 1)))
        ((< count 0) (return-from integer-to-octets octets))
      (setf (aref octets index) (ldb (byte 8 (* count 8)) num)))))
