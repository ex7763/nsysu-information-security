# NSYSU-information-security
105 NSYSU information security final project  

# Sample
(load "./math/general.lisp")  
(load "./generate-prime/miller-rabin.lisp")  
(load "./generate-prime/generate-prime.lisp")  
(load "./RSA/RSA.lisp")  
(load "./aes/aes.lisp")  
(load "./digital-signature/digital-signature.lisp")  
(load "./check-friend/check-friend.lisp")  
(aes-generate-key)  
(rsa-get-key "myKey")  
*rsa-key\*  
(rsa-get-key "BobKey")  
*rsa-key\*  
(CBC-aes-encrypt-file "test_plaintext" #'padding-RKCS (aes-generate-key) *Ra\*)  
(CBC-aes-decrypt-file "test_plaintext.aes" #'de-padding-RKCS *aes-key\* *Ra\*)  
(cmp-file "test_plaintext")  
(cmp-file "test_plaintext.aes")  
(sig-generate-id "TEST")  
(sig-re-generate-id "TEST2" *aes-key\*)  
(sig-check-id)  
(cf-sig-friend "myfriend")  
(cf-sig-friend "Bobfriend")  
(cf-sig-check-same-friend "myfriend" "sig-myfriend" "sig-Bobfriend")  

# prime
(generate-prime (bits))  
(prime? (num))  

# RSA
## parameter
(defparameter *rsa-key\* 0)  
(defparameter *rsa-key-other\* 0)  
(defparameter *rsa-cyphertext\* 0)  
(defparameter *rsa-default-key-bits\* 2048)  
(defparameter *rsa-default-key-radix\* 10)  
## function
(rsa-generate-key (name bits &optional (e 17)))  
(rsa-save-key (key filename &optional (carry *rsa-default-key-radix\*)))  
(rsa-load-key (filename &optional (carry *rsa-default-key-radix\*)))  
(rsa-get-key (filename))  
(rsa-encrypt-unit (plaintext &optional (key *rsa-key\*)))  
(rsa-decrypt-unit (cyphertext &optional (key *rsa-key\*)))  

# digital-signature
## change key
(sig-generate-id (name &optional (key *rsa-key\*)))  
(sig-check-id)  
## function
(sig-encrypt-rsa-pss (msg &optional (key *rsa-key\*)))  
(sig-decrypt-rsa-pss (msg sig &optional (key *rsa-key\*)))  

# check-friend
## function
(cf-sig-friend (&optional (filename "myfriend")))  
(cf-sig-check-same-friend (myfriend sig-myfriend sig-otherfriend otherKey))  

# aes
## parameter
(defparameter *aes-key\* 0)  
(defparameter *aes-default-key-radix\* 16)  
## padding
#'padding-RKCS  
#'de-padding-RKCS  
## function
(aes-generate-key (&optional (bits 256)))  
(aes-encrypt (data key &optional (bits 256)))  
(aes-decrypt (data key &optional (bits 256)))  
(ECB-aes-encrypt-file (filename padding key))  
(ECB-aes-decrypt-file (filename padding key))  
(CBC-aes-encrypt-file (filename padding key IV))  
(CBC-aes-decrypt-file (filename padding key IV))  
(CTR-aes-encrypt-file (filename padding key IV))  
(CTR-aes-decrypt-file (filename padding key IV))  
(cmp-file (filename))  
