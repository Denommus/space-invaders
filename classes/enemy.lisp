;;;; enemy.lisp

(in-package #:space-invaders)

(defclass enemy (scene-node)
  ((image
    :initarg :image
    :reader image
    :initform (sdl:load-image
               (merge-pathnames #p"assets/invader_red.png")))
   (zoom
    :initarg :zoom
    :reader zoom
    :initform #(1/6 1/6))))

(defmethod update ((this enemy))
  "Updates the enemy"
  (with-accessors ((pos pos) (scene-manager scene-manager)) this
    (setf pos (map 'vector #'+ pos #(0 5)))
    (when (> (elt pos 1) 600)
      (setf (scene-objects scene-manager) (delete this (scene-objects scene-manager))))))
