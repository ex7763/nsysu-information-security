(ql:quickload "ltk")
(load "./math/general.lisp")
(load "./generate-prime/miller-rabin.lisp")
(load "./generate-prime/generate-prime.lisp")
(load "./RSA/RSA.lisp")
(load "./digital-signature/digital-signature.lisp")
(load "./check-friend/check-friend.lisp")
(load "./xts-aes/xts-aes.lisp")
(load "./gui.lisp")

;;(sig-generate-id "eddie")
;;(format t "~%~%TEST ~A~%~%" (sig-check-id))
;;(setf sig-test (sig-encrypt-rsa-pss "Andy"))
;;(format t "sigtest ~A~%"(sig-decrypt-rsa-pss "Anidy" sig-test))

(rsa-get-key "MyKey")
(cf-sig-friend)
(rsa-get-key "BobKey")
(cf-sig-friend "Bobfriend")

;;(format t "sig-check ~A" (cf-sig-check-same-friend "myfriend" "sig-myfriend" "sig-Bobfriend" "BobKey"))

;; aes
(setf testct (aes-encrypt #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) (aes-generate-key)))
(aes-decrypt testct *aes-key*)

(setf testc (aes-encrypt #(1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) *aes-key*))
(aes-decrypt testct *aes-key*)


;; textbook p.171
;; plaintext #(1 35 69 103 137 171 205 239 254 220 186 152 118 84 50 16)
;; #x0123456789abcdeffedcba9876543210
;; key #(15 21 113 201 71 217 232 89 12 183 29 214 175 127 103 152)
;; #x0f1571c947d9e8590cb71dd6af7f6798
;; ciphertext #(255 11 132 74 8 83 191 124 105 52 171 67 100 20 143 185)
;; #xff0b844a0853bf7c6934ab4364148fb9
;; (setf testpt #(1 35 69 103 137 171 205 239 254 220 186 152 118 84 50 16))
;; (aes-encrypt #(1 35 69 103 137 171 205 239 254 220 186 152 118 84 50 16)
;; #(15 21 113 201 71 217 232 89 12 183 29 214 175 127 103 152) 128)
;; (aes-encrypt #(1 35 69 103 137 171 205 239 254 220 186 152 118 84 50 16) *aes-key* 128)


(gui)
