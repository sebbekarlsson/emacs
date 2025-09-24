
;;;;;;; <LSP BRIDGE>
;(setq lsp-bridge-enable-hover-diagnostic 1)
;(setq-default lsp-bridge-enable-hover-diagnostic 1)
;(defun local/lsp-bridge-get-single-lang-server-by-project (project-path filepath)
;  (let* ((json-object-type 'plist)
;         (custom-dir (expand-file-name "site-lisp/lsp-bridge/basedpyright" user-emacs-directory))
;         (custom-config (expand-file-name "basedpyright.json" custom-dir))
;         (default-config (json-read-file (expand-file-name "site-lisp/lsp-bridge/langserver/basedpyright.json" user-emacs-directory)))
;         (settings (plist-get default-config :settings))
;         )
;
;    (plist-put settings :pythonPath (executable-find "python"))
;
;    (make-directory (file-name-directory custom-config) t)
;
;    (with-temp-file custom-config
;      (insert (json-encode default-config)))
;
;    custom-config))
;
;(add-hook 'python-mode-hook (lambda () (setq-local lsp-bridge-get-single-lang-server-by-project 'local/lsp-bridge-get-single-lang-server-by-project)))
;
;(add-hook 'pyvenv-post-activate-hooks
;          (lambda ()
;            (lsp-bridge-restart-process)))
;
;;;;;;;; </LSP BRIDGE>


(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))


(setq js-indent-level 2)

(provide 'hooks)
