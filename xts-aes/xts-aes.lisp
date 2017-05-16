(defparameter *aes-key*)

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

;; default 256 bit
;; other 128 192 256
(defun aes-generate-key (&optional (bits 256))
  (cond ((= bits 256))
        ((= bits 192))
        ((= bits 128))
        (t 
         (progn
           (format t "wrong bits size~%")
           (return-from aes-generate-key nil))))
  (let* ((bytes (/ bits 8))
        (key (make-array 256 :element-type '(unsigned-byte 8))))
    (dotimes (i bytes key)
      (setf (aref key i) (random 256)))))

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
    (setf (aref word i) (svref +sbox+ (aref word i)))))

(defun aes-expandkey (key &optional (bits 256))
  (let ((repeat 0)
        (key-len (/ bits 8)))
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
      (dotimes (i repeat key)
        (setf tmp1 (aes-rot-word (subseq key (- key-len 4) key-len))) 
        ;;(format t "~A" tmp1)
        (setf tmp2 (aes-sub-word tmp1))
        (setf tmp3 tmp2)
        (setf (aref tmp3 0) (logxor (aref tmp3 0)
                                    (aref +rcon+ (+ i 1))))
        (setf (subseq key key-len (+ key-len 4))
              (map '(simple-array (unsigned-byte 8) (*))
                   #'logxor
                   (subseq key (- key-len 16) (- key-len 12))
                   tmp3))
        (dotimes (j 3)
          (let ((shift (* (+ j 1) 4)))
            (setf (subseq key (+ key-len shift) (+ key-len (+ 4 shift)))
                  (map '(simple-array (unsigned-byte 8) (*))
                       #'logxor
                       (subseq key (+ key-len (- shift 4)) (+ key-len shift))
                       (subseq key (- (+ key-len shift) 16) (- (+ key-len shift) 12))
                       ))))
        (setf key-len (+ key-len 16))))))
                                             

(defun aes-add-round-key (data key)
  (dotimes (i 16 data)
    (setf (svref data i) (logxor (svref data i)
                                 (svref key i)))))

;; table inverse or not
;; +sbox+        +sbox_inv+
;; +shift+       +shift_inv+
(defun aes-sub-bytes (data table)
  (dotimes (i 16 data)
    (setf (svref data i) (svref table (svref data i)))))

(defun aes-shift-rows (data table)
  (let ((tmp (make-array 16)))
    (dotimes (i 16 tmp)
      (setf (svref tmp (svref table i)) (svref data i)))))

;; (defun aes-round (data round-key)
;;   (aes-add-round-key data key)
;;   (
