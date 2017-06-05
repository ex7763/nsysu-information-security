(ql:quickload "hunchentoot")

(defmacro as (tag content)
  `(format t "<~(~A~)>~A</~(~A~)>"
           ',tag ,content ',tag))

(defmacro with (tag &rest body)
  `(progn
     (format t "~&<~(~A~)>~%" ',tag)
     ,@body
     (format t "~&</~(~A~)>~%" ',tag)))

(defmacro brs (&optional (n 1))
  (fresh-line)
  (dotimes (i n)
    (princ "<br>"))
  (terpri))


(defparameter page-head  
      "<HTML><HEAD><TITLE>test</TITLE></HEAD><BODY>
        <style>div.style1 {
            margin-top:0;
            margin-left:200;
            margin-right:200;
            margin-bottom:0;
            padding-top:30;
            padding-left:50;
            padding-right:50;
            padding-bottom:50;
            background-color:#eeeeee;
        }</style>")

(defparameter page-title (concatenate 'string
                              ""))
(defparameter sections (as center "The Missing Lambda"))

(defparameter page-tail "</BODY></HTML>")

(hunchentoot:define-easy-handler (greet :uri "/") ()
  (format nil "~{~A~}" `(,page-head ,page-title ,@sections ,page-tail)))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 8080))
