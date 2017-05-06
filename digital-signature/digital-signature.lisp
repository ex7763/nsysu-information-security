;;(load "../RSA/RSA.lisp")
;;(load "../math/general.lisp")
;; decrypt and encrypt change
(asdf:oos 'asdf:load-op 'ironclad) ;; used for sha256
(defmacro hash (msg)
  `(ironclad:digest-sequence :sha256 ,msg))

(defun sig-generate-id (name)
  (let ((ran (+ (random 10000000000000) 999999999999999)))
    (with-open-file (str "SIG_CHECK_FILE" :direction :output
                         :if-exists :supersede)
      ;; name random_number encrypt-random_number public_key n
      (format str "~A~%~A~%~A~%~A~%~A~%~%" name ran (rsa-decrypt-unit ran) (rsa-key-public-key *rsa-key*) (rsa-key-n *rsa-key*))
      (format str ";;name random_number encrypt-random_number public_key n"))))

(defun sig-check-id ()
  (with-open-file (str "SIG_CHECK_FILE")
    (let ((name (read str))
          (ran (read str))
          (en-ran (read str))
          (key (list (read str) (read str))))
      (if (= ran (rsa-encrypt-unit en-ran key))
          t
          nil))))

(defconstant +padding1+
  (make-array 8
              :element-type 'padding1
              :initial-contents '(0 0 0 0 0 0 0 0)))

;; s = m^d mod n
;; p.430
;; doing
(defun sig-encrypt-rsa-pss (msg &optional (key *rsa-key*))
  (let* ((salt (random 256))
         (m (concatenate '(simple-array (unsigned-byte 8) (*))
                         +padding1+
                         (hash (string-to-octets msg))
                         (list salt)))
         (db) 
         (H (hash m)))
    (format t "~A" H)))