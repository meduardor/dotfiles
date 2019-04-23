(use-package elm-mode
  :config
  (add-hook 'elm-mode-hook (lambda ()
			     (set (make-local-variable 'company-backends '(company-elm))(company-mode))))
  (add-hook 'elm-mode-hook 'elm-format-on-save))

(provide 'lang-elm)
