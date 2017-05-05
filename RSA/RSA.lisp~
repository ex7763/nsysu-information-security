;;(load "../math/general.lisp")
;; (n,e) is public key
;; (n,d) is private key
;; e = 3,17
;;(setf *read-base* 10)
;;(setf *print-base* 2)

(defparameter *rsa-key* 0)
(defparameter *rsa-cyphertext* 0)

(defstruct rsa-key
  name
  n
  private-key ;;d
  public-key  ;;e
  comments
  )

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

(defun rsa-generate-key (name bits &optional (e 17))
  (let* (
         ;;(*print-base* 16)
         (length (/ bits 2))
         (p (generate-prime length))
         (q (generate-prime length))
         (n (* p q))
         (r (* (- p 1) (- q 1)))
         (d (modular-inverse e r)))
    (if (= d 0)
        (rsa-generate-key name bits e) 
        (setf *rsa-key*
              (make-rsa-key :name name
                      :n n
                      :private-key d
                      :public-key e)))))

(defun rsa-save-key (key filename &optional (carry 16))
  (let ((*print-base* carry))
    (with-open-file (str filename :direction :output
                       :if-exists :supersede)
      (format str "~S" key))))

(defun rsa-load-key (filename &optional (carry 16))
  (let ((*read-base* carry)
        (*print-base* carry))
    (with-open-file (str filename)
      (let ((key (read str)))
        (setf *rsa-key* key)))))

;;1024bits e=17
(defun rsa-get-key (filename)
  (rsa-save-key (rsa-generate-key 'default 1024) filename))

(defun rsa-encrypt-unit (plaintext)
        (big-mod plaintext (rsa-key-public-key *rsa-key*)
           (rsa-key-n *rsa-key*)))

(defun rsa-decrypt-unit (cyphertext)
  (big-mod cyphertext (rsa-key-private-key *rsa-key*)
           (rsa-key-n *rsa-key*)))
