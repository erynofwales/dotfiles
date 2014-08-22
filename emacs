; .emacs
; Eryn Wells <eryn@erynwells.me>

; Show point position in the status bar
(line-number-mode 1)
(column-number-mode 1)

; Fill to 80 columns by default
(setq-default fill-column 80)

; Spaces, not tabs!
(setq-default indent-tabs-mode 'nil)

; Show matching parens with 0 delay
(setq show-paren-delay 0)
(show-paren-mode 1)

; Follow symlinks
(setq-default vc-follow-symlinks 't)

; Use solarized color scheme
(add-to-list 'custom-theme-load-path "~/.emacs.d/solarized")
(load-theme 'solarized-dark t)

; Enable evil mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

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
