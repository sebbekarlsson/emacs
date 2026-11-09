;;; hooks.el --- Mode hooks -*- lexical-binding: t; -*-

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


(add-hook 'css-mode-hook
          (lambda ()
            (setq css-indent-offset 2)))


(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))


(setq js-indent-level 2)




(defun my-c-setup ()
  (setq indent-tabs-mode nil)
  (c-add-style "better-c-style"
             '("linux" (c-basic-offset . 2) ; Guessed value
               (indent-tabs-mode . nil)
               (c-offsets-alist (brace-list-close . 0) ; Guessed value
                                (brace-list-entry . 0) ; Guessed value
                                (brace-list-intro . +) ; Guessed value
                                (defun-block-intro . +) ; Guessed value
                                (defun-close . 0) (statement . 0) ;  Guessed valueGuessed value
                                (topmost-intro . 0) (access-label . -) ; Guessed value
                                (annotation-top-cont . 0)
                                (annotation-var-cont . +)
                                (arglist-close . c-lineup-close-paren)
                                (arglist-cont c-lineup-gcc-asm-reg 0)
                                ;(arglist-cont-nonempty . c-lineup-arglist)
                                (arglist-cont-nonempty . 0)
                                (arglist-intro . +)
                                (block-close . 0)
                                ;(block-close . -)
                                (block-open . 0)
                                (brace-entry-open . 0)
                                (brace-list-open . 0)
                                (c . c-lineup-C-comments)
                                (case-label . +) (catch-clause . 0)
                                (class-close . 0) (class-open . 0)
                                (comment-intro . c-lineup-comment)
                                (composition-close . 0)
                                (composition-open . 0)
                                (constraint-cont
                                 c-lineup-item-after-paren-at-boi +)
                                (cpp-define-intro c-lineup-cpp-define
                                                  +)
                                (cpp-macro . -1000)
                                (cpp-macro-cont . +) (defun-open . 0)
                                (do-while-closure . 0)
                                (else-clause . 0) (enum-close . 0)
                                (enum-entry . 0)
                                (enum-intro
                                 c-lineup-item-after-paren-at-boi +)
                                (enum-open . class-open)
                                (extern-lang-close . 0)
                                (extern-lang-open . 0) (friend . 0)
                                (func-decl-cont . +) (inclass . +)
                                (incomposition . +) (inexpr-class . +)
                                (inexpr-statement . +)
                                (inextern-lang . +)
                                (inher-cont . c-lineup-multi-inher)
                                (inher-intro . +) (inlambda . 0)
                                (inline-close . 0) (inline-open . +)
                                (inmodule . +) (innamespace . +)
                                (knr-argdecl . 0)
                                (knr-argdecl-intro . +) (label . 2)
                                (lambda-intro-cont . +)
                                (member-init-cont
                                 . c-lineup-multi-inher)
                                (member-init-intro . +)
                                (module-close . 0) (module-open . 0)
                                (namespace-close . 0)
                                (namespace-open . 0)
                                (objc-method-args-cont
                                 . c-lineup-ObjC-method-args)
                                (objc-method-call-cont
                                 c-lineup-ObjC-method-call-colons
                                 c-lineup-ObjC-method-call +)
                                (objc-method-intro . [0])
                                (statement-block-intro . +)
                                ;(statement-block-intro . 0)
                                ;(statement-block-intro . muckintosh)
                                (statement-case-intro . 0)
                                (statement-case-open . 0)
                                ;(statement-cont . +)
                                (statement-cont . 0)
                                (stream-op . c-lineup-streamop)
                                (string . -1000) (substatement . +)
                                (substatement-label . 2)
                                ;(substatement-open . +)
                                (substatement-open . 0)
                                (template-args-cont
                                 c-lineup-template-args
                                 c-lineup-template-args-indented-from-margin)
                                (topmost-intro-cont
                                 . c-lineup-topmost-intro-cont))))


      (setq c-default-style "better-c-style")
      (c-set-style "better-c-style")
      (c-set-offset 'brace-list-entry 0)
      (c-set-offset 'statement-cont 0)
      ;(c-set-offset 'statement-block-intro #'my-c-indentation-logic)
      )

(add-hook 'c-mode-hook 'my-c-setup)
(add-hook 'c-mode-common-hook 'my-c-setup)


;; clangd has no command-line flag for most of its settings (e.g. inserting
;; #include <...> instead of "..."); they only come from config files. Keep
;; them in this repo and copy them into clangd's user config, which applies
;; to every project. They go in as a marked block in a separate YAML document
;; (clangd allows several, split by "---"), so anything else in that file is
;; left alone and only our own block is ever replaced.
(defconst my-clangd-config-source
  (expand-file-name "v2/configs/clangd.yaml" user-emacs-directory))

(defconst my-clangd-block-begin
  "# >>> managed by ~/.emacs.d/v2/configs/clangd.yaml, edit it there >>>")
(defconst my-clangd-block-end "# <<< managed by ~/.emacs.d <<<")

(defun my-clangd-user-config-file ()
  "Path of clangd's user config file on this system."
  (pcase system-type
    ('darwin (expand-file-name "~/Library/Preferences/clangd/config.yaml"))
    ('windows-nt (expand-file-name "clangd/config.yaml" (getenv "LOCALAPPDATA")))
    (_ (expand-file-name "clangd/config.yaml"
                         (or (getenv "XDG_CONFIG_HOME") "~/.config")))))

(defun my-clangd-sync-user-config ()
  "Write `my-clangd-config-source' into clangd's user config, if it changed."
  (with-demoted-errors "Syncing clangd config: %S"
    (let* ((target (my-clangd-user-config-file))
           (block (concat "---\n" my-clangd-block-begin "\n"
                          (with-temp-buffer
                            (insert-file-contents my-clangd-config-source)
                            (string-trim-right (buffer-string)))
                          "\n" my-clangd-block-end "\n")))
      (with-temp-buffer
        (when (file-exists-p target)
          (insert-file-contents target))
        (let ((old (buffer-string)))
          (goto-char (point-min))
          (when (re-search-forward
                 (concat "^\\(?:---\n\\)?" (regexp-quote my-clangd-block-begin)
                         "\n\\(?:.*\n\\)*?" (regexp-quote my-clangd-block-end)
                         "\n?")
                 nil t)
            (replace-match "" t t))
          (goto-char (point-max))
          (unless (or (bobp) (eq (char-before) ?\n))
            (insert "\n"))
          (insert block)
          (unless (string= old (buffer-string))
            (make-directory (file-name-directory target) t)
            (write-region nil nil target nil 'silent)))))))

;; c-mode-common-hook runs before c-mode-hook / c++-mode-hook, where lsp
;; starts clangd, so the config is in place before clangd reads it.
(add-hook 'c-mode-common-hook #'my-clangd-sync-user-config)
;(setq c-default-style "better-c-style")


;(defun un-indent-by-removing-4-spaces ()
;  "remove 4 spaces from beginning of of line"
;  (interactive)
;  (save-excursion
;    (save-match-data
;      (beginning-of-line)
;      (when (looking-at "\{\}")
;        (message "yo")
;        (replace-match "  \}")))))
;
;
;
;(defun myadvice (orig-fun &rest args)
;  (let* ((cur-line (buffer-substring-no-properties
;                    (line-beginning-position)
;                    (line-end-position))))
;    (apply orig-fun args)
;    (message cur-line)
;    (when (string-match ".*?\\w+.*?(.*?).*?{" cur-line)
;		   (un-indent-by-removing-4-spaces))))

;(advice-add 'newline :around #'myadvice)


(provide 'hooks)
