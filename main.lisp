(load "./math/general.lisp")
(load "./generate-prime/miller-rabin.lisp")
(load "./generate-prime/generate-prime.lisp")
(load "./RSA/RSA.lisp")
(load "./digital-signature/digital-signature.lisp")
(load "./check-friend/check-friend.lisp")


(rsa-get-key "key")
(sig-generate-id "eddie")
(format t "~%~%TEST ~A~%~%" (sig-check-id))
;;(sig-encrypt-rsa-pss "test")
(cf-sig-myfriend)
