;;(load "../RSA/RSA.lisp")
;; decrypt and encrypt change
(defun sig-generate-id (name)
  (let ((ran (+ (random 10000000000000) 999999999999999)))
    (with-open-file (str "SIG_CHECK_FILE" :direction :output
                         :if-exists :supersede)
      ;; name random_number encrypt-random_number public_key n
      (format str "~A~%~A~%~A~%~A~%~A" name ran (rsa-decrypt-unit *rsa-key* ran) (rsa-key-public-key *rsa-key*) (rsa-key-n *rsa-key*)))))

(defun sig-check-id ()
  (with-open-file (str "SIG_CHECK_FILE")
    (let ((name (read str))
          (ran (read str))
          (en-ran (read str))
          (key (list (read str) (read str))))
      (if (= ran (rsa-encrypt-unit key en-ran))
          t
          nil))))
