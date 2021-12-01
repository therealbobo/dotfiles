;; -*- mode: elisp -*-

;;(menu-bar-mode     -3)
;;(toggle-scroll-bar -1)
(tool-bar-mode -1)

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-14"))
(add-to-list 'default-frame-alist '(font . "Roboto Mono-14"))

(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

(transient-mark-mode 1)

(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;; keep emacs.d clean
(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      url-history-file (expand-file-name "url/history" user-emacs-directory)
      )

;; backups
(setq
 backup-by-copying t
 backup-directory-alist '(("." . "~/.cache/emacs/backups/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 )

;; custom file in a temporary file
(setq custom-file (if (boundp 'server-socket-dir)
		      (expand-file-name "custom.el" server-socket-dir)
		    (expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)
		    )
      )
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file t)

(defun edit-config ()
  "Edit your init.el on fly."
  ;; body
  (find-file "~/.config/emacs/init.el")
  (interactive)
  )

(defun reload-config ()
  "Reload your init.el on fly."
  ;; body
  (load-file "~/.config/emacs/init.el")
  (interactive)
  )


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

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t)
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
  (setq recentf-max-menu-items 25
	recentf-max-saved-items 25)
  (recentf-mode 1)
  )

(use-package nord-theme
  :ensure t
  :init
  (setq custom-safe-themes t
	solarized-use-variable-pitch nil
	solarized-scale-org-headlines nil)
  :config
  (if (daemonp) 
      (add-hook 'after-make-frame-functions 
		(lambda (frame) 
		  (with-selected-frame frame (load-theme 'nord t)))) 
    (load-theme 'nord t)
    )
  )

(use-package org
  :pin gnu
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  :config
  (setq org-format-latex-options
	(plist-put org-format-latex-options :scale 2.0)
	)

  ;;(setq org-tags-column -70
  ;;	org-todo-keyword-faces
  ;;	'(("TODO"  . (:foreground "red" :weight bold))
  ;;	  ("NEXT"  . (:foreground "red" :weight bold))
  ;;	  ("DONE"  . (:foreground "forest green" :weight bold))
  ;;	  ("WAITING"  . (:foreground "orange" :weight bold))
  ;;	  ("CANCELLED"  . (:foreground "forest green" :weight bold))
  ;;	  ("SOMEDAY"  . (:foreground "orange" :weight bold))
  ;;	  ("OPEN"  . (:foreground "red" :weight bold))
  ;;	  ("CLOSED"  . (:foreground "forest green" :weight bold))
  ;;	  ("ONGOING"  . (:foreground "orange" :weight bold)))
  ;;	org-todo-keywords
  ;;	'((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
  ;;	  (sequence "WAITING(w@/!)" "|" "CANCELLED(c!/!)")
  ;;	  (sequence "SOMEDAY(s!/!)" "|")
  ;;	  (sequence "OPEN(O!)" "|" "CLOSED(C!)")
  ;;	  (sequence "ONGOING(o)" "|")
  ;;	  org-startup-with-inline-images t
  ;;	  )
  ;;	)
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

(use-package vterm
  :ensure t
  :init
  ;;(add-hook 'vterm-mode-hook #'my/source-zshrc )
  )

(use-package elfeed
  :ensure t
  :init
  (when (file-exists-p "~/.config/emacs/elfeed")
    (load "~/.config/emacs/elfeed") ;; load rss from another file
    )
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

(use-package epresent
  :ensure t
  )

(use-package all-the-icons
  :ensure t
  )

(defun aorst/font-installed-p (font-name)
  "Check if font with FONT-NAME is available."
  (if (find-font (font-spec :name font-name))
      t
    nil))

(use-package all-the-icons
  :ensure t
  :config
  (when (and (not (aorst/font-installed-p "all-the-icons"))
	     (window-system))
    (all-the-icons-install-fonts t))
  )

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  )

(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
			     (org-bullets-mode 1)))
  )

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

(use-package company
  :ensure t
  )

(use-package telega
  :ensure t
  :init
  (setq telega-use-images t
	telega-emoji-font-family "Noto Color Emoji"
	telega-emoji-use-images "Noto Color Emoji"
	telega-user-show-avatars t
	telega-root-show-avatars t
	telega-temp-dir "/tmp/telega"
	telega-directory (expand-file-name "~/.local/share/telega")
	telega-database-directory (expand-file-name "~/.local/share/telega")
	)
  (telega-notifications-mode 1)
  (define-key global-map (kbd "C-x t g") 'telega)
  :commands (telega)
  :defer t
  )

(use-package helm
  :ensure t
  :demand
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-buffers-list)
	 ("C-x c o" . helm-occur))
  ("M-y" . helm-show-kill-ring)
  ("C-x r b" . helm-filtered-bookmarks)
  ;;:preface (require 'helm-config)
  :config
  (setq helm-split-window-in-side-p t)
  (helm-mode 1)
  )

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  )

(use-package ace-window
  :ensure t
  :config
  (define-key global-map (kbd "M-o") 'ace-window)
  (define-key global-map (kbd "M-s") 'ace-swap-window)
  (setq aw-keys '(?h ?j ?k ?l ?a ?s ?d ?f ?g))
  )

(add-to-list 'org-file-apps '("\\.pdf\\'" . emacs))
