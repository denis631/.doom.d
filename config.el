;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Dvorak mode
(define-key key-translation-map "\C-t" "\C-x")

;; UI
;; (load-theme 'chocolate)
(setq doom-theme 'doom-city-lights)

(custom-set-variables
 '(org-agenda-files '("~/Library/Mobile Documents/com~apple~CloudDocs/Notes/todo.org"))
 '(org-fontify-done-headline t))

(custom-set-faces
 '(default ((t (:height 150 :family "Ubuntu Mono derivative Powerline"))))
 '(variable-pitch ((t (:family "Avenir Next"))))

 ;; org-mode
 '(org-agenda-done ((t (:inherit org-done))))
 '(org-headline-done ((t (:foreground "alternatingContentBackgroundColor" :strike-through t))))
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))

 '(treemacs-root-face ((t (:inherit variable-pitch)))))

;; Rust
;;----
(use-package! toml-mode)
(use-package! rust-mode
  :hook (rust-mode . lsp))

(after! rustic
  (setq rustic-format-on-save t))

;; (mac-auto-operator-composition-mode)
;; Treemacs
;; --------
;; (use-package! treemacs
;;   :config
;;   (use-package! treemacs-evil
;;     :demand t)

;;   (use-package! treemacs-projectile
;;     :demand t)

;;   ;; Enable custom treemacs theme (all-the-icons must be installed!)
;;   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;   (doom-themes-treemacs-config)

;;   (treemacs-follow-mode t)
;;   (treemacs-filewatch-mode t)
;;   (treemacs-git-mode 'deferred)
;;   (treemacs-toggle-fixed-width)

;;   (setq treemacs-width 35
;;         treemacs-git-integration t
;;         treemacs-never-persist nil
;;         treemacs-goto-tag-strategy 'refresh-index
;;         treemacs-sorting 'alphabetic-desc
;;         treemacs-display-in-side-window t
;;         treemacs-indentation-string (propertize " " 'face 'font-lock-comment-face)
;;         treemacs-indentation 1))

;; Org Mode
;; --------
;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
(setq doom-scratch-buffer-major-mode 'org-mode)

(after! org-fancy-priorities
  (setq org-lowest-priority 68)
  (setq org-priority-faces
        '((?A . error)
          (?B . warning)
          (?C . success)
          (?D . success)))
  (setq org-fancy-priorities-list '("ASAP" "SOON" "NO PRESSURE" "MAYBE")))

(after! org
  ;; org-bullets
  (setq org-bullets-bullet-list '("•"))

  (setq org-directory "~/Library/Mobile Documents/com~apple~CloudDocs/Notes/")
  ;; org-capture
  (setq private-todo-path (concat org-directory "todo.org")
        private-notes-path (concat org-directory "note.org")
        work-todo-path (concat org-directory "work-todo.org")
        work-journal-path (concat org-directory "work-journal.org"))

  (setq org-capture-templates
        '(("t" "Templates for private todos")
         ("tt" "Todo" entry (file+headline private-todo-path "Inbox")
           "* [ ] %?")
          ("tl" "Todo with Link" entry (file+headline private-todo-path "Inbox")
           "* [ ] %?\n%a")
          ("n" "Note" entry (file+headline private-notes-path "Notes")
           "* NOTE %?")

          ;; define work prefix/group
          ("w" "Templates for work")
          ("wt" "Work todo" entry (file+headline work-todo-path "Tasks")
           "* [ ] %?")
          ("wl" "Work todo with link" entry (file+headline work-todo-path "Tasks")
           "* [ ] %?\n%a")
          ("wq" "Work question" entry (file+headline work-todo-path "Tasks")
           "* [?] %?")
          ("wql" "Work question with link" entry (file+headline work-todo-path "Tasks")
           "* [?] %?\n%a")
          ("wj" "Work Journal" entry (file+datetree work-journal-path)
           "* %U %?\n%i\n"))))

;; remove red highlighting after 80 chars
(delq! 'lines-tail whitespace-style)

(add-hook! org-mode
  (setq! prettify-symbols-alist '(("[ ]" . ?☐) ("[X]" . ?☑) ("[-]" . ?❍)))
  (prettify-symbols-mode)
  (org-bullets-mode))

;; NAVIGATION
;; counsel
(after! counsel
  (add-to-list 'ivy-update-fns-alist '(counsel-imenu . auto))
  (add-to-list 'ivy-update-fns-alist '(counsel-rg . auto))
  (advice-add #'counsel-imenu :around #'doom-set-jump-a)
  (advice-add #'counsel-rg :around #'doom-set-jump-a)
  (map! "C-x b" #'counsel-switch-buffer))

;; avy
(after! avy
  (setq avy-all-windows t)
  (map! :leader
        :desc "Jump to char"
        "/ c"
        #'avy-goto-char-timer))

(use-package! frog-jump-buffer
  :config
  (setq frog-jump-buffer-include-current-buffer nil)
  (map! :leader
        :desc "Frog-Jump to buffer"
        "b j"
        #'frog-jump-buffer))

(use-package! super-save
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

(after! vterm
  (map! :map vterm-mode-map "C-c C-x" #'vterm--self-insert)
  (map! :map vterm-mode-map "C-c y" #'vterm--self-insert)
  (map! :map vterm-mode-map "C-c n" #'vterm--self-insert)
  (map! :map vterm-mode-map "C-c RET" #'vterm--self-insert ))
