# NSYSU-information-security
105 NSYSU information security final project  

# prime
(generate-prime (bits))  
(prime? (num))  

# RSA
## function
(rsa-generate-key (name bits &optional (e 17)))  
(rsa-save-key (key filename &optional (carry *rsa-default-key-radix\*)))  
(rsa-load-key (filename &optional (carry *rsa-default-key-radix\*)))  
(rsa-get-key (filename))  
(rsa-encrypt-unit (plaintext &optional (key *rsa-key\*)))  
(rsa-decrypt-unit (cyphertext &optional (key *rsa-key\*)))  
## parameter
(defparameter *rsa-key\* 0)  
(defparameter *rsa-key-other\* 0)  
(defparameter *rsa-cyphertext\* 0)  
(defparameter *rsa-default-key-bits\* 2048)  
(defparameter *rsa-default-key-radix\* 10)  

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
## padding
padding-RKCS  
de-padding-RKCS  
## function
(aes-generate-key (&optional (bits 256)))  
(aes-encrypt (data key &optional (bits 256)))  
(aes-decrypt (data key &optional (bits 256)))  
(ECB-aes-encrypt-file (filename padding key))  
(ECB-aes-decrypt-file (filename padding key))  
(CBC-aes-encrypt-file (filename padding key IV))  
(CBC-aes-decrypt-file (filename padding key IV))  
(cmp-file (filename))  
