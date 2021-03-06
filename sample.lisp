(load "./math/general.lisp")
(load "./generate-prime/miller-rabin.lisp")
(load "./generate-prime/generate-prime.lisp")
(load "./RSA/RSA.lisp")
(load "./aes/aes.lisp")
(load "./digital-signature/digital-signature.lisp")
(load "./check-friend/check-friend.lisp")

(aes-generate-key)
(rsa-get-key "myKey")
*rsa-key*
(rsa-get-key "BobKey")
*rsa-key*
(CBC-aes-encrypt-file "test_plaintext" #'padding-RKCS (aes-generate-key) *Ra*)
(CBC-aes-decrypt-file "test_plaintext.aes" #'de-padding-RKCS *aes-key* *Ra*)
(cmp-file "test_plaintext")
(cmp-file "test_plaintext.aes")
(sig-generate-id "TEST")  
(sig-re-generate-id "TEST2" *aes-key*)  
(sig-check-id)
(cf-sig-friend "myfriend")
(cf-sig-friend "Bobfriend")
(cf-sig-check-same-friend "myfriend" "sig-myfriend" "sig-Bobfriend")
