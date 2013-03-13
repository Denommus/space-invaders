;;;; bullet.lisp

(in-package #:space-invaders)

(defclass bullet (scene-node)
  ((image
    :initarg :image
    :reader image
    :initform (sdl:load-image
               (merge-pathnames #p"assets/laser.png")))
   (zoom
    :initarg :zoom
    :reader zoom
    :initform #(1/10 1/10))))

(defmethod update ((this bullet))
  "Updates the bullet"
  (with-accessors ((pos pos) (scene-manager scene-manager)) this
    (setf pos (map 'vector #'+ pos #(0 -10)))
    (when (< (elt pos 1) 0)
      (setf (scene-objects scene-manager) (delete this (scene-objects scene-manager))))))
