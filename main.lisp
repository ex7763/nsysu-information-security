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

;; aes
(setf testct (aes-encrypt #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) (aes-generate-key)))
(aes-decrypt testct *aes-key*)

(setf testc (aes-encrypt #(1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) *aes-key*))
(aes-decrypt testct *aes-key*)

(gui)
