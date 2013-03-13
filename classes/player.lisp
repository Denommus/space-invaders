;;;; player.lisp

(in-package #:space-invaders)

(defclass player (scene-node)
  ((image
    :initarg :image
    :reader image
    :initform (sdl:load-image
               (merge-pathnames #p"assets/nave.png")))
   (zoom
    :initarg :zoom
    :reader zoom
    :initform #(1/6 1/6))
   (pos
    :initarg pos
    :accessor pos
    :initform #(100 500))))

(defmacro cond-fall-through (&body cases)
  `(progn ,@(mapcar #'(lambda (case)
                        `(when ,(car case)
                           ,@(cdr case))) cases)))

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
