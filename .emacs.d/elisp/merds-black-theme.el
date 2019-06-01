;; Maintainer: Marco Eduardo <meduardo.r@protomail.com>
;; Last Change: 31 May 2019

;; Code:
(deftheme merds-black
  "merds-black-theme")


(custom-theme-set-faces
 'merds-black
 
 '(default ((t (:background "black" :foreground "Grey"))))
 '(mouse ((t (:foregound "#808080"))))
 '(fringe ((t (:background "black" :foreground "Khakil"))))
 '(cursor ((t (:foregound "#808080"))))
 '(border ((t (:foregound "black"))))


 '(mode-line ((t (:background "black" :foreground "GreenYellow"))))
 '(Man-overstrike-face ((t (:weight bold))))
 '(Man-underline-face ((t (:underline t))))
 '(apropos-keybinding-face ((t (:underline t))))
 '(apropos-label-face ((t (:italic t))))

 '(font-lock-type-face ((t (:foreground "DodgerBlue1"))))
 '(font-lock-comment-face ((t (:foreground "DarkGreen"))))
 '(font-lock-function-name-face ((t (:foreground "Darkgoldenrod"))))
 '(font-lock-keyword-face ((t (:weight bold :foreground "DarkRed"))))
 '(font-lock-string-face ((t (:foreground "RoyalBlue1"))))
 '(font-lock-variable-name-face ((t (:foreground "#af5f5f"))))
 '(font-lock-builtin-face ((t (:foreground "Gold3"))))
 '(font-lock-constant-face ((t (:foreground "Magenta3")))) 
;;NOTE:variable-face Darkorange3
 '(region ((t (:background "SteelBlue"))))
 '(secondary-selection ((t (:background "dodger blue"))))
 
 '(mouse ((t (:foregound "Wheat4"))))
 '(highlight ((t (:background "Red" :foreground "DarkOrange3"))))
 '(show-paren-match-face ((t (:background "DarkViolet" :foreground "DarkCyan"))))
 '(show-paren-mismatch-face ((t (:background "purple" :foreground "Magenta3"))))
 '(cursor ((t (:background "Red3")))))

 '(linum ((t (:background "black" :foreground "Yellow"))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'merds-black)
;;; merds-black-theme.el ends here
