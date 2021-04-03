;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; ui
(package! org-fancy-priorities)
(package! autothemer)
(package! chocolate :recipe (:local-repo "ui"))
(package! scroll-on-jump :recipe (:host gitlab :repo "ideasman42/emacs-scroll-on-jump"))

;; programming
(package! restclient)
(package! llvm-mode :recipe (:local-repo "lang/llvm"))
(package! promela-mode :recipe (:local-repo "lang/promela"))
(package! yaml-mode)

;; misc
(package! super-save)
(package! gif-screencast)
(package! dimmer)
