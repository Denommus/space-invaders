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
    :type list)
   (time-next-enemy
    :accessor time-next-enemy
    :initform 1)))

(defmethod initialize-instance :after ((this scene-manager) &key)
  (map nil (lambda(x) (setf (scene-manager x) this)) (scene-objects this)))

(defmethod update ((manager scene-manager))
  (decf (time-next-enemy manager) 1/60)
  (when (< (time-next-enemy manager) 0)
    (setf (time-next-enemy manager) 1)
    (add-scene-object manager (make-instance 'enemy
                                             :cells #(#(0 0 382 330))
                                             :pos (vector (random 801) 0))))
  (map nil #'update (scene-objects manager)))

(defmethod draw ((manager scene-manager))
  (map nil #'draw (scene-objects manager)))

(defgeneric add-scene-object (scene object)
  (:documentation "Adds a scene-object in the scene"))

(defmethod add-scene-object ((scene scene-manager) (object scene-node))
  "Adds a scene-object in the scene"
  (with-accessors ((scene-objects scene-objects)) scene
    (setf (scene-manager object) scene)
    (push object scene-objects)))
