(use-package :ltk)

(defmacro display (&rest body)
  `(setf (text message)
        ,@body))

(defun gui()
  (with-ltk ()
    (let* ((f (make-instance 'frame
                             :master nil
                             :width 200
                             :height 200))
           (f-left (make-instance 'frame
                                  :master f
                                  :width 100
                                  :height 100))
           (f-right (make-instance 'frame
                                   :master f
                                   :width 100
                                   :height 100))
           (f-bottom (make-instance 'frame
                                    :master f))
           (exit-key (make-instance 'button
                                    :text "EXIT"
                                    :master f-left
                                    :width 20
                                    :command
                                    (lambda ()
                                      (setf *exit-mainloop* t))))
           (author (make-instance 'label
                                  :text (format nil "B053040033~t許博鈞")
                                  :master f-left
                                  :font "20"))
           (label-user-name (make-instance 'label
                                          :master f-right
                                          :text "user name"
                                          :font "20"))
           (user-name (make-instance 'entry
                                     :master f-right
                                     :text "my"
                                     :width 30))
           (label-aes-mode (make-instance 'label
                                          :master f-right
                                          :text "AES-mode"
                                          :font "20"))
           (aes-mode (make-instance 'entry
                                    :master f-right
                                    :text "CTR"
                                    :width 30))
           (label-aes-filename (make-instance 'label
                                              :master f-right
                                              :text "AES-filename"
                                              :font "20"))
           (aes-filename (make-instance 'entry
                                        :master f-right
                                        :text "test_plaintext"
                                        :width 30))
           (label-friend (make-instance 'label
                                        :master f-right
                                        :text "friend name"
                                        :font "20"))
           (friend-name (make-instance 'entry
                                       :master f-right
                                       :text "Bob"
                                       :width 30))
           (label-message (make-instance 'label
                                         :master f-right
                                         :text "message"
                                         :font "20"))
           (message (make-instance 'text
                                   :font "20"
                                   :master f-right
                                   :width 30
                                   :height 15))
           (gen-aes-key (make-instance 'button
                                       :text "Generate aes-key"
                                       :master f-left
                                       :width 20
                                       :command
                                       (lambda ()
                                         (let ((*print-base* 16))
                                           (aes-generate-key)
                                           (display
                                                 (format nil "You get a aes-key!~%~A" *aes-key*))
                                           (aes-save-key (format nil "~AAESKey" (text user-name)) *aes-key*)))))
           (aes-encrypt (make-instance 'button
                                       :text "Encrypt a file"
                                       :master f-left
                                       :width 20
                                       :command
                                       (lambda ()
                                         (cond ((string-equal (text aes-mode) "ECB")
                                                (progn
                                                  (ECB-aes-encrypt-file (text aes-filename) #'padding-RKCS *aes-key*)
                                                  (display (cmp-file (concatenate 'string (text aes-filename) ".aes")))))
                                               ((string-equal (text aes-mode) "CBC")
                                                (progn
                                                  (CBC-aes-encrypt-file (text aes-filename) #'padding-RKCS *aes-key* *Ra*)
                                                  (display (cmp-file (concatenate 'string (text aes-filename) ".aes")))))
                                               ((string-equal (text aes-mode) "CTR")
                                                (progn
                                                  (CTR-aes-encrypt-file (text aes-filename) #'padding-RKCS *aes-key* *Ra*)
                                                  (display (cmp-file (concatenate 'string (text aes-filename) ".aes")))))
                                               (t (display "Wrong aes-mode"))))))
           (aes-decrypt (make-instance 'button
                                       :text "Decrypt a file"
                                       :master f-left
                                       :width 20
                                       :command
                                       (lambda ()
                                         (cond ((string-equal (text aes-mode) "ECB")
                                                (progn
                                                  (ECB-aes-decrypt-file (concatenate 'string (text aes-filename) ".aes")
                                                                        #'de-padding-RKCS *aes-key*)
                                                  (display (cmp-file (text aes-filename)))))
                                               ((string-equal (text aes-mode) "CBC")
                                                (progn
                                                  (CBC-aes-decrypt-file (concatenate 'string (text aes-filename) ".aes")
                                                                        #'de-padding-RKCS *aes-key* *Ra*)
                                                  (display (cmp-file (text aes-filename)))))
                                               ((string-equal (text aes-mode) "CTR")
                                                (progn
                                                  (CTR-aes-decrypt-file (concatenate 'string (text aes-filename) ".aes")
                                                                        #'de-padding-RKCS *aes-key* *Ra*)
                                                  (display (cmp-file (text aes-filename)))))
                                               (t (display "Wrong aes-mode"))))))
           (gen-key (make-instance 'button
                                   :text "Generate rsa-key"
                                   :master f-left
                                   :width 20
                                   :command
                                   (lambda ()
                                     (let ((*print-base* 16))
                                       (rsa-get-key (format nil "~AKey" (text user-name)))
                                       (rsa-load-key (format nil "~AKey" (text user-name)))
                                       (display (format nil "You get a rsa-key!~%~S" *rsa-key*))))))
           (gen-id-file (make-instance 'button
                                       :text "Generate id-file"
                                       :master f-left
                                       :width 20
                                       :command
                                       (lambda ()
                                         (sig-generate-id "TEST")
                                         (with-open-file (str "SIG_CHECK_FILE")
                                           (display (format nil "~A~%~A~%~A~%~A~%" (read str) (read str) (read str) (read str)))))))
           (re-gen-id-file (make-instance 'button
                                          :text "re-Generate id-file"
                                          :master f-left
                                          :width 20
                                          :command
                                          (lambda ()
                                            (sig-re-generate-id "TEST2" *aes-key*)
                                            (with-open-file (str "re_SIG_CHECK_FILE")
                                              (display (format nil "~A~%~A~%~A~%~A~%" (read str) (read str) (read str) (read str)))))))
           (check-and-change (make-instance 'button
                                            :text "Check id and change public key"
                                            :master f-left
                                            :width 20
                                            :command
                                            (lambda ()
                                              (display (sig-check-id)))))
           (sig-friend (make-instance 'button
                                      :text "sig-friend"
                                      :master f-left
                                      :width 20
                                        ;:style my-button
                                      :command
                                      (lambda ()
                                        (cf-sig-friend (format nil "~Afriend" (text user-name)))
                                        (with-open-file (str (format nil "sig-~Afriend" (text user-name)))
                                          (let ((*print-base* 16)
                                                (out nil))
                                            (do ((in (read str nil 'eof)
                                                     (read str nil 'eof)))
                                                ((eql in 'eof) (display (format nil "~A" out)))
                                              (setf out (concatenate 'string out (write-to-string in) (format nil "~%~%")))))))))
           (check-sig (make-instance 'button
                                     :text "check-other-sig"
                                     :master f-left
                                     :width 20
                                     :command
                                     (lambda ()
                                       (multiple-value-bind (check fri) (cf-sig-check-same-friend
                                                                         (format nil "~Afriend" (text user-name))
                                                                         (format nil "sig-~Afriend" (text user-name))
                                                                         (concatenate 'string "sig-" (text friend-name) "friend"))
                                         (display (format nil "sig check is ~%~A~%same friend is~%~A~%" check fri)))))))
                                        
      (pack f)
      (pack f-left :side :left)
      (pack f-right :side :right)
      (pack f-bottom :side :bottom)
      ;; f-left
      (pack gen-aes-key)
      (pack aes-encrypt)
      (pack aes-decrypt)
      (pack gen-key)
      (pack gen-id-file)
      (pack re-gen-id-file)
      (pack check-and-change)
      ;; (pack my-friend)
      (pack sig-friend)
      (pack check-sig)
      (pack exit-key)
      (pack author)
      ;; f-right
      (pack label-aes-mode)
      (pack aes-mode)
      (pack label-aes-filename)
      (pack aes-filename)
      (pack label-user-name)
      (pack user-name)
      (pack label-friend)
      (pack friend-name)
      (pack label-message)
      (pack message))))
