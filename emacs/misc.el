;; diable beep
(setq visible-bell 1)

;; auto untabify buffer
(defun auto-untabify ()
  "Untabify current buffer"
  (interactive)
  (message "untabifying current buffer")
  (untabify (point-min) (point-max)))
(defun programming-modes-hooks ()
  "Hook untabify for programming modes"
  (add-hook 'before-save-hook 'programming-modes-write-hook))
(defun programming-modes-write-hook ()
  "Hooks which run on file write for programming modes"
  (prog1 nil
    ;; maybe i can do more things while saving
    (message "customized wirte hook running")
    (set-buffer-file-coding-system 'utf-8-unix)
    (auto-untabify)))

;; deal with white spaces
(require 'whitespace)
(global-whitespace-mode)
(setq whitespace-style
      '(face trailing lines lines-tail empty
	     space-after-tab space-before-tab))
(setq whitespace-line-column 250)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Don't ask me yes/no, I need y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Show parentheses in pairs
(show-paren-mode t)

;; Set text-mode for default major mode
(setq default-major-mode 'text-mode)

;; Show line number
(require 'linum)
(global-linum-mode t)
(setq column-number-mode t)
(setq line-number-node t) ;; show line number in status bar
(setq linum-format "%5d ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable linum for certern major mode
(defcustom linum-disabled-modes-list
  '(eshell-mode
    wl-summary-mode
    compilation-mode
    org-mode
    text-mode
    dired-mode
    term-mode
    gud-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum
  )
(defcustom linum-disable-starred-buffers 't
  "* Disable buffers that have stars in them like *Gnu Emacs*"
  :type 'boolean
  :group 'linum)

(defun linum-on ()
    "* When linum is running globally, disable line number in modes
defined in `linum-disabled-modes-list'. Changed by
linum-off. Also turns off numbering in starred modes like
*scratch*"

    (unless (or (minibufferp)
		(member major-mode linum-disabled-modes-list)
		(and
		 linum-disable-starred-buffers
		 (string-match "*" (buffer-name)))
		)
      (linum-mode 1)))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Don't show the welcome page
(setq inhibit-startup-message t)

;;Replace all freakin' ^M chars in the current buffer
(fset 'replace-ctrlms
      [escape ?< escape ?% ?\C-q ?\C-m return ?\C-q ?\C-j return ?!])


;;;; Auto close buffer when thread exit
(add-hook 'shell-mode-hook 'my-close-func)
(add-hook 'gdb-mode-hook 'my-close-func)
(defun my-close-func ()
  (let ((state (get-buffer-process (current-buffer))))
    (if (not (eq state nil))
	(progn
	  (set-process-sentinel state
				'kill-buffer-on-exit))))
  )
(defun kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
            (kill-buffer (current-buffer))))
