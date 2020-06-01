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

;; navigation
(package! frog-jump-buffer)

;; programming
(package! toml-mode)
(package! thrift)
(package! restclient)
(package! llvm-mode :recipe (:local-repo "lang/llvm"))

;; misc
(package! super-save)
(package! gif-screencast)
(package! dimmer)
