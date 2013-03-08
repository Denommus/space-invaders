;;;; scene-manager.lisp

(in-package #:space-invaders)

(defclass scene-manager ()
  ((scene-objects
    :initarg :scene-objects
    :accessor scene-objects
    :initform ()
    :type list)))

(defmethod update ((manager scene-manager))
  (mapcar #'update (scene-objects manager)))
