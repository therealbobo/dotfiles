;; -*- mode: elisp -*-

;; (menu-bar-mode     -3)
;;(toggle-scroll-bar -1)
(tool-bar-mode     -1)

;; (set-frame-font "DejaVu Sans Mono-14" t nil)
;;(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-14"))
(add-to-list 'default-frame-alist '(font . "Roboto Mono-14"))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

(transient-mark-mode 1)

(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; basic imports
(require 'cl-lib)
(require 'package)

;; setup sources
(setq package-archives
	  '(("melpa" . "https://melpa.org/packages/")
		("org" . "http://orgmode.org/elpa/")
		("gnu" . "http://elpa.gnu.org/packages/")
		))

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(package-initialize)

;;(use-package straight
;;  :ensure t
;;  )

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  )

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  )

(use-package recentf
  :config
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-items 25)
  (recentf-mode 1)
  )

(use-package nord-theme
  :ensure t
  :init
	(setq custom-safe-themes t)
	(setq solarized-use-variable-pitch nil
		  solarized-scale-org-headlines nil)
  :config
  (if (daemonp) 
	(add-hook 'after-make-frame-functions 
			  (lambda (frame) 
				(with-selected-frame frame (load-theme 'nord t)))) 
	(load-theme 'nord t))
  )

;; org mode config
(use-package org
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  :config
  (setq org-tags-column -70)
  (setq org-todo-keyword-faces
	'(("TODO"  . (:foreground "red" :weight bold))
	  ("NEXT"  . (:foreground "red" :weight bold))
	  ("DONE"  . (:foreground "forest green" :weight bold))
	  ("WAITING"  . (:foreground "orange" :weight bold))
	  ("CANCELLED"  . (:foreground "forest green" :weight bold))
	  ("SOMEDAY"  . (:foreground "orange" :weight bold))
	  ("OPEN"  . (:foreground "red" :weight bold))
	  ("CLOSED"  . (:foreground "forest green" :weight bold))
	  ("ONGOING"  . (:foreground "orange" :weight bold))))
  (setq org-todo-keywords
	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
	  (sequence "WAITING(w@/!)" "|" "CANCELLED(c!/!)")
	  (sequence "SOMEDAY(s!/!)" "|")
	  (sequence "OPEN(O!)" "|" "CLOSED(C!)")
	  (sequence "ONGOING(o)" "|")))
  (setq org-startup-with-inline-images t)
  )

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
			'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil)
  )

(use-package auctex
  :defer t
  :ensure t
  )

(use-package magit
  :ensure t
  )

(use-package markdown-mode
  :ensure t
  )

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1)
  )

(use-package yaml-mode
  :ensure t
  )

(use-package transpose-frame
  :ensure t
  )

(defun my/source-zshrc ()
  (interactive)
  (vterm-send-string "source ~/.zprofile\nsource ~/.config/zsh/.zshrc\nclear\n"))

(use-package vterm
  :ensure t
  :init
  (add-hook 'vterm-mode-hook #'my/source-zshrc )
  )

(use-package elfeed
  :ensure t
  :init
  (load "~/.config/emacs/elfeed") ;; load rss from another file
  :config
  (setq shr-width 80) ;; 80 columns in elfeed-show
  (setq-default elfeed-search-filter "@2-days-ago +unread")
  (setq-default elfeed-search-title-max-width 100)
  (setq-default elfeed-search-title-min-width 100)
  )

(use-package pdf-tools
   :ensure t
   :mode (("\\.pdf\\'" . pdf-view-mode))
   :config
   (pdf-tools-install :no-query))

(use-package ace-jump-mode
  :ensure t
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  )

(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))

(defun edit-config ()
   "Edit your init.el on fly."
   ;; body
   (find-file "~/.config/emacs/init.el")
   (interactive)
   )
