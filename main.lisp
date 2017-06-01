(ql:quickload "ltk")
(load "./math/general.lisp")
(load "./generate-prime/miller-rabin.lisp")
(load "./generate-prime/generate-prime.lisp")
(load "./RSA/RSA.lisp")
(load "./digital-signature/digital-signature.lisp")
(load "./check-friend/check-friend.lisp")
(load "./aes/aes.lisp")
(load "./gui.lisp")

;;(sig-generate-id "eddie")
;;(format t "~%~%TEST ~A~%~%" (sig-check-id))
;;(setf sig-test (sig-encrypt-rsa-pss "Andy"))
;;(format t "sigtest ~A~%"(sig-decrypt-rsa-pss "Anidy" sig-test))

;;(rsa-get-key "MyKey")
;;(cf-sig-friend)
;;(rsa-get-key "BobKey")
;;(cf-sig-friend "Bobfriend")

;;(format t "sig-check ~A" (cf-sig-check-same-friend "myfriend" "sig-myfriend" "sig-Bobfriend" "BobKey"))

(setf *Ra* 10000)

;; aes
;(time (ECB-aes-encrypt-file "test_plaintext" #'padding-RKCS (aes-generate-key)))
;(time (ECB-aes-decrypt-file "test_plaintext.aes" #'de-padding-RKCS *aes-key*))
(time (CBC-aes-encrypt-file "test_plaintext" #'padding-RKCS (aes-generate-key) *Ra*))
(time (CBC-aes-decrypt-file "test_plaintext.aes" #'de-padding-RKCS *aes-key* *Ra*))
;(cmp-file "test_plaintext")


(gui)
