;;(load "../RSA/RSA.lisp")
;;(load "../math/general.lisp")
;; decrypt and encrypt change
(asdf:oos 'asdf:load-op 'ironclad) ;; used for sha256
(defmacro hash (msg)
  `(ironclad:digest-sequence :sha256 ,msg))

(defun sig-generate-id (name &optional (key *rsa-key*))
  (let ((ran (+ (random 10000000000000) 999999999999999)))
    (with-open-file (str "SIG_CHECK_FILE" :direction :output
                         :if-exists :supersede)
      ;; name random_number encrypt-random_number public_key n
      (format str "~A~%~A~%~A~%~A~%~A~%~%" name
              ran
              (rsa-decrypt-unit ran)
              (rsa-key-public-key key)
              (rsa-key-n key))
      (format str ";;name random_number encrypt-random_number public_key n"))))

(defun sig-check-id ()
  (with-open-file (str "SIG_CHECK_FILE")
  ;;name
    (read str)
    (let ((ran (read str))
          (en-ran (read str))
          (key (list (read str) (read str))))
      (if (= ran (rsa-encrypt-unit en-ran key))
          t
          nil))))

(defparameter *emLen* 1024)
(defparameter *hLen* 256)
(defparameter *sLen* 8)
(defparameter *padding2Len* (ceiling (/ (- *emLen* *hLen* *sLen* 2) 8)))

(defconstant +padding1+
  (make-array 8
              :initial-contents '(0 0 0 0 0 0 0 0)))

(defconstant +padding2+
  (make-array *padding2Len*
              :initial-element 1))

(defun rsa-pss-mgf1 (hlen masklen string)
  (let ((mask nil)
        (k (ceiling (/ masklen hlen))))
    (dotimes (count k mask)
        (setf mask (concatenate '(simple-array (unsigned-byte 8) (*))
                                mask
                                (hash (concatenate '(simple-array (unsigned-byte 8) (*))
                                                   string
                                                   (integer-to-octets count))))))
    (return-from rsa-pss-mgf1 (subseq mask 0 (ceiling (/ masklen 8))))))

;; s = m^d mod n
;; p.429 ~ p.431
(defun sig-encrypt-rsa-pss (msg &optional (key *rsa-key*))
  (let* ((salt (integer-to-octets (random 256)))
         (m (concatenate '(simple-array (unsigned-byte 8) (*))
                         +padding1+
                         (hash (string-to-octets msg))
                         salt))
         (DB (concatenate '(simple-array (unsigned-byte 8) (*))
                          +padding2+
                          salt))
         (H (hash m))
         (maskedDB (map '(simple-array (unsigned-byte 8) (*))
                        #'logxor
                        DB (rsa-pss-mgf1 *hlen* (- *emLen* *hlen* 1) H)))
         (EM (concatenate '(simple-array (unsigned-byte 8) (*))
                          maskedDB H))
         (sig (big-mod (octets-to-integer EM)
                       (rsa-key-private-key key)
                       (rsa-key-n key))))
    (return-from sig-encrypt-rsa-pss sig)))

(defun sig-decrypt-rsa-pss (msg sig &optional (key *rsa-key*))
  (let* ((EM (integer-to-octets
              (big-mod sig
                       (rsa-key-public-key key)
                       (rsa-key-n key))))
         (mHash (hash (string-to-octets msg)))
         (maskeLen (ceiling (/ (- *emLen* *hlen* 1) 8)))
         (maskedDB (subseq EM 0 maskeLen))
         (H (subseq EM maskeLen (length EM)))
         (DB (map '(simple-array (unsigned-byte 8) (*))
                  #'logxor
                  (rsa-pss-mgf1 *hlen* (- *emLen* *hlen* 1) H)
                  maskedDB))
         ;;(pad2 (subseq DB 0 *padding2Len*))
         (salt (integer-to-octets (aref DB *padding2Len*)))
         (m (concatenate '(simple-array (unsigned-byte 8) (*))
                         +padding1+
                         mHash
                         salt))
         (H_check (octets-to-integer (hash m))))
    (if (= (octets-to-integer H) H_check)
        t
        nil)))
