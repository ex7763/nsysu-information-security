(defun square (n)
  (* n n))

(defun big-mod (b p m)
  (cond ((= p 0) 1)
        ((= p 1) (mod b m))
        ((= (mod p 2) 0)
         (mod (square (big-mod b (/ p 2) m)) m))
        (t
         (mod (* (mod b m) (big-mod b (- p 1) m)) m))))
         
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
