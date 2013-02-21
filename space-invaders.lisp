;;;; space-invaders.lisp

(in-package #:space-invaders)

(defun main ()
  (setf *default-pathname-defaults* (asdf:system-source-directory 'space-invaders))
  (sdl:with-init ()
    (sdl:window 800 600)
    (let ((ship1 (make-instance 'ship :image (sdl:load-image
                                              (merge-pathnames #p"assets/nave1.png")))))
      (draw ship1)
      (sdl:update-display)
      (sdl:with-events ()
        (:quit-event () t)
        (:video-expose-event () (sdl:update-display))))))
