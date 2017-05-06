(defun cf-sig-myfriend (&optional (filename "myfriend"))
  (with-open-file (out (format nil "sig-~A" filename)
                       :direction :output
                       :if-exists :supersede)
    (with-open-file (in filename)
      (do ((friend-name (read-line in nil 'eof)
                   (read-line in nil 'eof)))
          ((eql friend-name 'eof))
        (progn
          (let ((tmp (sig-encrypt-rsa-pss friend-name)))
            (format out "~A~%" tmp)))))))
