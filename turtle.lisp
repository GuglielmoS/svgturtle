(defpackage :svgturtle.turtle
  (:use :common-lisp)
  (:export :with-turtle
           :pos
           :color
           :pen-state
           :angle
           :goto
           :goto-center
           :goto-top-center
           :set-color
           :set-random-color
           :random-color
           :pen-up
           :pen-down
           :forward
           :back
           :left
           :right))

(in-package :svgturtle.turtle)

(use-package :svgturtle.svg)

(defclass turtle ()
  ((pos :accessor turtle-pos
        :initform '(0 . 0)
        :initarg :pos)
   (angle :accessor turtle-angle
        :initform 90
        :initarg :angle)
   (pen-state :accessor turtle-pen-state
              :initform :down
              :initarg :pen-state)
   (color :accessor turtle-color
          :initform "black"
          :initarg :color)))

(defmacro with-turtle (filename width height &body body)
  (let ((g (gensym)))
    `(let ((,g (make-instance 'turtle)))
       (labels ((pos () (turtle-pos ,g))
                (color () (turtle-color ,g))
                (pen-state () (turtle-pen-state ,g))
                (angle () (turtle-angle ,g))
                (goto (p) (setf (turtle-pos ,g) p))
                (goto-top-center ()
                  (setf (turtle-pos ,g) (cons (/ ,width 2) 0)))
                (goto-center ()
                  (setf (turtle-pos ,g) (cons (/ ,width 2) (/ ,height 2))))
                (set-color (c) (setf (turtle-color ,g) c))
                (set-random-color () (setf (turtle-color ,g) (random-color)))
                (pen-up () (setf (turtle-pen-state ,g) :up))
                (pen-down () (setf (turtle-pen-state ,g) :down))
                (forward (n)
                  (let* ((cx (car (turtle-pos ,g)))
                         (cy (cdr (turtle-pos ,g)))
                         (a (/ (* pi (turtle-angle ,g)) 180))
                         (np (cons (round (+ cx (* (cos a) n)))
                                   (round (+ cy (* (sin a) n))))))
                    (when (eq (turtle-pen-state ,g) :down)
                      (tag line (:x1 cx :y1 cy :x2 (car np) :y2 (cdr np)
                                     :style (format nil"fill:none;stroke:~a"
                                                    (turtle-color ,g)))))
                    (setf (turtle-pos ,g) np)))
                (back (n) (forward (- n)))
                (left (a) (setf (turtle-angle ,g) (mod (+ (turtle-angle ,g) a) 360)))
                (right (a) (left (- a))))
         (with-open-file (*standard-output* ,filename
                                            :direction :output
                                            :if-exists :supersede)
           (svg ,width ,height (progn ,@body)))))))

(defun random-color ()
  (rgb-color (random 256) (random 256) (random 256)))
