(add-to-list 'load-path (expand-file-name "v2" user-emacs-directory))

(electric-pair-mode t)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)
(add-hook 'treemacs-mode-hook (lambda () (display-line-numbers-mode -1)))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)

(require 'core)
(require 'packages)
(require 'hooks)
(require 'keybinds)

(setq gc-cons-threshold (* 50 1000 1000)) ; 50MB GC threshold
(run-with-idle-timer 5 t #'garbage-collect)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(lsp-apply-edits-after-file-operations nil)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-headerline-breadcrumb-enable nil)
 '(lsp-pyright-auto-import-completions 1)
 '(lsp-pyright-auto-search-paths 1)
 '(lsp-pyright-langserver-command "basedpyright")
 '(lsp-ui-doc-alignment 'window)
 '(lsp-ui-doc-position 'at-point)
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
