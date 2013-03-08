;;;; space-invaders.lisp

(in-package #:space-invaders)

(defun main ()
  (setf *default-pathname-defaults* (asdf:system-source-directory 'space-invaders))
  (sdl:with-init ()
    (sdl:window 800 600)
    (let ((ship1 (make-instance 'player
                                :zoom #(0.1 0.1)
                                :pos #(100 500)
                                :image (sdl:load-image
                                        (merge-pathnames #p"assets/nave.png")))))
      (sdl:update-display)
      (sdl:with-events ()
        (:quit-event () t)
        (:idle ()
               (update ship1)
               (sdl:clear-display sdl:*black*)
               (draw ship1)
               (sdl:update-display))))))
