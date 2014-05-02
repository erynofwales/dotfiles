; Show point position in the status bar
(line-number-mode 1)
(column-number-mode 1)

; Fill to 80 columns by default
(setq-default fill-column 80)

; Spaces, not tabs!
(setq-default indent-tabs-mode 'nil)

; Use solarized color scheme
(add-to-list 'custom-theme-load-path "~/.emacs.d/solarized")
(load-theme 'solarized-dark t)

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
