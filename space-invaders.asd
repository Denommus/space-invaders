;;;; space-invaders.asd

(asdf:defsystem #:space-invaders
  :serial t
  :description "A Space Invaders clone in Common Lisp."
  :author "Yuri Albuquerque <yuridenommus@gmail.com>"
  :license "MIT License"
  :depends-on ("lispbuilder-sdl-gfx")
  :components ((:file "package")
               (:file "space-invaders")
               (:file "classes/scene-node")
               (:file "classes/enemy")
               (:file "classes/bullet")
               (:file "classes/player")
               (:file "classes/scene-manager")))
