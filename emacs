; .emacs
; Eryn Wells <eryn@erynwells.me>

; Show point position in the status bar

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(line-number-mode 1)
(column-number-mode 1)

; Scroll one line at a time, instead of trying to center the cursor. Also screen
; margin leads point by three lines.
(setq-default scroll-step 1)
(setq-default scroll-margin 3)

; Fill to 80 columns by default
(setq-default fill-column 80)

; Spaces, not tabs!
(setq-default indent-tabs-mode 'nil)

; Show matching parens with 0 delay
(setq show-paren-delay 0)
(show-paren-mode 1)

; Follow symlinks
(setq-default vc-follow-symlinks 't)

(require 'package)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

; Use solarized color scheme
;(add-to-list 'custom-theme-load-path "~/.emacs.d/solarized")
;(load-theme 'solarized-dark t)

; Enable evil mode
;(add-to-list 'load-path "~/.emacs.d/evil")
;(require 'evil)
;(evil-mode 1)

; Don't show the menu bar
(menu-bar-mode -1)

;;
;; ORG MODE
;;

; Use org mode from the ~Internet~
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/lisp"))
(require 'org)

; Files ending in .org
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

; Auto fill in org mode
(add-hook 'org-mode-hook 'auto-fill-mode)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (magit ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
