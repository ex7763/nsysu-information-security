(defparameter *aes-key* 0)

(defconstant +rcon+
  (make-array 256
              :initial-contents '(141 1 2 4 8 16 32 64 128 27 54 108 216 171 77 154 47 94 188 99 198 151 53 106 212 179 125 250 239 197 145 57 114 228 211 189 97 194 159 37 74 148 51 102 204 131 29 58 116 232 203 141 1 2 4 8 16 32 64 128 27 54 108 216 171 77 154 47 94 188 99 198 151 53 106 212 179 125 250 239 197 145 57 114 228 211 189 97 194 159 37 74 148 51 102 204 131 29 58 116 232 203 141 1 2 4 8 16 32 64 128 27 54 108 216 171 77 154 47 94 188 99 198 151 53 106 212 179 125 250 239 197 145 57 114 228 211 189 97 194 159 37 74 148 51 102 204 131 29 58 116 232 203 141 1 2 4 8 16 32 64 128 27 54 108 216 171 77 154 47 94 188 99 198 151 53 106 212 179 125 250 239 197 145 57 114 228 211 189 97 194 159 37 74 148 51 102 204 131 29 58 116 232 203 141 1 2 4 8 16 32 64 128 27 54 108 216 171 77 154 47 94 188 99 198 151 53 106 212 179 125 250 239 197 145 57 114 228 211 189 97 194 159 37 74 148 51 102 204 131 29 58 116 232 203 141)))

(defconstant +sbox+
  (make-array 256
              :initial-contents '(99 124 119 123 242 107 111 197 48 1 103 43 254 215 171 118 202 130 201 125 250 89 71 240 173 212 162 175 156 164 114 192 183 253 147 38 54 63 247 204 52 165 229 241 113 216 49 21 4 199 35 195 24 150 5 154 7 18 128 226 235 39 178 117 9 131 44 26 27 110 90 160 82 59 214 179 41 227 47 132 83 209 0 237 32 252 177 91 106 203 190 57 74 76 88 207 208 239 170 251 67 77 51 133 69 249 2 127 80 60 159 168 81 163 64 143 146 157 56 245  188 182 218 33 16 255 243 210 205 12 19 236 95 151 68 23 196 167 126 61 100 93 25 115 96 129 79 220 34 42 144 136 70 238 184 20 222 94 11 219 224 50 58 10 73 6 36 92 194 211 172 98 145 149 228 121 231 200 55 109 141 213 78 169 108 86 244 234 101 122 174 8 186 120 37 46 28 166 180 198 232 221 116 31 75 189 139 138 112 62 181 102 72 3 246 14 97 53 87 185 134 193 29 158 225 248 152 17 105 217 142 148 155 30 135 233 206 85 40 223 140 161 137 13 191 230 66 104 65 153 45 15 176 84 187 22)))

(defconstant +sbox_inv+
  (make-array 256
              :initial-contents '(82 9 106 213 48 54 165 56 191 64 163 158 129 243 215 251 124 227 57 130 155 47 255 135 52 142 67 68 196 222 233 203 84 123 148 50 166 194 35 61 238 76 149 11 66 250 195 78 8 46 161 102 40 217 36 178 118 91 162 73 109 139 209 37 114 248 246 100 134 104 152 22 212 164 92 204 93 101 182 146 108 112 72 80 253 237 185 218 94 21 70 87 167 141 157 132 144 216 171 0 140 188 211 10 247 228 88 5 184 179 69 6 208 44 30 143 202 63 15 2 193 175 189 3 1 19 138 107 58 145 17 65 79 103 220 234 151 242 207 206 240 180 230 115 150 172 116 34 231 173 53 133 226 249 55 232 28 117 223 110 71 241 26 113 29 41 197 137 111 183 98 14 170 24 190 27 252 86 62 75 198 210 121 32 154 219 192 254 120 205 90 244 31 221 168 51 136 7 199 49 177 18 16 89 39 128 236 95 96 81 127 169 25 181 74 13 45 229 122 159 147 201 156 239 160 224 59 77 174 42 245 176 200 235 187 60 131 83 153 97 23 43 4 126 186 119 214 38 225 105 20 99 85 33 12 125)))

(defconstant +shift+
  (make-array 16
              :initial-contents '(0 5 10 15 4 9 14 3 8 13 2 7 12 1 6 11)))

(defconstant +shift_inv+
  (make-array 16
              :initial-contents '(0 13 10 7 4 1 14 11 8 5 2 15 12 9 6 3)))

(defconstant +galois_9+
  (make-array 256
              :initial-contents '(0 9 18 27 36 45 54 63 72 65 90 83 108 101 126 119 144 153 130 139 180 189 166 175 216 209 202 195 252 245 238 231 59 50 41 32 31 22 13 4 115 122 97 104 87 94 69 76 171 162 185 176 143 134 157 148 227 234 241 248 199 206 213 220 118 127 100 109 82 91 64 73 62 55 44 37 26 19 8 1 230 239 244 253 194 203 208 217 174 167 188 181 138 131 152 145 77 68 95 86 105 96 123 114 5 12 23 30 33 40 51 58 221 212 207 198 249 240 235 226 149 156 135 142 177 184 163 170 236 229 254 247 200 193 218 211 164 173 182 191 128 137 146 155 124 117 110 103 88 81 74 67 52 61 38 47 16 25 2 11 215 222 197 204 243 250 225 232 159 150 141 132 187 178 169 160 71 78 85 92 99 106 113 120 15 6 29 20 43 34 57 48 154 147 136 129 190 183 172 165 210 219 192 201 246 255 228 237 10 3 24 17 46 39 60 53 66 75 80 89 102 111 116 125 161 168 179 186 133 140 151 158 233 224 251 242 205 196 223 214 49 56 35 42 21 28 7 14 121 112 107 98 93 84 79 70)))

(defconstant +galois_11+
  (make-array 256
              :initial-contents '(0 11 22 29 44 39 58 49 88 83 78 69 116 127 98 105 176 187 166 173 156 151 138 129 232 227 254 245 196 207 210 217 123 112 109 102 87 92 65 74 35 40 53 62 15 4 25 18 203 192 221 214 231 236 241 250 147 152 133 142 191 180 169 162 246 253 224 235 218 209 204 199 174 165 184 179 130 137 148 159 70 77 80 91 106 97 124 119 30 21 8 3 50 57 36 47 141 134 155 144 161 170 183 188 213 222 195 200 249 242 239 228 61 54 43 32 17 26 7 12 101 110 115 120 73 66 95 84 247 252 225 234 219 208 205 198 175 164 185 178 131 136 149 158 71 76 81 90 107 96 125 118 31 20 9 2 51 56 37 46 140 135 154 145 160 171 182 189 212 223 194 201 248 243 238 229 60 55 42 33 16 27 6 13 100 111 114 121 72 67 94 85 1 10 23 28 45 38 59 48 89 82 79 68 117 126 99 104 177 186 167 172 157 150 139 128 233 226 255 244 197 206 211 216 122 113 108 103 86 93 64 75 34 41 52 63 14 5 24 19 202 193 220 215 230 237 240 251 146 153 132 143 190 181 168 163)))

(defconstant +galois_13+
  (make-array 256
              :initial-contents '(0 13 26 23 52 57 46 35 104 101 114 127 92 81 70 75 208 221 202 199 228 233 254 243 184 181 162 175 140 129 150 155 187 182 161 172 143 130 149 152 211 222 201 196 231 234 253 240 107 102 113 124 95 82 69 72 3 14 25 20 55 58 45 32 109 96 119 122 89 84 67 78 5 8 31 18 49 60 43 38 189 176 167 170 137 132 147 158 213 216 207 194 225 236 251 246 214 219 204 193 226 239 248 245 190 179 164 169 138 135 144 157 6 11 28 17 50 63 40 37 110 99 116 121 90 87 64 77 218 215 192 205 238 227 244 249 178 191 168 165 134 139 156 145 10 7 16 29 62 51 36 41 98 111 120 117 86 91 76 65 97 108 123 118 85 88 79 66 9 4 19 30 61 48 39 42 177 188 171 166 133 136 159 146 217 212 195 206 237 224 247 250 183 186 173 160 131 142 153 148 223 210 197 200 235 230 241 252 103 106 125 112 83 94 73 68 15 2 21 24 59 54 33 44 12 1 22 27 56 53 34 47 100 105 126 115 80 93 74 71 220 209 198 203 232 229 242 255 180 185 174 163 128 141 154 151)))

(defconstant +galois_14+
  (make-array 256
              :initial-contents '(0 14 28 18 56 54 36 42 112 126 108 98 72 70 84 90 224 238 252 242 216 214 196 202 144 158 140 130 168 166 180 186 219 213 199 201 227 237 255 241 171 165 183 185 147 157 143 129 59 53 39 41 3 13 31 17 75 69 87 89 115 125 111 97 173 163 177 191 149 155 137 135 221 211 193 207 229 235 249 247 77 67 81 95 117 123 105 103 61 51 33 47 5 11 25 23 118 120 106 100 78 64 82 92 6 8 26 20 62 48 34 44 150 152 138 132 174 160 178 188 230 232 250 244 222 208 194 204 65 79 93 83 121 119 101 107 49 63 45 35 9 7 21 27 161 175 189 179 153 151 133 139 209 223 205 195 233 231 245 251 154 148 134 136 162 172 190 176 234 228 246 248 210 220 206 192 122 116 102 104 66 76 94 80 10 4 22 24 50 60 46 32 236 226 240 254 212 218 200 198 156 146 128 142 164 170 184 182 12 2 16 30 52 58 40 38 124 114 96 110 68 74 88 86 55 57 43 37 15 1 19 29 71 73 91 85 127 113 99 109 215 217 203 197 239 225 243 253 167 169 187 181 159 145 131 141)))

;;; key expand
;;; default 256 bit
;;; other 128 192 256
(defun aes-generate-key (&optional (bits 256))
  (cond ((= bits 256))
        ((= bits 192))
        ((= bits 128))
        (t 
         (progn
           (format t "wrong bits size~%")
           (return-from aes-generate-key nil))))
  (let* ((bytes (/ bits 8))
        (key (make-array bytes :element-type '(unsigned-byte 8))))
    (dotimes (i bytes key)
      (setf (aref key i) (random 256)))
    (setf *aes-key* key)))

(defun aes-rot-word (word)
  (let ((tmp (make-array 4 :element-type '(unsigned-byte 8))))
    (setf (aref tmp 0) (aref word 1))
    (setf (aref tmp 1) (aref word 2))
    (setf (aref tmp 2) (aref word 3))
    (setf (aref tmp 3) (aref word 0))
    (return-from aes-rot-word tmp)))

(defun aes-sub-word (word)
  (declare (type (simple-array (unsigned-byte 8) (*)) word))
  (dotimes (i 4 word)
    (setf (aref word i) (aref +sbox+ (aref word i)))))

(defun aes-expandkey (key &optional (bits 256))
  (let* ((repeat 0)
        (key-len (/ bits 8))
        (tmp (make-array 240 :element-type '(unsigned-byte 8))))
    (cond ((= bits 256) (setf repeat 14))
          ((= bits 192) (setf repeat 12))
          ((= bits 128) (setf repeat 10))
          (t 
           (progn
             (format t "wrong bits size~%")
             (return-from aes-expandkey nil))))
    (let* ((tmp1 (make-array 4 :element-type '(unsigned-byte 8)))
           (tmp2 (make-array 4 :element-type '(unsigned-byte 8)))
           (tmp3 (make-array 4 :element-type '(unsigned-byte 8))))
      (setf (subseq tmp 0 key-len) (subseq key 0 key-len))
      (dotimes (i (- repeat 1) tmp)
        (setf tmp1 (aes-rot-word (subseq tmp (- key-len 4) key-len))) 
        ;;(format t "~A" tmp1)
        (setf tmp2 (aes-sub-word tmp1))
        (setf tmp3 tmp2)
        (setf (aref tmp3 0) (logxor (aref tmp3 0)
                                    (aref +rcon+ (+ i 1))))
        (setf (subseq tmp key-len (+ key-len 4))
              (map '(simple-array (unsigned-byte 8) (*))
                   #'logxor
                   (subseq tmp (- key-len 16) (- key-len 12))
                   tmp3))
        (dotimes (j 3)
          (let ((shift (* (+ j 1) 4)))
            (setf (subseq tmp (+ key-len shift) (+ key-len (+ 4 shift)))
                  (map '(simple-array (unsigned-byte 8) (*))
                       #'logxor
                       (subseq tmp (+ key-len (- shift 4)) (+ key-len shift))
                       (subseq tmp (- (+ key-len shift) 16) (- (+ key-len shift) 12))
                       ))))
        (setf key-len (+ key-len 16))))))
                                             


;;;encrypt, decrypt function
;;; table inverse or not
;;; +sbox+        +sbox_inv+
;;; +shift+       +shift_inv+
(defun aes-add-round-key (data key)
  (dotimes (i 16 data)
    (setf (aref data i) (logxor (aref data i)
                                 (aref key i)))))

(defun aes-sub-bytes (data table)
  (dotimes (i 16 data)
    (setf (aref data i) (aref table (aref data i)))))

(defun aes-shift-rows (data table)
  (let ((tmp (make-array 16)))
    (dotimes (i 16 tmp)
      (setf (aref tmp (aref table i)) (aref data i)))))

(defun xtime (m)
  ;;(declare (type (unsigned-byte 8) m))
  (setf m (ash m 1))
  (if (>= m 256)
      (logxor (- m 256) #b00011011)
      m))

(defun aes-mix-columns-word (word)
  (let ((tmp (make-array 4 :element-type '(unsigned-byte 8))))
    (setf (aref tmp 0) (logxor (xtime (aref word 0))
                               (logxor (aref word 1)
                                       (xtime (aref word 1)))
                               (aref word 2)
                               (aref word 3)))
    (setf (aref tmp 1) (logxor (aref word 0)
                               (xtime (aref word 1))
                               (logxor (aref word 2)
                                       (xtime (aref word 2)))
                               (aref word 3)))
    (setf (aref tmp 2) (logxor (aref word 0)
                               (aref word 1)
                               (xtime (aref word 2))
                               (logxor (aref word 3)
                                       (xtime (aref word 3)))))
    (setf (aref tmp 3) (logxor (logxor (aref word 0)
                                       (xtime (aref word 0)))
                               (aref word 1)
                               (aref word 2)
                               (xtime (aref word 3))))
    (return-from aes-mix-columns-word tmp)))

(defun aes-mix-columns-word-inv (word)
  (let ((tmp (make-array 4 :element-type '(unsigned-byte 8))))
    (setf (aref tmp 0) (logxor (aref +galois_14+ (aref word 0))
                               (aref +galois_11+ (aref word 1))
                               (aref +galois_13+ (aref word 2))
                               (aref +galois_9+ (aref word 3))))
    (setf (aref tmp 1) (logxor (aref +galois_9+ (aref word 0))
                               (aref +galois_14+ (aref word 1))
                               (aref +galois_11+ (aref word 2))
                               (aref +galois_13+ (aref word 3))))
    (setf (aref tmp 2) (logxor (aref +galois_13+ (aref word 0))
                               (aref +galois_9+ (aref word 1))
                               (aref +galois_14+ (aref word 2))
                               (aref +galois_11+ (aref word 3))))
    (setf (aref tmp 3) (logxor (aref +galois_11+ (aref word 0))
                               (aref +galois_13+ (aref word 1))
                               (aref +galois_9+ (aref word 2))
                               (aref +galois_14+ (aref word 3))))
    (return-from aes-mix-columns-word-inv tmp)))

(defun aes-mix-columns (data)
  (setf (subseq data 0 4) (aes-mix-columns-word (subseq data 0 4)))
  (setf (subseq data 4 8) (aes-mix-columns-word (subseq data 4 8)))
  (setf (subseq data 8 12) (aes-mix-columns-word (subseq data 8 12)))
  (setf (subseq data 12 16) (aes-mix-columns-word (subseq data 12 16)))
  (return-from aes-mix-columns data))

(defun aes-mix-columns-inv (data)
  (setf (subseq data 0 4) (aes-mix-columns-word-inv (subseq data 0 4)))
  (setf (subseq data 4 8) (aes-mix-columns-word-inv (subseq data 4 8)))
  (setf (subseq data 8 12) (aes-mix-columns-word-inv (subseq data 8 12)))
  (setf (subseq data 12 16) (aes-mix-columns-word-inv (subseq data 12 16)))
  (return-from aes-mix-columns-inv data))

;;; end encrypt decrypt function
(defun aes-encrypt (data key &optional (bits 256))
  (let ((ex-key (aes-expandkey key bits))
        (round 0)
        (repeat 0)
        (bytes (/ bits 8)))
    (cond ((= bytes 16) (setf repeat 10))
          ((= bytes 24) (setf repeat 12))
          ((= bytes 32) (setf repeat 14))
          (t 
           (progn
             (format t "wrong bits size~%")
             (return-from aes-encrypt nil))))
    ;; initial add round key
    (setf data (aes-add-round-key data (subseq ex-key round (+ round 16))))
    ;; repeat
    (dotimes (i (- repeat 1))
      (setf round (+ round 16))
      (aes-sub-bytes data +sbox+)
      (setf data (aes-shift-rows data +shift+))
      (aes-mix-columns data)
      (aes-add-round-key data (subseq ex-key round (+ round 16))))
    ;; last time, no mix-columns
    (setf round (+ round 16))
    (aes-sub-bytes data +sbox+)
    (setf data (aes-shift-rows data +shift+))
    (aes-add-round-key data (subseq ex-key round (+ round 16)))
    (return-from aes-encrypt data)))

(defun aes-decrypt (data key &optional (bits 256))
  (let ((ex-key (aes-expandkey key bits))
        (round 0)
        (repeat 0)
        (bytes (/ bits 8)))
    (cond ((= bytes 16) (setf repeat 10))
          ((= bytes 24) (setf repeat 12))
          ((= bytes 32) (setf repeat 14))
          (t 
           (progn
             (format t "wrong bits size~%")
             (return-from aes-decrypt nil))))
    (setf round (* repeat 16))
    ;; initial add round key
    (setf data (aes-add-round-key data (subseq ex-key round (+ round 16))))
    ;; repeat
    (dotimes (i (- repeat 1))
      (setf round (- round 16))
      (setf data (aes-shift-rows data +shift_inv+))
      (aes-sub-bytes data +sbox_inv+)
      (aes-add-round-key data (subseq ex-key round (+ round 16)))
      (aes-mix-columns-inv data))
    ;; last time, no mix-columns
    (setf round (- round 16))
    (setf data (aes-shift-rows data +shift_inv+))
    (aes-sub-bytes data +sbox_inv+)
    (aes-add-round-key data (subseq ex-key round (+ round 16)))
    (return-from aes-decrypt data)))

(defun padding-RKCS (data len bytes)
  (if (= len 0)
      (dotimes (i bytes)
        (setf (aref data i) bytes))
      (dotimes (i (- bytes len))
        (setf (aref data (+ i len)) (- bytes len)))))

(defun de-padding-RKCS (data bytes)
  (let ((last (aref data (- bytes 1))))
    (dotimes (i last data)
      (setf (aref data (+ i (- bytes last))) nil))))


;;(defmacro aes (filename block)
;;  `(,block-aes-encrypt-file ,filename padding-RKCS *aes-key*))

;;; use ECB aes encrypt and decrypt
(defun ECB-aes-encrypt-file (filename padding key)
  (with-open-file (in-str filename :element-type '(unsigned-byte 8))
    (with-open-file (out-str (format nil "~A.aes" filename)
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create
                             :element-type '(unsigned-byte 8))
      (let ((buf (make-array 16 :element-type '(unsigned-byte 8)))
            (len 0))
        (do ((in (read-byte in-str nil 'eof)
                 (read-byte in-str nil 'eof)))
            ((eql in 'eof)
             (progn
               (if (= len 16)
                    (progn
                      (setf len 0)
                      (setf buf (aes-encrypt buf key))
                      (dotimes (i 16)
                        (write-byte (aref buf i) out-str))))
               (funcall padding buf len 16)
               (setf buf (aes-encrypt buf key))
               (dotimes (i 16 t)
                 (write-byte (aref buf i) out-str))
               ))
          (if (= len 16)
              (progn
                (setf len 1)
                (setf buf (aes-encrypt buf key))
                (dotimes (i 16)
                  (write-byte (aref buf i) out-str)))
              (setf len (+ len 1)))
          (setf (aref buf (- len 1)) in))))))

(defun ECB-aes-decrypt-file (filename padding key)
  (with-open-file (in-str filename :element-type '(unsigned-byte 8))
    (with-open-file (out-str (format nil "~A" (subseq filename 0 (- (length filename) 4)))
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create
                             :element-type '(unsigned-byte 8))
      (let ((buf (make-array 16 :element-type '(unsigned-byte 8)))
            (len 0))
        (do ((in (read-byte in-str nil 'eof)
                 (read-byte in-str nil 'eof)))
            ((eql in 'eof)
             (progn
               (setf buf (aes-decrypt buf key))
               (funcall padding buf 16)
               (dotimes (i 16 t)
                 (if (not (null (aref buf i)))
                     (write-byte (aref buf i) out-str)))))
          (if (= len 16)
              (progn
                (setf len 1)
                (setf buf (aes-decrypt buf key))
                (dotimes (i 16)
                  (write-byte (aref buf i) out-str)))
              (setf len (+ len 1)))
          (setf (aref buf (- len 1)) in))))))

(defmacro array-copy (a1 a2)
  `(dotimes (i (length ,a1))
     (setf (aref ,a1 i) (aref ,a2 i))))
(defmacro array-logxor (a1 a2)
  `(map '(simple-array (unsigned-byte 8) (*))
                               #'logxor
                               ,a1 ,a2))
;;; use CBC aes encrypt and decrypt
(defun CBC-aes-encrypt-file (filename padding key IV)
  (with-open-file (in-str filename :element-type '(unsigned-byte 8))
    (with-open-file (out-str (format nil "~A.aes" filename)
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create
                             :element-type '(unsigned-byte 8))
      (let ((buf (make-array 16 :element-type '(unsigned-byte 8)))
            (pre-ciphertext (make-array 16 :element-type '(unsigned-byte 8)))
            (len 0))
        (dotimes (i 16)
          (setf (aref pre-ciphertext i) (+ (mod IV (- 256 i)) i)))
        (do ((in (read-byte in-str nil 'eof)
                 (read-byte in-str nil 'eof)))
            ((eql in 'eof)
             (progn
               (if (= len 16)
                    (progn
                      (setf len 0)
                      (setf buf (array-logxor buf pre-ciphertext))
                      (setf buf (aes-encrypt buf key))
                      (dotimes (i 16)
                        (write-byte (aref buf i) out-str))))
               (funcall padding buf len 16)
               (setf buf (aes-encrypt buf key))
               (dotimes (i 16 t)
                 (write-byte (aref buf i) out-str))))
          (if (= len 16)
              (progn
                (setf len 1)
                (setf buf (array-logxor buf pre-ciphertext))
                (setf buf (aes-encrypt buf key))
                (array-copy pre-ciphertext buf)
                (dotimes (i 16)
                  (write-byte (aref buf i) out-str)))
              (setf len (+ len 1)))
          (setf (aref buf (- len 1)) in))))))

(defun CBC-aes-decrypt-file (filename padding key IV)
  (with-open-file (in-str filename :element-type '(unsigned-byte 8))
    (with-open-file (out-str (format nil "~A" (subseq filename 0 (- (length filename) 4)))
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create
                             :element-type '(unsigned-byte 8))
      (let ((buf (make-array 16 :element-type '(unsigned-byte 8)))
            (pre-ciphertext (make-array 16 :element-type '(unsigned-byte 8)))
            (pre-pre-ciphertext (make-array 16 :element-type '(unsigned-byte 8)))
            (len 0))
        (dotimes (i 16)
          (setf (aref pre-pre-ciphertext i) (+ (mod IV (- 256 i)) i)))
        (do ((in (read-byte in-str nil 'eof)
                 (read-byte in-str nil 'eof)))
            ((eql in 'eof)
             (progn
               (setf buf (aes-decrypt buf key))
               (funcall padding buf 16)
               (dotimes (i 16 t)
                 (if (not (null (aref buf i)))
                     (write-byte (aref buf i) out-str)))))
          (if (= len 16)
              (progn
                (setf len 1)
                (array-copy pre-ciphertext buf)
                (setf buf (aes-decrypt buf key))
                (setf buf (array-logxor buf pre-pre-ciphertext))
                (array-copy pre-pre-ciphertext pre-ciphertext)
                (dotimes (i 16)
                  (write-byte (aref buf i) out-str)))
              (setf len (+ len 1)))
          (setf (aref buf (- len 1)) in))))))


(defmacro array-add (array num)
  `(dotimes (i (length ,array))
     (if (> (+ (aref ,array i) ,num) 255)
         (progn
           (setf ,num (- (+ (aref ,array i) ,num) 255))
           (setf (aref ,array i) 0))
         (progn
           (setf (aref ,array i) (+ (aref ,array i) ,num))
           (return)))))
;;; use CTR aes encrypt and decrypt
(defun CTR-aes-file (filename padding key IV en-or-de)
  (with-open-file (in-str filename :element-type '(unsigned-byte 8))
    (with-open-file (out-str (format nil "~A.aes" filename)
                             :direction :output
                             :if-exists :supersede
                             :if-does-not-exist :create
                             :element-type '(unsigned-byte 8))
      (let ((buf (make-array 16 :element-type '(unsigned-byte 8)))
            (counter (make-array 16 :element-type '(unsigned-byte 8)))
            (tmp-counter (make-array 16 :element-type '(unsigned-byte 8)))
            (len 0))
        (dotimes (i 16)
          (setf (aref counter i) (+ (mod IV (- 256 i)) i)))
        (do ((in (read-byte in-str nil 'eof)
                 (read-byte in-str nil 'eof)))
            ((eql in 'eof)
             (if (= en-or-de 1)
                 (progn
                   (if (= len 16)
                       (progn
                         (setf len 0)
                         (array-copy tmp-counter counter)
                         (setf buf (array-logxor (aes-encrypt tmp-counter key) buf))
                         (array-add counter 1)
                         (dotimes (i 16)
                           (write-byte (aref buf i) out-str))))
                   (funcall padding buf len 16)
                   (setf buf (array-logxor (aes-encrypt counter key) buf))
                   (dotimes (i 16 t)
                     (write-byte (aref buf i) out-str)))
                 (progn
                   (setf buf (array-logxor (aes-encrypt counter key) buf))
                   (dotimes (i (- 16 (aref buf 15)) t)
                     (write-byte (aref buf i) out-str)))))
          (if (= len 16)
              (progn
                (setf len 1)
                (array-copy tmp-counter counter)
                (setf buf (array-logxor (aes-encrypt tmp-counter key) buf))
                (array-add counter 1)
                (dotimes (i 16)
                  (write-byte (aref buf i) out-str)))
              (setf len (+ len 1)))
          (setf (aref buf (- len 1)) in))))))

(defmacro CTR-aes-encrypt-file (filename padding key IV)
  `(CTR-aes-file ,filename ,padding ,key ,IV 1))
(defmacro CTR-aes-decrypt-file (filename padding key IV)
  `(CTR-aes-file ,filename ,padding ,key ,IV 0))

;;; use XTS aes encrypt and decrypt

;;; check plaintext, ciphertext and de-ciphertext
(defun cmp-file (filename)
  (let ((count 0))
    (with-open-file (str filename :element-type '(unsigned-byte 8))
      (format t "~%")
      (do ((in (read-byte str nil 'eof)
             (read-byte str nil 'eof)))
        ((eql in 'eof))
        (if (= count 16)
            (progn
              (setf count 0)
              (format t "~%")))
        (incf count)
        (format t "~4A" in)))
    (format t "~%~%")
    (setf count 0)
    (with-open-file (str (format nil "~A.aes" filename) :element-type '(unsigned-byte 8))
      (format t "~%")
      (do ((in (read-byte str nil 'eof)
               (read-byte str nil 'eof)))
          ((eql in 'eof))
        (if (= count 16)
            (progn
              (setf count 0)
              (format t "~%")))
        (incf count)
        (format t "~4A" in)))
    (format t "~%~%")
    (setf count 0)))
    ;; (with-open-file (str (format nil "~A.ae" filename) :element-type '(unsigned-byte 8))
    ;;   (do ((in (read-byte str nil 'eof)
    ;;            (read-byte str nil 'eof)))
    ;;       ((eql in 'eof))
    ;;     (if (= count 16)
    ;;         (progn
    ;;           (setf count 0)
    ;;           (format t "~%")))
    ;;     (incf count)
    ;;     (format t "~A " in)))))


;;; testbench
;(ECB-aes-encrypt-file "1" #'padding-RKCS (aes-generate-key))
;(ECB-aes-decrypt-file "1.aes" #'de-padding-RKCS *aes-key*)
