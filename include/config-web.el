(setq tsserver-path "/home/ianertson/.nvm/versions/node/v22.5.1/lib/node_modules/typescript/bin/tsserver")


;(defun setup-tide-mode ()
;  (interactive)
;  (tide-setup)
;  (flycheck-mode +1)
;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;  (eldoc-mode +1)
;  (tide-hl-identifier-mode +1)
;  (company-mode +1))


(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.mts\\'" . typescript-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :custom
  (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-markup-indent-offset 2)
  (web-mode-enable-auto-quoting nil)
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        )
;(add-hook 'web-mode-hook
;            (lambda ()
;              (when (string-equal "tsx" (file-name-extension buffer-file-name))
;		(setup-tide-mode))))
  )


(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))


(setq js-indent-level 2)
;
;(use-package tide
;  :init
;  (setq tide-tsserver-executable tsserver-path)
;  :ensure t
;  :custom
;  (setq tide-tsserver-executable tsserver-path)
;  :after (typescript-mode company flycheck)
;  :hook ((typescript-mode . tide-setup)
;         (typescript-mode . tide-hl-identifier-mode)
;         (before-save . tide-format-before-save)))
;
;
;
;(add-hook 'web-mode-hook #'setup-tide-mode)
