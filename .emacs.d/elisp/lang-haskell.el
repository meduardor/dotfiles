;; haskell-mode configuration
;; https://github.com/haskell/haskell-mode
(use-package haskell-mode
  ;; haskell-mode swaps `C-m' and `C-j' behavior. Revert it back
  :bind (:map haskell-mode-map
              ("C-m" . newline)
              ("C-j" . electric-newline-and-maybe-indent))
  :config
  (defun my-haskell-mode-hook ()
    "Hook for `haskell-mode'."
    (set (make-local-variable 'company-backends)
         '((company-dante company-files))))
  (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
  (add-hook 'haskell-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)

  ;; intero-mode for a complete IDE solution to haskell
  ;; commercialhaskell.github.io/intero
  ;(use-package intero
  ; :config (add-hook 'haskell-mode-hook 'intero-mode))

  :config
  (use-package dante
    :ensure t
    :after haskell-mode
    :commands 'dante-mode
    :init
    (add-hook 'haskell-mode-hook 'flycheck-mode)
    ;; OR:
    ;; (add-hook 'haskell-mode-hook 'flymake-mode)
    (add-hook 'haskell-mode-hook 'dante-mode))

  (setq dante-repl-command-line-methods-alist
  `(
    (reflex . ,(lambda (root)
                   (when (directory-files root "reflex-platform" nil)
                     '("nix-shell" "-A" "shells.ghc" "--run" "cabal new-repl"))))

    (nix . ,(lambda (root)
              (dante-repl-by-file root '("shell.nix" "default.nix")
                                  '("nix-shell" "--run" (if dante-target (concat "cabal new-repl " dante-target) "cabal new-repl")))))
    (new-build . ,(lambda (root)
                    (when (or (directory-files root nil ".*\\.cabal$")
                              (file-exists-p "cabal.project"))
                      '("cabal" "new-repl" dante-target))))
    (bare  . ,(lambda (_) '("ghci" dante-target)))))

  ;; hindent - format haskell code automatically
  ;; https://github.com/chrisdone/hindent
  (when (executable-find "hindent")
    (use-package hindent
      :diminish hindent-mode
      :config
      (add-hook 'haskell-mode-hook #'hindent-mode)
      ;; reformat the buffer using hindent on save
      (setq hindent-reformat-buffer-on-save t))))

(provide 'lang-haskell)
