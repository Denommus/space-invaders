;;;; space-invaders.lisp

(in-package #:space-invaders)

(defun main ()
  (setf *default-pathname-defaults* (asdf:system-source-directory 'space-invaders))
  (sdl:with-init ()
    (sdl:window 800 600)
    (let ((scene (make-instance 'scene-manager)))
      (sdl:update-display)
      (sdl:with-events ()
        (:quit-event () t)
        (:idle ()
               (update scene)
               (sdl:clear-display sdl:*black*)
               (draw scene)
               (sdl:update-display))))))
