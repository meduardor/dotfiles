;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Python
(elpy-enable)
;(elpy-use-ipython)

;;Company-mode
(add-hook 'after-init-hook 'global-company-mode)
;;Company-Anaconda
(eval-after-load "company"
 '(add-to-list 'company-backends 'company-anaconda))

;;Anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)

;;Plugins Padrões
(autopair-global-mode)
(powerline-center-theme)
(setq powerline-default-separator 'arrow-fade)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; enable org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(setq org-log-done t)

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

;;Ferramentas para PDF 
(pdf-tools-install)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(ansi-term-color-vector
   [unspecified "#000000" "#dd0907" "#1fb714" "#fbf305" "#0000d3" "#4700a5" "#0000d3" "#c0c0c0"])
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (gruvbox-dark-soft)))
 '(custom-safe-themes
   (quote
    ("ed2b5df51c3e1f99207074f8a80beeb61757ab18970e43d57dec34fe21af2433" "8a6f10b3269c42c351776ee32c7ee755472dee4ecdf2177dcbf64d5e02d1ab64" "d96587ec2c7bf278269b8ec2b800c7d9af9e22d816827639b332b0e613314dfd" "0c3b1358ea01895e56d1c0193f72559449462e5952bded28c81a8e09b53f103f" "d83e34e28680f2ed99fe50fea79f441ca3fddd90167a72b796455e791c90dc49" "5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" "eea01f540a0f3bc7c755410ea146943688c4e29bea74a29568635670ab22f9bc" default)))
 '(elpy-syntax-check-command
   "~/.local/lib/python3.6/site-packages/flake8-3.5.0-py3.6.egg/flak8")
 '(fci-rule-color "#3C3D37")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (gruvbox-theme badwolf-theme base16-theme company-anaconda anaconda-mode pdf-tools multiple-cursors org-ac org markdown-mode ein elpy jedi monokai-theme monokai-alt-theme exwm auctex js2-mode python html5-schema)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(python-shell-completion-native-disabled-interpreters (quote ("pypy" "ipython")))
 '(python-shell-completion-native-enable nil)
 '(setq inhibit-startup-message t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "BitstreamVeraSansMono Nerd Font Mono" :foundry "Bits" :slant normal :weight bold :height 128 :width normal)))))
;;Repositorios de Packages 
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))

(add-to-list 'package-archives
             '( "melpa" . "http://melpa.milkbox.net/packages/"))

(add-to-list 'package-archives
	     '("maramalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))

;;Transparencia 
;(require 'alpha)


;; Configuração de Multiplos cursores 
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
