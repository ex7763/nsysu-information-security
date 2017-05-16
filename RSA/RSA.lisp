;;(load "../math/general.lisp")
;; (n,e) is public key
;; (n,d) is private key
;; e = 3,17
;;(setf *read-base* 10)
;;(setf *print-base* 2)

(defparameter *rsa-key* 0)
(defparameter *rsa-key-other* 0)
(defparameter *rsa-cyphertext* 0)
(defparameter *rsa-default-key-bits* 2048)
(defparameter *rsa-default-key-radix* 10)

(defstruct rsa-key
  name
  n
  private-key ;;d
  public-key  ;;e
  comments
  )

(defun rsa-generate-key (name bits &optional (e 17))
  (let* (
         ;;(*print-base* 16)
         (len (/ bits 2))
         (p (generate-prime len))
         (q (generate-prime len))
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

(defun rsa-save-key (key filename &optional (carry *rsa-default-key-radix*))
  (let ((*print-base* carry))
    (with-open-file (str filename :direction :output
                       :if-exists :supersede)
      (format str "~S" key))))

(defun rsa-load-key (filename &optional (carry *rsa-default-key-radix*))
  (let ((*read-base* carry)
        (*print-base* carry))
    (with-open-file (str filename)
      (let ((key (read str)))
        (setf *rsa-key* key)))))

;;2048bits e=17
(defun rsa-get-key (filename)
  (rsa-save-key (rsa-generate-key 'default *rsa-default-key-bits*) filename))

(defun rsa-encrypt-unit (plaintext &optional (key *rsa-key*))
  (if (rsa-key-p key)
      (big-mod plaintext (rsa-key-public-key key) (rsa-key-n key))
      (big-mod plaintext (car key) (cadr key))))

(defun rsa-decrypt-unit (cyphertext &optional (key *rsa-key*))
  (if (rsa-key-p key)
      (big-mod cyphertext (rsa-key-private-key key) (rsa-key-n key))
      (big-mod cyphertext (car key) (cadr key))))


;;TODO OAEP
(defun rsa-encrypt-string (string)
  (let* ((IV (random 128))
         (cyphertext (list IV))
         (count 0)
         (len (length string))
         (tmp 0))
    (loop
       (when (= count len) (return))
       (setf tmp (rsa-encrypt-unit (+ IV count)))
       (setf cyphertext (append cyphertext (list (rsa-encrypt-unit (char-code (char string count))))))
       (incf count))
    (return-from rsa-encrypt-string cyphertext)))
