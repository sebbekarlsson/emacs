(use-package kotlin-mode
  :ensure t
  :mode (("\\.kt?\\'" . kotlin-mode)
         )
  :config
  ())

(defun setup-kotlin-mode ()
  (interactive)
;  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (lsp-mode +1)
;  (tide-hl-identifier-mode +1)
  (company-mode +1)
  'lsp)


(require 'kotlin-mode)
(add-to-list 'auto-mode-alist '("\\.kt\\'" . kotlin-mode))
(add-hook 'kotlin-mode-hook
          (lambda ()
            (when (string-equal "kt" (file-name-extension buffer-file-name))
              (setup-kotlin-mode))))
;(flycheck-add-mode 'kotlin-mode)
