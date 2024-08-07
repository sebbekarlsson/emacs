(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.ts\\'" . web-mode)
         ("\\.jsx\\'" . web-mode)
         )
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

;(defun setup-tide-mode ()
;  (interactive)
;  (tide-setup)
;  (flycheck-mode +1)
;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
;  (eldoc-mode +1)
;  (tide-hl-identifier-mode +1)
;  (company-mode +1))


;(defun setup-vue-mode ()
;  (interactive)
;  (flycheck-mode +1)
;  (eldoc-mode +1)
;  (tide-hl-identifier-mode +1)
;  (vue-mode +1)
;  (lsp-mode +1)
;  (company-mode +1)
;  'lsp)
;
 ; (add-hook 'web-mode-hook
 ;           (lambda ()
 ;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
 ;               (setup-tide-mode)))
 ;           )
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

;(use-package tide
;  :init
;  :ensure t
;  :after (typescript-mode company flycheck)
;  :hook ((typescript-mode . tide-setup)
;         (typescript-mode . tide-hl-identifier-mode)
;         (before-save . tide-format-before-save)))


;(require 'web-mode)
;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;(add-hook 'web-mode-hook
;          (lambda ()
;            (when (string-equal "tsx" (file-name-extension buffer-file-name))
;              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
