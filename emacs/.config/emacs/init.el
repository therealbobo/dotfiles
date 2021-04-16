;; -*- mode: elisp -*-

;(menu-bar-mode     -3)
(toggle-scroll-bar -1)
(tool-bar-mode     -1)
(global-display-line-numbers-mode)
;(setq display-line-numbers 'relative)
(setq display-line-numbers-type 'relative) 


(set-frame-font "DejaVu Sans Mono-14" t)

;; basic imports
(require 'cl-lib)
(require 'package)

;; setup sources
(setq package-archives
	  '(("melpa" . "https://melpa.org/packages/")
		("org" . "http://orgmode.org/elpa/")
		("gnu" . "http://elpa.gnu.org/packages/")
))

(defvar my-packages
  '(
	auctex
	evil
	magit
	markdown-mode
	org
	solarized-theme
	undo-tree
	volatile-highlights
	vterm
	yaml-mode
	)
  "A list of packages to ensure are installed at launch.")

(defun install-my-packages()
  (cl-loop for p in my-packages
        when (not (package-installed-p p))
			do (cl-return nil)
        finally (cl-return t)))

(unless (install-my-packages)
  (package-refresh-contents)
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))


(package-initialize)



;; enable evil
(require 'evil)
(evil-mode t)

;; enable solarized theme
(require 'solarized-theme)
(setq custom-safe-themes t)
(setq solarized-use-variable-pitch nil
      solarized-scale-org-headlines nil)
(load-theme 'solarized-dark t)
(add-hook 'after-init-hook (lambda () (load-theme 'solarized-dark)))

;; ??
(transient-mark-mode 1)

;; org mode config
(require 'org)
(setq org-tags-column -70)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; tex mode config
;;(add-to-list 'auto-mode-alist '("\\.tex$" . auto-fill-mode))

(require 'volatile-highlights)
(volatile-highlights-mode t)
(vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
                      'evil-paste-pop 'evil-move)
(vhl/install-extension 'evil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(undo-tree yari yaml-mode volatile-highlights solarized-theme org magit evil auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
