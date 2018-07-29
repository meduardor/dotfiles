;;Configurações Globais 
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-default 'cursor-type 'hbar)
(ido-mode)
(column-number-mode 1)
(show-paren-mode)
(global-hl-line-mode -1)
(winner-mode t)
;(global-linum-mode 1)
(global-display-line-numbers-mode)
(global-font-lock-mode 1)

;;Repositorios lisp

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(add-to-list 'package-archives
             '( "melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives
	     '("maramalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))


(package-initialize)
;; Python
(elpy-enable)
;(elpy-use-ipython)
;(elpy-clean-modeline)
;;Flycheck
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;Elpy definição de regras
(defun elpy-goto-definition-or-rgrep ()
  "Go to the definition of the symbol at point, if found. Otherwise, run `elpy-rgrep-symbol'."
    (interactive)
    (ring-insert find-tag-marker-ring (point-marker))
    (condition-case nil (elpy-goto-definition)
        (error (elpy-rgrep-symbol
                (concat "\\(def\\|class\\)\s" (thing-at-point 'symbol) "(")))))
;;Interpretador
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")
;; enable autopep8 formatting on save
;(require 'py-autopep8)
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)



;;Web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\djhtml\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)
(setq web-mode-enable-auto-closing t)
(setq web-mode-enable-auto-quoting t)
;; Latex - AucTex
(load "auctex.el" nil t t)
    (require 'tex-mik)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;(setq TeX-PDF-mode t)
(require 'tex)
(TeX-global-PDF-mode t)
;; enable org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(setq org-log-done t)
;;MarkDown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;;Anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)
;;Company-mode
(add-hook 'after-init-hook 'global-company-mode)
;;Company-Anaconda
(eval-after-load "company"
  '(add-to-list 'company-backends 'company-anaconda))
;;Ferramentas para PDF 
(pdf-tools-install)
;; Configuração de Multiplos cursores 
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;Plugins Padrões
(autopair-global-mode)
(powerline-center-theme)
(setq powerline-default-separator 'arrow-fade)




(custom-set-variables
x ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-term-color-vector
   [unspecified "#fbf1c7" "#9d0006" "#79740e" "#b57614" "#076678" "#8f3f71" "#076678" "#504945"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "d83e34e28680f2ed99fe50fea79f441ca3fddd90167a72b796455e791c90dc49" default)))
 '(global-display-line-numbers-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (spacemacs-theme base16-theme powerline autopair multiple-cursors pdf-tools company-anaconda anaconda-mode markdown-mode org-ac org-edit-latex org-link-minor-mode flycheck elpy web-mode auctex)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "BitstreamVeraSansMono Nerd Font Mono" :foundry "Bits" :slant normal :weight normal :height 113 :width normal)))))
