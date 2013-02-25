;;;; player.lisp

(in-package #:space-invaders)

(defclass player (ship) ())

(defmethod update ((this player))
  "Updates the player"
  (when (sdl:key-down-p :sdl-key-d)
    (incf (elt (pos this) 0) 20))
  (when (sdl:key-down-p :sdl-key-a)
    (decf (elt (pos this) 0) 20)))
