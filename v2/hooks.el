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


;; Slang (slangd). Projects bring their own slangd (e.g. through a Vulkan SDK
;; fetched into the build directory), so look inside the project first.
(defconst my-slangd-max-levels-up 12
  "How many directories to go up when looking for the project's .git.")

(defconst my-slangd-max-depth 8
  "How many directories below the project root to look for slangd.")

(defconst my-slangd-ignored-directories
  '(".git" ".hg" ".svn" "node_modules" ".venv" "venv" "__pycache__" ".cache")
  "Directories that are never searched for slangd.")

(defvar my-slangd-cache (make-hash-table :test #'equal)
  "Maps a project root to the slangd found inside it, or to `none'.
Filled the first time a Slang file is opened in a project, so that each
project is only searched once.")

(defun my-slangd-forget ()
  "Search for slangd again the next time a Slang file is opened."
  (interactive)
  (clrhash my-slangd-cache))

(defun my-slangd-project-root (dir)
  "Go up from DIR, at most `my-slangd-max-levels-up' levels, to find .git.
It can also be a file, as in worktrees and submodules."
  (let ((dir (file-name-as-directory (expand-file-name dir)))
        (levels my-slangd-max-levels-up)
        root)
    (while (and dir (not root) (>= levels 0))
      (if (file-exists-p (expand-file-name ".git" dir))
          (setq root dir)
        (let ((parent (file-name-directory (directory-file-name dir))))
          (setq dir (unless (equal parent dir) parent)
                levels (1- levels)))))
    root))

(defun my-slangd-search-down (root)
  "Find a slangd binary below ROOT, preferring the one closest to it.
Doesn't follow symlinked directories, which could loop."
  (let ((name (if (eq system-type 'windows-nt) "slangd.exe" "slangd"))
        (dirs (list root))
        (depth 0)
        found)
    (while (and dirs (not found) (<= depth my-slangd-max-depth))
      (let (next)
        (while (and dirs (not found))
          (let* ((dir (pop dirs))
                 (entries (ignore-errors (file-name-all-completions "" dir)))
                 (file (expand-file-name name dir)))
            (if (and (member name entries) (file-executable-p file))
                (setq found file)
              (dolist (entry (sort entries
                                   (lambda (a b)
                                     (string< (directory-file-name a)
                                              (directory-file-name b)))))
                (when (and (directory-name-p entry)
                           (not (member entry '("./" "../"))))
                  (let* ((base (directory-file-name entry))
                         (sub (expand-file-name base dir)))
                    (unless (or (member base my-slangd-ignored-directories)
                                (file-symlink-p sub))
                      (push (file-name-as-directory sub) next))))))))
        (setq dirs (nreverse next)
              depth (1+ depth))))
    found))

(defun my-slangd-find ()
  "Return the slangd to use for the current buffer, or nil.
Looks inside the buffer's git project first, then in PATH."
  (let ((root (my-slangd-project-root default-directory)))
    (or (when root
          (let ((cached (gethash root my-slangd-cache)))
            (cond
             ((eq cached 'none) nil)
             ((and cached (file-executable-p cached)) cached)
             (t (let ((found (my-slangd-search-down root)))
                  (puthash root (or found 'none) my-slangd-cache)
                  found)))))
        (executable-find "slangd"))))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(slang-ts-mode . "slang"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     (lambda () (list (or (my-slangd-find) "slangd"))))
    :activation-fn (lsp-activate-on "slang")
    :request-handlers (lsp-ht ("workspace/inlayHint/refresh" #'ignore))
    :server-id 'slangd)))

(defun my-slang-setup ()
  ;; At the default level 3, functions and numbers aren't highlighted.
  (setq-local treesit-font-lock-level 4)
  (treesit-font-lock-recompute-features)
  (if (my-slangd-find)
      (lsp)
    ;; Not `error': that would abort the rest of the mode setup.
    (display-warning
     'slangd
     (format "No slangd found for %s: not in its git project, not in PATH"
             (or buffer-file-name (buffer-name)))
     :error)))

(add-hook 'slang-ts-mode-hook #'my-slang-setup)

;; slangd has no "find references" (it doesn't index the project), so search
;; the project's Slang files for the name instead. Goes back to asking the
;; server by itself if a future slangd supports it.
(defun my-slang-text-references-p ()
  "Non-nil if references must be found by text search in this buffer."
  (and (derived-mode-p 'slang-ts-mode)
       (not (lsp-feature? "textDocument/references"))))

(defun my-slang-project-files ()
  "Return the project's Slang files, without the ones git ignores."
  (let ((case-fold-search nil)
        (project (project-current)))
    (seq-filter (lambda (file) (string-match-p "\\.slangh?\\'" file))
                (if project
                    (project-files project)
                  (directory-files default-directory t)))))

(defun my-slang-matches-in-buffer (name file)
  "Return xrefs to FILE for the whole-word matches of NAME in this buffer."
  (let ((case-fold-search nil)
        (regexp (format "\\_<%s\\_>" (regexp-quote name)))
        matches)
    (save-excursion
      (save-restriction
        (widen)
        ;; The standard table has "_" as part of symbols.
        (with-syntax-table (standard-syntax-table)
          (goto-char (point-min))
          (while (re-search-forward regexp nil t)
            (let* ((start (match-beginning 0))
                   (bol (line-beginning-position))
                   (column (- start bol))
                   (line (buffer-substring-no-properties
                          bol (line-end-position))))
              (put-text-property column (+ column (length name))
                                 'face 'xref-match line)
              (push (xref-make-match
                     line
                     (xref-make-file-location
                      file (line-number-at-pos start t) column)
                     (length name))
                    matches))))))
    (nreverse matches)))

(defun my-slang-text-references (name)
  "Return xrefs for every whole-word match of NAME in the project.
Includes unsaved changes in open buffers."
  (require 'xref)
  (require 'project)
  (mapcan (lambda (file)
            (let ((buffer (find-buffer-visiting file)))
              (cond
               (buffer
                (with-current-buffer buffer
                  (my-slang-matches-in-buffer name file)))
               ((file-readable-p file)
                (with-temp-buffer
                  (insert-file-contents file)
                  (my-slang-matches-in-buffer name file))))))
          (my-slang-project-files)))

(defun my-slang-find-references (orig &rest args)
  "Around advice for `lsp-find-references': search text if slangd can't."
  (if (not (my-slang-text-references-p))
      (apply orig args)
    (let* ((name (or (thing-at-point 'symbol t)
                     (user-error "No symbol at point")))
           (xrefs (my-slang-text-references name)))
      (unless xrefs
        (user-error "No references found for %s" name))
      (lsp-show-xrefs xrefs (plist-get (cdr args) :display-action) t))))

(with-eval-after-load 'lsp-mode
  (advice-add 'lsp-find-references :around #'my-slang-find-references)
  ;; M-? (`xref-find-references') asks the server on its own.
  (cl-defmethod xref-backend-references :around ((_backend (eql 'xref-lsp))
                                                 identifier)
    (if (my-slang-text-references-p)
        (my-slang-text-references (substring-no-properties identifier))
      (cl-call-next-method))))


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
