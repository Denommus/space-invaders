;;;; classes/ship.lisp

(in-package #:space-invaders)

(defclass ship ()
  ((pos
    :initarg :pos
    :accessor pos
    :initform #(0 0)
    :type vector)
   (image
    :initarg :image
    :reader image
    :initform nil
    :type sdl:surface)
   (image-with-zoom
    :reader image-with-zoom
    :initform nil
    :type sdl:surface)
   (zoom
    :initarg :zoom
    :reader zoom
    :initform #(1 1)
    :type vector)))

(defmethod initialize-instance :after ((this ship) &key cells)
  (with-slots (zoom image-with-zoom image) this
    (when image
      (when cells (setf (sdl:cells image) cells))
      (setf image-with-zoom (sdl:zoom-surface (elt zoom 0) (elt zoom 1) :surface image))
      (when cells
        (setf (sdl:cells image-with-zoom)
              (map 'vector
                   #'(lambda (cell)
                       (vector (round (* (elt cell 0) (elt zoom 0)))
                               (round (* (elt cell 1) (elt zoom 1)))
                               (round (* (elt cell 2) (elt zoom 0)))
                               (round (* (elt cell 3) (elt zoom 1)))))
                   cells))))))

(defgeneric draw (this)
  (:documentation "Draws the ship on the screen"))

(defgeneric update (this)
  (:documentation "Updates the ship"))

(defmethod draw ((this ship))
  "Draws the ship on the screen"
  (with-accessors ((image image-with-zoom) (pos pos)) this
    (when image
      (sdl:draw-surface-at image pos :cell 0))))

(defgeneric (setf zoom) (value this)
  (:documentation "Sets the zoom"))

(defmethod (setf zoom) (value (this ship))
  "Sets the zoom"
  (with-slots (image-with-zoom image) this
    (when image
      (sdl:zoom-surface (elt zoom 0) (elt zoom 1) :surface image))
    (setf (slot-value this 'zoom) this)))
