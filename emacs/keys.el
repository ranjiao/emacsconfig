;; dumb jump
(global-set-key [f5] 'dumb-jump-go)
(global-set-key [f6] 'dumb-jump-back)

;; Go to line
(define-key global-map (kbd "C-c g") 'goto-line)

;; Windows Cycling
(defun windmove-up-cycle()
  (interactive)
  (condition-case nil (windmove-up)
    (error (condition-case nil (windmove-down)
	     (error (condition-case nil (windmove-right)
		      (error (condition-case nil (windmove-left)
			       (error (windmove-up))))))))))

(defun windmove-down-cycle()
  (interactive)
  (condition-case nil (windmove-down)
    (error (condition-case nil (windmove-up)
	     (error (condition-case nil (windmove-left)
		      (error (condition-case nil (windmove-right)
			       (error (windmove-down))))))))))

(defun windmove-right-cycle()
  (interactive)
  (condition-case nil (windmove-right)
    (error (condition-case nil (windmove-left)
	     (error (condition-case nil (windmove-up)
		      (error (condition-case nil (windmove-down)
			       (error (windmove-right))))))))))

(defun windmove-left-cycle()
  (interactive)
  (condition-case nil (windmove-left)
    (error (condition-case nil (windmove-right)
	     (error (condition-case nil (windmove-down)
		      (error (condition-case nil (windmove-up)
			       (error (windmove-left))))))))))

;; keys like M-<up> doesn't work in ssh and org mode
(global-set-key (kbd "C-x <up>") 'windmove-up-cycle)
(global-set-key (kbd "C-x <down>") 'windmove-down-cycle)
(global-set-key (kbd "C-x <right>") 'windmove-right-cycle)
(global-set-key (kbd "C-x <left>") 'windmove-left-cycle)
(global-set-key (kbd "M-<up>") 'windmove-up-cycle)
(global-set-key (kbd "M-<down>") 'windmove-down-cycle)
(global-set-key (kbd "M-<right>") 'windmove-right-cycle)
(global-set-key (kbd "M-<left>") 'windmove-left-cycle)

(define-key global-map (kbd "C-{") 'shrink-window-horizontally)
(define-key global-map (kbd "C-}") 'enlarge-window-horizontally)


;;;; Go to char, like "f" in vim
(defun wy-go-to-char (n char)
    "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forward to the next Nth
occurence of CHAR."
    (interactive "p\ncGo to char: ")
    (search-forward (string char) nil nil n)
    (while (char-equal (read-char)
		       char)
      (search-forward (string char) nil nil n))
      (setq unread-command-events (list last-input-event)))
