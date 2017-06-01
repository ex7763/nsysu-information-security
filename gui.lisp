(use-package :ltk)
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
           (exit-key (make-instance 'button
                                    :text "EXIT"
                                    :master f-left
                                    :width 20
                                    :command
                                    (lambda ()
                                      (setf *exit-mainloop* t))))
           (label-user-name (make-instance 'label
                                          :master f-right
                                          :text "user name"
                                          :font "20"))
           (user-name (make-instance 'entry
                                     :master f-right
                                     :text "my"
                                     :width 30))
           (label-filename (make-instance 'label
                                          :master f-right
                                          :text "filename"
                                          :font "20"))
           (filename (make-instance 'entry
                                    :master f-right
                                    :text "myKey"
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
                                         (aes-generate-key)
                                         (setf (text message)
                                               (format nil "You get a aes-key!~%~A" *aes-key*)))))
           (gen-key (make-instance 'button
                                   :text "Generate rsa-key"
                                   :master f-left
                                   :width 20
                                   :command
                                   (lambda ()
                                     (let ((*print-base* 16))
                                       (rsa-get-key (text filename))
                                       (rsa-load-key (text filename))
                                       (setf (text message)
                                             (format nil "You get a rsa-key!~%~S" *rsa-key*))))))
           (gen-id-file (make-instance 'button
                                       :text "Generate id-file"
                                       :master f-left
                                       :width 20
                                       :command
                                       (lambda ()
                                         (sig-generate-id "TEST")
                                         (with-open-file (str "SIG_CHECK_FILE")
                                           (setf (text message)
                                                 (format nil "~A~%~A~%~A~%~A~%" (read str) (read str) (read str) (read str)))))))
           (re-gen-id-file (make-instance 'button
                                          :text "re-Generate id-file"
                                          :master f-left
                                          :width 20
                                          :command
                                          (lambda ()
                                            (sig-re-generate-id "TEST2")
                                            (with-open-file (str "re_SIG_CHECK_FILE")
                                              (setf (text message)
                                                    (format nil "~A~%~A~%~A~%~A~%" (read str) (read str) (read str) (read str)))))))
           (check-and-change (make-instance 'button
                                            :text "Check id and change public key"
                                            :master f-left
                                            :width 20
                                            :command
                                            (lambda ()
                                              (setf (text message)
                                                    (sig-check-id)))))
           ;; (my-friend (make-instance 'button
           ;;                           :text "my-friend"
           ;;                           :master f-left
           ;;                           :width 20
           ;;                           (lambda ()
           ;;                             (setf (text message)
           ;;                                   ()))))
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
                                                ((eql in 'eof) (setf (text message)
                                                                     (format nil "~A" out)))
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
                                                                         (concatenate 'string "sig-" (text friend-name) "friend")
                                                                         (concatenate 'string (text friend-name) "Key"))
                                         (setf (text message)
                                               (format nil "sig check is ~%~A~%same friend is~%~A~%" check fri)))))))
                                        
      (pack f)
      (pack f-left :side :left)
      (pack f-right :side :right)
      ;; f-left
      (pack gen-aes-key)
      (pack gen-key)
      (pack gen-id-file)
      (pack re-gen-id-file)
      (pack check-and-change)
      ;; (pack my-friend)
      (pack sig-friend)
      (pack check-sig)
      (pack exit-key)
      ;; f-right
      (pack label-user-name)
      (pack user-name)
      (pack label-filename)
      (pack filename)
      (pack label-friend)
      (pack friend-name)
      (pack label-message)
      (pack message))))
