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
           (exit-key (make-instance 'button
                                    :text "EXIT"
                                    :master f-left
                                    :width 20
                                    :command
                                    (lambda ()
                                      (setf *exit-mainloop* t))))
           (simple-text (make-instance 'text
                                       :font "20"
                                       :master f
                                       :width 30
                                       :height 15))
           (gen-key (make-instance 'button
                                   :text "Genterate rsa-key"
                                   :master f-left
                                   :width 20
                                   :command
                                   (lambda ()
                                     (rsa-get-key "testKey")
                                     (setf (text simple-text) "You get a key"))))
           (sig-friend (make-instance 'button
                                      :text "sig-myfried"
                                      :master f-left
                                      :width 20
                                     ;:style my-button
                                      :command
                                      (lambda ()
                                        (cf-sig-friend)))))
      (pack f)
      (pack f-left :side :left)
      (pack gen-key)
      (pack sig-friend)
      (pack exit-key)
      (pack simple-text :side :right))))
