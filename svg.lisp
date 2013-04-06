(defpackage :svgturtle.svg
  (:use :common-lisp)
  (:export :svg
           :tag
           :line
           :rgb-color))

(in-package :svgturtle.svg)

(defmacro split (val yes no)
  (let ((g (gensym)))
    `(let ((,g ,val))
       (if ,g
           (let ((head (car ,g))
                 (tail (cdr ,g)))
             ,yes)
           ,no))))

(defun pairs (lst)
  (labels ((f (lst acc)
             (split lst
                    (if tail
                        (f (cdr tail) (cons (cons head (car tail)) acc))
                        (reverse acc))
                    (reverse acc))))
    (f lst nil)))

(defun print-tag (name lst closingp)
  (princ #\<)
  (when closingp
    (princ #\/))
  (princ (string-downcase name))
  (mapc (lambda (att)
          (format t " ~a=\"~a\"" (string-downcase (car att)) (cdr att)))
        lst)
  (princ #\>))

(defmacro tag (name atts &body body)
  `(progn (print-tag ',name
                     (list ,@(mapcar (lambda (x)
                                       `(cons ',(car x) ,(cdr x)))
                                     (pairs atts)))
                     nil)
          ,@body
          (print-tag ',name nil t)))

(defmacro svg (width height &body body)
  `(tag svg (xmlns "http://www.w3.org/2000/svg"
                   "xmlns:xlink" "http://www.w3.org/1999/xlink"
                   height ,height
                   width ,width)
     ,@body))

(defun line (&key x1 y1 x2 y2 (style ""))
  (tag line (x1 x1 y1 y1 x2 x2 y2 y2 style style)))

(defun rgb-color (r g b)
  (format nil "rgb(~a,~a,~a)" r g b))
