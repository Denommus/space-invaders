;;;; scene-manager.lisp

(in-package #:space-invaders)

(defclass scene-manager ()
  ((scene-objects
    :initarg :scene-objects
    :accessor scene-objects
    :initform (list
               (make-instance 'player
                              :cells #(#(0 0 382 330)
                                       #(382 0 382 330)
                                       #(764 0 382 330))))
    :type list)))

(defmethod update ((manager scene-manager))
  (mapcar #'update (scene-objects manager)))

(defmethod draw ((manager scene-manager))
  (mapcar #'draw (scene-objects manager)))
