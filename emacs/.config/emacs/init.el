;; -*- mode: elisp -*-

(menu-bar-mode     -1)
(toggle-scroll-bar -1)
(tool-bar-mode     -1)
(set-frame-font "DejaVu Sans Mono-14" nil t)


;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-starup nil)
(package-initialize)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode t)
(custom-set-variables
 '(custom-enabled-themes '(deeper-blue))
 '(package-selected-packages '(evil)))
(custom-set-faces)

;; Enable transient mark mode ??
(transient-mark-mode 1)

;;;; Org mode config
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
