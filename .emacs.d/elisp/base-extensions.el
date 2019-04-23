
(use-package avy
  :bind
  ("C-c SPC" . avy-goto-char))


(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOPATH")
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled))

(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-m" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x c k" . counsel-yank-pop))

(use-package counsel-projectile
  :bind
  ("C-x v" . counsel-projectile)
  ("C-x c p" . counsel-projectile-ag)
  :config
  (counsel-projectile-on))

(use-package ivy
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))


(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :config

  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package neotree
  :config
  (setq neo-theme 'arrow
        neotree-smart-optn t
        neo-window-fixed-size nil)
  ;; Disable linum for neotree
  (add-hook 'neo-after-create-hook 'disable-neotree-hook))

(use-package org
  :config
  (setq org-directory "~/Dropbox/Documents/Org"
        org-default-notes-file (concat org-directory "/Org"))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(use-package org-projectile
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "Org"
	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(use-package page-break-lines)

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  (setq projectile-completion-system 'ivy)

  (projectile-global-mode))

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens
    :config
    (smartparens-global-mode 1))

(use-package smex)

(use-package undo-tree
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))

(use-package wgrep)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package all-the-icons)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))


(use-package prog-mode
  :ensure nil
  :hook ((haskell-mode . prettify-symbols-haskell)
	 (prog-mode . prettify-symbols-mode)
         (lisp-mode . prettify-symbols-lisp)
         (c-mode . prettify-symbols-c)
         (c++-mode . prettify-symbols-c++)
         ((js-mode js2-mode) . prettify-symbols-js)
         (prog-mode . (lambda ()
           (setq-local scroll-margin 3))))
  :preface
  (defun prettify-symbols-prog ()
    (push '("<=" . ?≤) prettify-symbols-alist)
    (push '(">=" . ?≥) prettify-symbols-alist))
  (defun prettify-symbols-lisp ()
    (push '("/=" . ?≠) prettify-symbols-alist)
    (push '("sqrt" . ?√) prettify-symbols-alist)
    (push '("not" . ?¬) prettify-symbols-alist)
    (push '("and" . ?∧) prettify-symbols-alist)
    (push '("or" . ?∨) prettify-symbols-alist))
  (defun prettify-symbols-c ()
    (push '("<=" . ?≤) prettify-symbols-alist)
    (push '(">=" . ?≥) prettify-symbols-alist)
    (push '("!=" . ?≠) prettify-symbols-alist)
    (push '("&&" . ?∧) prettify-symbols-alist)
    (push '("||" . ?∨) prettify-symbols-alist)
    (push '(">>" . ?») prettify-symbols-alist)
    (push '("<<" . ?«) prettify-symbols-alist))
  (defun prettify-symbols-c++ ()
    (push '("<=" . ?≤) prettify-symbols-alist)
    (push '(">=" . ?≥) prettify-symbols-alist)
    (push '("!=" . ?≠) prettify-symbols-alist)
    (push '("&&" . ?∧) prettify-symbols-alist)
    (push '("||" . ?∨) prettify-symbols-alist)
    (push '(">>" . ?») prettify-symbols-alist)
    (push '("<<" . ?«) prettify-symbols-alist)
    (push '("->" . ?→) prettify-symbols-alist))
  (defun prettify-symbols-js ()
    (push '("function" . ?λ) prettify-symbols-alist)
    (push '("=>" . ?⇒) prettify-symbols-alist)))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package nix-buffer
  :commands nix-buffer)

(use-package markdown-mode
  :mode
  (("\\.md\\'" . gfm-mode)
   ("\\.markdown\\'" . gfm-mode))
   :config
   (bind-key "'" "´" markdown-mode-map
	     (not (or (markdown-code-at-point-p)
		      (memp 'markdown-pre-face
			    (face-at-point nil 'mult))))))
;(use-package whitespace
; :ensure nil
; :config
; (defun rc/turn-on-whitespace-mode ()
;   (interactive)
;   (whitespace-mode 1))
; (defun rc/delete-trailing-whitespace-on-save()
;   (interactive)
;   (add-to-list 'write-file-functions 'delete-trailing-whitespace))
; (defun rc/set-up-whitespace-handling ()
;   (interactive)
;   (rc/turn-on-whitespace-mode)
;   (rc/delete-trailing-whitespace-on-save))
; (custom-set-variables
;  '(whitespace-style (quote (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))))
; (let ((whitespace-enable-modes
;	'(
;	  tuareg-mode-hook
;	  c++-mode-hook
;	  emacs-lisp-mode
;	  c-mode-hook
;	  java-mode-hook
;	  lua-mode-hook
;	  rust-mode-hook
;	  scala-mode-hook
;	  python-mode-hook
;	  haskell-mode-hook
;	  js2-mode-hook
;	  go-mode-hook
;	  markdown-mode-hook)))
;   (dolist (mode whitespace-enable-modes)
;	     (add-hook mode 'rc/set-up-whitespace-handling))))

(provide 'base-extensions)
