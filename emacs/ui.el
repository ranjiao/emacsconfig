;; Put scroll bar at right side
(customize-set-variable 'scroll-bar-mode 'right)

;; setup modeline
(setq-default
 mode-line-format
 '(
   ;; buffer name
   " %b "
   ;; position
   "(%l,%c) "
   ;; char pos
   "(%p,"
   (:eval (number-to-string (point)))
   "/%i)"
   " "
   (:eval
    (cond (buffer-read-only
	   (propertize "RO" 'face 'mode-line-read-only-face))
	  ((buffer-modified-p)
	   (propertize "**" 'face 'mode-line-modified-face))
	  (t "    ")))
   (:eval
    (symbol-name
     (car (coding-system-priority-list))))
   " %["
   (:propertize mode-name)
   "%] "
   (global-mode-string global-mode-string)
   "%["
   (:propertize which-func-current)
   "%]"
   ))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)

(set-face-attribute 'mode-line-read-only-face nil
		    :inherit 'mode-line-face
		    :foreground "#4271ae"
		    :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
		    :inherit 'mode-line-face
		    :foreground "#c82829"
		    :background "#ffffff"
		                        :box '(:line-width 2 :color "#c82829"))
