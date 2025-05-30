;; For LSP-Bridge
(use-package posframe) ;; required by lsp-bridge

;; Clone manually if not using ELPA:
;; git clone https://github.com/manateelazycat/lsp-bridge ~/.emacs.d/site-lisp/lsp-bridge
(add-to-list 'load-path (expand-file-name "site-lisp/lsp-bridge" user-emacs-directory))
(require 'lsp-bridge)
(global-lsp-bridge-mode)

(setq lsp-bridge-enable-hover-diagnostic 1)
(setq-default lsp-bridge-enable-hover-diagnostic 1)


(defun local/lsp-bridge-get-single-lang-server-by-project (project-path filepath)
  (let* ((json-object-type 'plist)
         (custom-dir (expand-file-name "site-lisp/lsp-bridge/basedpyright" user-emacs-directory))
         (custom-config (expand-file-name "basedpyright.json" custom-dir))
         (default-config (json-read-file (expand-file-name "site-lisp/lsp-bridge/langserver/basedpyright.json" user-emacs-directory)))
         (settings (plist-get default-config :settings))
         )

    (plist-put settings :pythonPath (executable-find "python"))

    (make-directory (file-name-directory custom-config) t)

    (with-temp-file custom-config
      (insert (json-encode default-config)))

    custom-config))

(add-hook 'python-mode-hook (lambda () (setq-local lsp-bridge-get-single-lang-server-by-project 'local/lsp-bridge-get-single-lang-server-by-project)))

(add-hook 'pyvenv-post-activate-hooks
          (lambda ()
            (lsp-bridge-restart-process)))

;; For TypeScript
;(use-package typescript-mode
;               :mode "\\.ts\\'"
;               :hook (typescript-mode . lsp-bridge-mode))

(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.mts\\'" . typescript-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :hook (web-mode . lsp-bridge-mode)
    :custom
  ;(web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
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
  )

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))


(setq js-indent-level 2)

;; Automatically import TS modules
;(use-package import-js
;               :hook ((typescript-mode . import-js-minor-mode)))

(provide 'langs)

