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
