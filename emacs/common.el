(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; no startup msg
(setq inhibit-startup-message t)

;; enable ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere 1)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

;; embedded terminal
(require 'multi-term)
(setq multi-term-program "/usr/bin/zsh")

;; tab
(setq tab-width 4)

(load-config "plugins/find-file-in-project")
(define-key global-map (kbd "C-x f") 'find-file-in-project)
