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
	("gnu" . "http://elpa.gnu.org/packages/")
	)
      )

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package)
  )

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
  )

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil 'evil-paste-after 'evil-paste-before
			'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil)
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
  (undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  )

(use-package yaml-mode
  :ensure t
  )

(use-package transpose-frame
  :ensure t
  )

(use-package ace-jump-mode
  :ensure t
  :config
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
  )

(use-package epresent
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

;; optional package to get the error squiggles as you edit
(use-package flycheck
  :ensure t
  )

;; if you use company-mode for completion (otherwise, complete-at-point works out of the box):
(use-package company-lsp
  :ensure t
  :commands company-lsp
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

(use-package helm-gtags
  :ensure t
  :init
  (add-hook 'c++-mode-hook 'helm-gtags-mode)
  (add-hook 'c-mode-hook 'helm-gtags-mode)
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

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :config
  (defun my/go-mode-setup ()
    "Basic Go mode setup."
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'my/go-mode-setup)
  )

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-mode lsp-deferred)
  :hook ((rust-mode python-mode go-mode) . lsp-deferred)
  :config
  (setq lsp-prefer-flymake nil
	lsp-enable-indentation nil
	lsp-enable-on-type-formatting nil
	lsp-rust-server 'rust-analyzer)
  ;; for filling args placeholders upon function completion candidate selection
  ;; lsp-enable-snippet and company-lsp-enable-snippet should be nil with
  ;; yas-minor-mode is enabled: https://emacs.stackexchange.com/q/53104
  (lsp-modeline-code-actions-mode)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (add-to-list 'lsp-file-watch-ignored "\\.vscode\\'")
  )

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  )

(use-package neotree
  :ensure t
  :bind (("<f2>" . neotree-toggle))
  :defer
  :config
  (evil-set-initial-state 'neotree-mode 'normal)
  (evil-define-key 'normal neotree-mode-map
    (kbd "RET") 'neotree-enter
    (kbd "c")   'neotree-create-node
    (kbd "r")   'neotree-rename-node
    (kbd "d")   'neotree-delete-node
    (kbd "j")   'neotree-next-node
    (kbd "k")   'neotree-previous-node
    (kbd "g")   'neotree-refresh
    (kbd "C")   'neotree-change-root
    (kbd "I")   'neotree-hidden-file-toggle
    (kbd "H")   'neotree-hidden-file-toggle
    (kbd "q")   'neotree-hide
    (kbd "l")   'neotree-enter
    )
  )
