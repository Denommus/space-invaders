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
    :initform #(1/5 1/5))))

(defmethod update ((this bullet))
  "Updates the bullet"
  (with-accessors ((pos pos) (scene-manager scene-manager)) this
    (setf pos (map 'vector #'+ pos #(0 -10)))
    (map nil (lambda (node)
               (when (collide-p this node)
                 (setf (scene-objects scene-manager)
                       (delete node (scene-objects scene-manager)))
                 (setf (scene-objects scene-manager)
                       (delete this (scene-objects scene-manager)))))
         (scene-objects scene-manager))
    (when (< (elt pos 1) 0)
      (setf (scene-objects scene-manager) (delete this (scene-objects scene-manager))))))

(defgeneric collide-p (bullet enemy)
  (:documentation "Tests collision between the bullet and an enemy"))

(defmethod collide-p ((bullet bullet) enemy)
  nil)

(defmethod collide-p ((bullet bullet) (enemy enemy))
  (< (reduce #'+ (map 'vector
                      (lambda (x y) (expt (- x y) 2))
                      (pos bullet)
                      (pos enemy)))
     500))
