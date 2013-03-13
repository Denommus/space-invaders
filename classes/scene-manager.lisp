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

(defmethod initialize-instance :after ((this scene-manager) &key)
  (mapcar #'(lambda(x) (setf (scene-manager x) this)) (scene-objects this)))

(defmethod update ((manager scene-manager))
  (mapcar #'update (scene-objects manager)))

(defmethod draw ((manager scene-manager))
  (mapcar #'draw (scene-objects manager)))

(defgeneric add-scene-object (scene object)
  (:documentation "Adds a scene-object in the scene"))

(defmethod add-scene-object ((scene scene-manager) (object scene-node))
  "Adds a scene-object in the scene"
  (with-accessors ((scene-objects scene-objects)) scene
    (setf (scene-manager object) scene)
    (setf scene-objects (concatenate 'list (list object) scene-objects))))
