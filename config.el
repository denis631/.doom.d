;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Dvorak mode
(define-key key-translation-map "\C-t" "\C-x")

;; UI
;; (load-theme 'chocolate)
(setq doom-theme 'doom-nord
      doom-font (font-spec :family "Ubuntu Mono derivative Powerline" :size 16)
      display-line-numbers-type 'relative)

(custom-set-faces
 ;; org-mode
 '(org-agenda-done ((t (:inherit org-done))))
 '(org-headline-done ((t (:foreground "alternatingContentBackgroundColor" :strike-through t))))
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))

;; Rust
;;----
(use-package! toml-mode)
(use-package! rust-mode
  :hook (rust-mode . lsp))

(after! rustic
  (setq rustic-format-on-save t))

;; Go
;; --
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

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
  (setq org-fontify-done-headline t)

  (setq org-tags-column -120)

  ;; workflow
  (setq org-todo-keywords '((sequence "PROJ(P)" "|" "DONE(d)") ;; project
                            ;; (sequence "TODO(t)" "|" "IN PROGRESS(p)" "|" "DONE(d)") ;; items in scrum sprint
                            (sequence "[ ](T)" "[?](Q)" "|" "[X](D)"))) ;; simple todos

  ;; org-bullets
  (setq org-bullets-bullet-list '("•"))

  (setq org-directory "~/Library/Mobile Documents/com~apple~CloudDocs/Notes/")
  ;; org-capture
  (setq private-todo-path (concat org-directory "todo.org")
        private-notes-path (concat org-directory "note.org")
        work-todo-path (concat org-directory "work-todo.org")
        work-journal-path (concat org-directory "work-journal.org"))

  (setq org-agenda-files (list private-todo-path))

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
