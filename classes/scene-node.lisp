;;;; classes/scene-node.lisp

(in-package #:space-invaders)

(defclass scene-node ()
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
    :type vector)
   (current-cell
    :accessor current-cell
    :initform 0
    :type integer)
   (animation-time
    :accessor animation-time
    :initform 0
    :type single-float)
   (scene-manager
    :accessor scene-manager
    :initform nil
    :type scene-manager)))

(defmethod initialize-instance :after ((this scene-node) &key cells)
  (with-slots (zoom image-with-zoom image) this
    (when image
      (when cells (setf (sdl:cells image) cells))
      (setf (zoom this) zoom))))

(defgeneric draw (this)
  (:documentation "Draws the node on the screen"))

(defgeneric update (this)
  (:documentation "Updates the node"))

(defmethod update :before ((this scene-node))
  "Makes sure the animation runs properly"
  (with-accessors ((animation-time animation-time) (cell current-cell) (image image-with-zoom)) this
    (incf animation-time 1/60)
    (when (> animation-time 1/20)
      (setf animation-time 0)
      (incf cell)
      (setf cell (mod cell (length (sdl:cells image)))))))

(defmethod draw ((this scene-node))
  "Draws the node on the screen"
  (with-accessors ((image image-with-zoom) (pos pos) (cell current-cell)) this
    (when image
      (let ((curr-cell (elt (sdl:cells image) cell)))
        (sdl:draw-surface-at
         image
         (map 'vector #'-
              pos (vector (round (/ (sdl:width curr-cell) 2))
                          (round (/ (sdl:height curr-cell) 2)))) :cell cell)))))

(defgeneric (setf zoom) (value this)
  (:documentation "Sets the zoom"))

(defmethod (setf zoom) (value (this scene-node))
  "Sets the zoom"
  (with-slots (image-with-zoom image) this
    (when image
      (setf image-with-zoom (sdl:zoom-surface (elt value 0) (elt value 1) :surface image))
      (with-accessors ((cells sdl:cells)) image
        (when cells
          (setf (sdl:cells image-with-zoom)
                (map 'vector
                     (lambda (cell)
		       (vector (round (* (sdl:x cell) (elt value 0)))
			       (round (* (sdl:y cell) (elt value 1)))
			       (round (* (sdl:width cell) (elt value 0)))
			       (round (* (sdl:height cell) (elt value 1)))))
                     cells)))))
    (setf (slot-value this 'zoom) value)))
