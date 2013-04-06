(use-package :svgturtle.turtle)

(defun generate-brownian-motion-svg ()
  (with-turtle "examples/brownian_motion.svg" 800 600
    (goto-center)
    (loop repeat 10000 do
         (set-random-color)
         (forward (* 3 (1- (random 2))))
         (right (* 90 (random 4))))))

(defun generate-dahlia-svg ()
  (with-turtle "examples/dahlia.svg" 500 400
    (goto-center)
    (loop repeat 8 do
         (right 45)
         (loop repeat 6 do
              (set-random-color)
              (loop repeat 90 do
                   (forward 2)
                   (right 2))
              (right 90)))))

(defun generate-fanflower-svg ()
  (with-turtle "examples/fan_flower.svg" 600 800
    (goto-center)
    (loop repeat 12 do
         (set-random-color)
         (loop repeat 75 do
              (forward 100)
              (back 100)
              (right 2))
         (forward 250))))

(defun generate-feathers-svg ()
  (with-turtle "examples/feathers.svg" 600 600
    (goto-center)
    (loop repeat 12 do
         (set-random-color)
         (loop repeat (random 50) do
              (forward 100)
              (back 95)
              (right 2))
         (right 180))))

(defun generate-fib-svg ()
  (with-turtle "examples/fib.svg" 500 300 
    (defun fib (depth)
      (set-color (random-color))
      (forward 30)
      (when (> depth 2)
        (progn (left 15)
               (fib (- depth 1))
               (right 30)
               (fib (- depth 2))
               (left 15)))
      (back 30))
    (goto-top-center)
    (fib 12)))

(defun generate-hexagon-svg ()
  (with-turtle "examples/hexagon.svg" 400 400
    (goto-center)
    (left 90)
    (forward 35)
    (right 60)
    (forward 70)
    (right 60)
    (forward 70)
    (right 60)
    (forward 70)
    (right 60)
    (forward 70)
    (right 60)
    (forward 70)
    (right 60)
    (forward 35)))

(defun generate-hypercube-svg ()
  (with-turtle "examples/hypercube.svg" 600 600
    (goto-center)
    (loop repeat 8 do
         (set-random-color)
         (loop repeat 4 do
              (right 90)
              (forward 100))
         (back 100)
         (left 45))))

(defun generate-rotating-circle-svg ()
  (with-turtle "examples/rotating_circle.svg" 800 600 
    (goto-center)
    (loop repeat 400 do
         (set-random-color)
         (loop repeat 34 do
              (forward 12)
              (right 10))
         (right 10))))

(defun generate-square-svg ()
  (with-turtle "examples/square.svg" 400 400
    (goto-center)
    (right 90)
    (forward 50)
    (left 90)
    (forward 100)
    (left 90)
    (forward 100)
    (right 90)
    (back 100)
    (right 90)
    (forward 50)))
