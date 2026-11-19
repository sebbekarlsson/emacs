;;; packages.el --- Package declarations -*- lexical-binding: t; -*-
;; GitHub-style Markdown preview.
;; - `:mdlive' (markdown-live-preview-mode): rendered side-by-side in eww,
;;   refreshed on save.
;; - `:mdpreview' (markdown-preview): opens in the browser with GitHub's CSS.
;; Rendering is done by v2/scripts/gfm.py (markdown-it-py, run through uv,
;; which fetches its dependencies on first use).
(defun my/markdown-render (beg end output-buffer)
  "Render Markdown between BEG and END as HTML into OUTPUT-BUFFER.
Relative image paths are made absolute so previews written to /tmp
still find them. The eww live preview shows <picture> dark variants
when the theme is dark, since eww ignores <source>."
  (let* ((args (append
                (list "run" "--quiet" "--script"
                      (expand-file-name "v2/scripts/gfm.py" user-emacs-directory)
                      "--base" (expand-file-name default-directory))
                (and (bound-and-true-p markdown-live-preview-currently-exporting)
                     (eq (frame-parameter nil 'background-mode) 'dark)
                     '("--dark"))))
         (status (apply #'call-process-region beg end
                        (or (executable-find "uv") "uv")
                        nil (list output-buffer nil) nil args)))
    (unless (eq status 0)
      (error "gfm.py failed with exit code %s" status))))

(use-package markdown-mode
  :custom
  (markdown-command #'my/markdown-render)
  (markdown-fontify-code-blocks-natively t)
  (markdown-css-paths
   '("https://cdn.jsdelivr.net/npm/github-markdown-css@5.8.1/github-markdown.min.css"))
  (markdown-xhtml-header-content
   "<style>.markdown-body{box-sizing:border-box;max-width:980px;margin:0 auto;padding:45px}</style>")
  (markdown-xhtml-body-preamble "<article class=\"markdown-body\">")
  (markdown-xhtml-body-epilogue "</article>"))

;; Syntax-highlight <pre> code blocks in eww/shr with Emacs' own major modes,
;; so the live preview's code blocks match the editor theme.
(use-package shr-tag-pre-highlight
  :after shr
  :config
  (add-to-list 'shr-external-rendering-functions
               '(pre . shr-tag-pre-highlight)))

(use-package exec-path-from-shell
  :ensure t)

(use-package restart-emacs
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-multiedit
  :ensure t)

(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :custom
  ;; Keep .~undo-tree~ history files out of project trees so AI agents
  ;; (and grep/ripgrep) don't trip over them.
  (undo-tree-history-directory-alist
   `(("." . ,(expand-file-name "undo-tree-history/" user-emacs-directory))))
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

(use-package yasnippet
  :ensure t
  :after evil
  :config
  (yas-global-mode 1)
  (setq yas-indent-line nil)
  (setq yas-also-indent-empty-lines nil)
  )

(use-package company
  :config
  (setq company-idle-delay 0.15
        company-minimum-prefix-length 2)
  (global-company-mode 1))

;; Company's child-frame popup hides itself on any window-configuration change
;; where the selected window isn't the one it was drawn for. Emacs runs that
;; hook with the *changed* frame selected, so whenever lsp-ui-doc shows its doc
;; child frame, the completion box vanished. Ignore changes in child frames.
(with-eval-after-load 'company-childframe
  (advice-add 'company-childframe-window-change :before-until
              (lambda () (frame-parent))))

(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))


(use-package iedit
  :ensure t)

(use-package doom-themes
  :config (load-theme 'doom-one t))

(use-package nerd-icons
  :config
  (defvar my/nerd-icons-font-checked nil
    "Non-nil once the Nerd Font check has run on a graphical frame.")

  (defun my/nerd-icons-ensure-font (&optional frame)
    "Install `nerd-icons-font-family' if FRAME's display can't find it.
Font lookup needs a graphical frame, so this does nothing on a tty
and runs again when a daemon client opens its first GUI frame."
    (when (and (not my/nerd-icons-font-checked)
               (display-graphic-p frame)
               (memq system-type '(gnu gnu/linux gnu/kfreebsd darwin)))
      (setq my/nerd-icons-font-checked t)
      (remove-hook 'server-after-make-frame-hook #'my/nerd-icons-ensure-font)
      (unless (member nerd-icons-font-family (font-family-list frame))
        (nerd-icons-install-fonts t)
        (message "Installed %s; restart Emacs for the icons to show up"
                 nerd-icons-font-family))))

  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'my/nerd-icons-ensure-font)
    (my/nerd-icons-ensure-font)))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))



(use-package treemacs
  :ensure t
  :defer t
  :init
  (setq treemacs-tag-follow-mode -1)
  (setq treemacs-follow-mode -1)
  (setq treemacs-collapse-dirs 0)
  :config
  (setq treemacs-collapse-dirs 0)
  (setq treemacs-tag-follow-mode -1)
  (setq treemacs-follow-mode -1)
  (treemacs-tag-follow-mode -1)
  (treemacs-follow-mode -1)
  )

(with-eval-after-load 'treemacs-mode
  (treemacs-tag-follow-mode -1)
  (treemacs-follow-mode -1))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)


(use-package cmake-mode
  :ensure t)

(use-package glsl-mode
  :ensure t
  :hook (glsl-mode . (lambda ()
                       ;; glsl-mode is built on CC Mode and installs
                       ;; `c-after-change', but unlike c-mode it leaves
                       ;; `parse-sexp-lookup-properties' nil.  CC Mode's CPP
                       ;; neutralizer (`c-neutralize-CPP-line') marks a stray
                       ;; unbalanced paren with a punctuation syntax-table
                       ;; property and re-scans, expecting it to be ignored.
                       ;; With the variable nil that property is ignored, the
                       ;; paren keeps counting, and the loop spins forever --
                       ;; e.g. the instant you type the "(" in "#define FOO(".
                       ;; Turning it on (as c-mode does) lets the loop end.
                       (setq-local parse-sexp-lookup-properties t))))

(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.mts\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  ;:hook (web-mode . lsp)
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
  ;; After an edit, web-mode only re-scans a small window around the change in
  ;; JS/TS/JSX buffers: from the previous line ending in [;{}(] to the next
  ;; one ending in [;{})]. Inside a JSX tree that window often starts mid
  ;; element (e.g. right after "{cond && (" or "}}"), the scanner can't tell
  ;; the tags apart from JS there, and drops their tag properties. Those lines
  ;; then lose highlighting and indentation until the whole buffer is
  ;; re-scanned (e.g. by re-running `web-mode'). Widen the window to the
  ;; enclosing top-level statement (a line starting in column 0 with an
  ;; identifier/keyword, e.g. "export const Foo = ..."), so the scan always
  ;; starts in plain JS context and covers the whole component.
  (defun my/web-mode-widen-js-invalidation (args)
    (if (not (member web-mode-content-type '("jsx" "javascript" "typescript")))
        args
      (let ((beg (nth 0 args))
            (end (nth 1 args))
            (top-level "^[[:alpha:]_$@]"))
        (save-excursion
          (goto-char beg)
          (end-of-line)
          (setq beg (if (re-search-backward top-level nil t) (point) (point-min)))
          (goto-char end)
          (end-of-line)
          (setq end (if (re-search-forward top-level nil t)
                        (max (match-beginning 0) end)
                      (point-max))))
        (list beg end))))
  (advice-add 'web-mode-invalidate-part-region
              :filter-args #'my/web-mode-widen-js-invalidation)
  ;; web-mode sets `yank-excluded-properties' to t, so `insert-for-yank'
  ;; strips *every* property from pasted text -- but it does so after the
  ;; insertion, i.e. after web-mode has already scanned and highlighted it.
  ;; The pasted block ends up with no faces and no tag properties (so no
  ;; indentation either). web-mode only repairs this for the `yank' command;
  ;; evil's insert-state paste (C-r), mouse and clipboard pastes all miss it.
  ;; Re-scan and re-highlight the pasted region whatever command pasted it.
  (defun my/web-mode-rescan-after-yank (start end)
    (when (derived-mode-p 'web-mode)
      (save-excursion
        (if font-lock-mode
            (font-lock-fontify-region start end)
          (web-mode-scan start end)))))
  (advice-add 'remove-yank-excluded-properties
              :after #'my/web-mode-rescan-after-yank))


(use-package posframe) ;; required by lsp-bridge

;;;;;;; <LSP BRIDGE>
                                        ;(add-to-list 'load-path (expand-file-name "site-lisp/lsp-bridge" user-emacs-directory))
                                        ;(require 'lsp-bridge)
                                        ;(global-lsp-bridge-mode)
;;;;;;;; </LSP BRIDGE>

                                        ;(global-lsp-mode)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-apply-edits-after-file-operations nil)
  ;; ts-ls is the old Node tsserver wrapper; tsgo is the native Go
  ;; language server from TypeScript 7 (@typescript/native-preview).
  (setq lsp-disabled-clients '(deno-ls ts-ls))
  ;; lsp-mode's default auto-download is clangd 15.0.6, which doesn't index
  ;; the C standard library: `printf' isn't even offered until <stdio.h> is
  ;; included. Newer clangd completes it and adds the #include for you.
  ;; Must be set before lsp-clangd.el loads (it derives the binary path).
  (setq lsp-clangd-version "23.1.0")
  ;; iwyu: accepting a completion inserts the #include that declares it.
  ;; Items that will add one are marked with a leading "•".
  (setq lsp-clients-clangd-args
        '("--header-insertion=iwyu"))
  ;; Performance tuning
  (setq read-process-output-max (* 1024 1024)) ; 1MB (default 4KB)
  (setq lsp-idle-delay 0.15)                    ; debounce LSP requests (default 0.2)
  (setq lsp-log-io nil)                         ; disable IO logging
  (setq lsp-completion-provider :capf)          ; use capf (faster than company-lsp)
  (setq lsp-enable-file-watchers nil)           ; disable file watchers (big perf win)
  (setq lsp-enable-folding nil)                 ; disable features you may not need
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-lens-enable nil)
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;         (python-mode . lsp)
         (web-mode . lsp)
         (python-mode . lsp)
         (c-or-c++-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         ;(lisp-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration)


         )
  :commands lsp)

(require 'lsp-mode)
(setq typescript-indent-level 2)
(add-to-list 'lsp--formatting-indent-alist '(web-mode . typescript-indent-level))

;; lsp-mode advertises `(inlineCompletion . ())' in its client capabilities,
;; which json-encodes to null. tsgo's strict Go JSON parser rejects null for
;; that field and the initialize request fails. Give it an object body.
(advice-add 'lsp--client-capabilities :filter-return
            (lambda (caps)
              (when-let* ((entry (assq 'inlineCompletion
                                       (alist-get 'textDocument caps))))
                (unless (cdr entry)
                  (setcdr entry '((dynamicRegistration . :json-false)))))
              caps))

;; Upstream lsp-mode doesn't recognize .mts/.cts: they're missing from both
;; `lsp-language-id-configuration' and the ts/js activation predicate.
(add-to-list 'lsp-language-id-configuration '("\\.[cm]ts\\'" . "typescript"))
(advice-add 'lsp-typescript-javascript-tsx-jsx-activate-p :after-until
            (lambda (filename &optional _)
              (string-match-p "\\.[cm]ts\\'" filename)))

;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  ;; Don't show docs on mouse hover: it sets `track-mouse', so mouse-movement
  ;; events get mixed into typed input and the popup can land under the pointer
  ;; and take keyboard focus. Show docs for the symbol under the cursor instead.
  (setq lsp-ui-doc-show-with-mouse nil)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-max-width 80)
  (setq lsp-ui-doc-max-height 20)
  (setq lsp-ui-doc-position 'bottom)
  (setq lsp-ui-doc-alignment 'window)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-diagnostic-max-lines 1)
  (setq lsp-ui-sideline-diagnostic-max-line-length 150)
)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode))

;; optionally if you want to use debugger
;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language



(add-to-list 'lsp-language-id-configuration '(python-mode . "python"))
(lsp-register-client (make-lsp-client
                      :new-connection (lsp-stdio-connection '("basedpyright-langserver" "--stdio"))
                      :activation-fn (lsp-activate-on "python")
                      :server-id 'basedpyright-langserver))

;(use-package lsp-pyright
;  :ensure t
;  :custom (lsp-pyright-langserver-command "basedpyright") ;; or basedpyright
;  :config
;  (setq lsp-pyright-auto-import-completions 1
;        lsp-pyright-auto-search-paths 1
;        lsp-pyright-diagnostic-mode "openFilesOnly"
;   )
;  :hook (python-mode . (lambda ()
;                          (require 'lsp-pyright)
;                          (lsp-deferred))))
;

(provide 'packages)
