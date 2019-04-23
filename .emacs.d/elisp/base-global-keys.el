;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])
(global-set-key (kbd "<C-tab>") 'other-window)

(global-set-key (kbd "M-<left>") 'windmove-left)          ; move to left window
(global-set-key (kbd "M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "M-<down>") 'windmove-down)          ; move to lower window

(global-set-key (kbd "C-~") 'next-buffer)
(global-set-key (kbd "C-´") 'previous-buffer)

(provide 'base-global-keys)
