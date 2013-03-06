;;;; player.lisp

(in-package #:space-invaders)

(defclass player (ship) ())

(defmacro cond-fall-through (&body cases)
  (flet ((transform-case (case)
           `(when ,(car case)
              ,@(cdr case))))
    `(progn
       ,@(mapcar #'transform-case cases))))

(defmethod update ((this player))
  "Updates the player"
  (with-accessors ((pos pos)) this
    (cond-fall-through
     ((or (sdl:key-down-p :sdl-key-left) (sdl:key-down-p :sdl-key-a))
      (decf (elt pos 0) 20)
      (when (< (elt pos 0) 0)
        (setf (elt pos 0) 0)))
     ((or (sdl:key-down-p :sdl-key-right) (sdl:key-down-p :sdl-key-d))
      (incf (elt pos 0) 20)
      (when (> (elt pos 0) 800)
        (setf (elt pos 0) 800))))))
