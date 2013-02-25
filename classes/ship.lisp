;;;; classes/ship.lisp

(in-package #:space-invaders)

(defclass ship ()
  ((pos
    :initarg :pos
    :accessor pos
    :initform #(0 0))
   (image
    :initarg :image
    :reader image
    :initform nil)
   (image-with-zoom
    :reader image-with-zoom
    :initform nil)
   (zoom
    :initarg :zoom
    :reader zoom
    :initform #(1 1))))

(defmethod initialize-instance :after ((this ship) &key)
  (with-slots (zoom image-with-zoom image) this
    (when image
      (setf image-with-zoom (sdl:zoom-surface (elt zoom 0) (elt zoom 1) :surface image)))))

(defgeneric draw (this)
  (:documentation "Draws the ship on the screen"))

(defgeneric update (this)
  (:documentation "Updates the ship"))

(defmethod draw ((this ship))
  "Draws the ship on the screen"
  (with-accessors ((image image-with-zoom) (pos pos)) this
    (when image
      (sdl:draw-surface-at-* image (elt pos 0) (elt pos 1)))))
