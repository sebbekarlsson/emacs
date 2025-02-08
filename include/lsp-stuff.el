;(use-package lsp-mode
;  :after evil
;  :ensure t
;  :init
;  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;  (setq lsp-use-plists t)
;  (setq lsp-keymap-prefix "C-c l")
;  (setq lsp-clients-clangd-args '("--header-insertion=never")) 
;  :commands lsp
;  :custom
;  (lsp-enable-snippet t)
;  :config (defun md/lsp-setup()
;    ;; recommended by LSP docs for performance
;    (setq read-process-output-max (* 1024 1024)) ;; 1mb
;
;    (lsp-enable-imenu)
;    (setq
;          lsp-auto-configure t
;          lsp-enable-dap-auto-configure nil ; Don't try to auto-enable dap: this creates a lot of binding clashes
;          lsp-auto-guess-root t ; Uses projectile to guess the project root.
;          lsp-before-save-edits t
;          lsp-eldoc-enable-hover t
;          lsp-eldoc-render-all nil
;          lsp-completion-enable t
;          lsp-completion-show-detail t
;          lsp-completion-show-kind t
;          lsp-enable-file-watchers t
;          lsp-file-watch-threshold 100
;          lsp-enable-folding t
;          lsp-enable-imenu t
;          lsp-enable-indentation t
;          lsp-enable-links t
;          lsp-clients-python-library-directories `("/usr/" ,(expand-file-name "~/.virtualenvs"), "./venv") ; This seems appropriate
;          lsp-enable-on-type-formatting nil
;          lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
;          lsp-enable-symbol-highlighting nil
;          lsp-enable-text-document-color nil
;          lsp-enable-xref t
;          lsp-flycheck-live-reporting nil
;          lsp-idle-delay 0.2
;          lsp-imenu-show-container-name t
;          lsp-imenu-sort-methods '(position kind name)
;          lsp-pyls-plugins-flake8-enabled t
;          lsp-signature-auto-activate t
;          lsp-signature-render-documentation t
;          lsp-signature-doc-lines 10
;          lsp-javascript-suggest-complete-function-calls t
;          lsp-typescript-suggest-complete-function-calls t
;          lsp-headerline-breadcrumb-enable nil)
;    (lsp-register-custom-settings
;     '(
;
;       ("pyls.plugins.pyls_black.enabled" t t)
;       ("pyls.plugins.pyls_isort.enabled" t t)
;
;       ;; Disable these as they're duplicated by flake8
;       ("pyls.plugins.pycodestyle.enabled" nil t)
;       ("pyls.plugins.mccabe.enabled" nil t)
;       ("pyls.plugins.pyflakes.enabled" nil t))))
;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;         (web-mode . lsp-deferred)
;         (tsx-ts-mode . lsp-deferred)
;         (typescript-mode . lsp-deferred)
;         (c-mode . lsp-deferred)
;         (c++-mode . lsp-deferred)
;         ;; if you want which-key integration
;         (lsp-mode . lsp-enable-which-key-integration)
;         (lsp-before-initialize . md/lsp-setup))
;  :bind (:map evil-normal-state-map
;              ("gh" . lsp-describe-thing-at-point)
;              ("gr" . lsp-find-references)
;              ("gD" . lsp-find-implementation)
;              ("gd" . lsp-find-definition)
;              ;:map md/leader-map
;              ("Ni" . imenu)
;              ("Ff" . lsp-format-buffer)
;              ("FR" . lsp-rename)))
;
;(use-package lsp-completion
;      :no-require
;      :hook ((lsp-mode . lsp-completion-mode)))


(use-package helm-lsp
  :after lsp-mode
  :ensure t
  :commands helm-lsp-workspace-symbol)
(use-package lsp-ivy
  :after lsp-mode
  :ensure t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :after lsp-mode
  :ensure t
  :commands lsp-treemacs-errors-list)


;(defun lsp-booster--advice-json-parse (old-fn &rest args)
;  "Try to parse bytecode instead of json."
;  (or
;   (when (equal (following-char) ?#)
;     (let ((bytecode (read (current-buffer))))
;       (when (byte-code-function-p bytecode)
;         (funcall bytecode))))
;   (apply old-fn args)))
;(advice-add (if (progn (require 'json)
;                       (fboundp 'json-parse-buffer))
;                'json-parse-buffer
;              'json-read)
;            :around
;            #'lsp-booster--advice-json-parse)
;
;(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
;  "Prepend emacs-lsp-booster command to lsp CMD."
;  (let ((orig-result (funcall old-fn cmd test?)))
;    (if (and (not test?)                             ;; for check lsp-server-present?
;             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
;             lsp-use-plists
;             (not (functionp 'json-rpc-connection))  ;; native json-rpc
;             (executable-find "emacs-lsp-booster"))
;        (progn
;          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
;            (setcar orig-result command-from-exec-path))
;          (message "Using emacs-lsp-booster for %s!" orig-result)
;          (cons "emacs-lsp-booster" orig-result))
;      orig-result)))
;(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)



(use-package lsp-mode
      :diminish "LSP"
      :ensure t
      :hook ((lsp-mode . lsp-diagnostics-mode)
             (lsp-mode . lsp-enable-which-key-integration)
             ((tsx-ts-mode
               typescript-ts-mode
               typescript-mode
               web-mode
               js-ts-mode
               c-mode
               c++-mode
               python-mode
               python-ts-mode
               ) . lsp-deferred))
      :custom
      (lsp-keymap-prefix "C-c l")           ; Prefix for LSP actions
      (lsp-completion-provider :none)       ; Using Corfu as the provider
      (lsp-diagnostics-provider :flycheck)
      (lsp-session-file (locate-user-emacs-file ".lsp-session"))
      (lsp-log-io nil)                      ; IMPORTANT! Use only for debugging! Drastically affects performance
      (lsp-keep-workspace-alive nil)        ; Close LSP server if all project buffers are closed
      (lsp-idle-delay 0.5)                  ; Debounce timer for `after-change-function'
      ;; core
      (lsp-enable-xref t)                   ; Use xref to find references
      (lsp-auto-configure t)                ; Used to decide between current active servers
      (lsp-eldoc-enable-hover t)            ; Display signature information in the echo area
      (lsp-enable-dap-auto-configure t)     ; Debug support
      (lsp-enable-file-watchers nil)
      (lsp-enable-folding nil)              ; I disable folding since I use origami
      (lsp-enable-imenu t)
      (lsp-enable-indentation nil)          ; I use prettier
      (lsp-enable-links nil)                ; No need since we have `browse-url'
      (lsp-enable-on-type-formatting nil)   ; Prettier handles this
      (lsp-enable-suggest-server-download t) ; Useful prompt to download LSP providers
      (lsp-enable-symbol-highlighting t)     ; Shows usages of symbol at point in the current buffer
      (lsp-enable-text-document-color nil)   ; This is Treesitter's job

      (lsp-ui-sideline-show-hover nil)      ; Sideline used only for diagnostics
      (lsp-ui-sideline-diagnostic-max-lines 20) ; 20 lines since typescript errors can be quite big
      ;; completion
      (lsp-completion-enable t)
      (lsp-completion-enable-additional-text-edit t) ; Ex: auto-insert an import for a completion candidate
      (lsp-enable-snippet t)                         ; Important to provide full JSX completion
      (lsp-completion-show-kind t)                   ; Optional
      ;; headerline
      (lsp-headerline-breadcrumb-enable t)  ; Optional, I like the breadcrumbs
      (lsp-headerline-breadcrumb-enable-diagnostics nil) ; Don't make them red, too noisy
      (lsp-headerline-breadcrumb-enable-symbol-numbers nil)
      (lsp-headerline-breadcrumb-icons-enable nil)
      ;; modeline
      (lsp-modeline-code-actions-enable nil) ; Modeline should be relatively clean
      (lsp-modeline-diagnostics-enable nil)  ; Already supported through `flycheck'
      (lsp-modeline-workspace-status-enable nil) ; Modeline displays "LSP" when lsp-mode is enabled
      (lsp-signature-doc-lines 1)                ; Don't raise the echo area. It's distracting
      (lsp-ui-doc-use-childframe t)              ; Show docs for symbol at point
      (lsp-eldoc-render-all nil)            ; This would be very useful if it would respect `lsp-signature-doc-lines', currently it's distracting
      ;; lens
      (lsp-lens-enable nil)                 ; Optional, I don't need it
      ;; semantic
      (lsp-semantic-tokens-enable nil)      ; Related to highlighting, and we defer to treesitter
      :preface
      (defun lsp-booster--advice-json-parse (old-fn &rest args)
        "Try to parse bytecode instead of json."
        (or
         (when (equal (following-char) ?#)

           (let ((bytecode (read (current-buffer))))
             (when (byte-code-function-p bytecode)
               (funcall bytecode))))
         (apply old-fn args)))
      (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
        "Prepend emacs-lsp-booster command to lsp CMD."
        (let ((orig-result (funcall old-fn cmd test?)))
          (if (and (not test?)                             ;; for check lsp-server-present?
                   (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
                   lsp-use-plists
                   (not (functionp 'json-rpc-connection))  ;; native json-rpc
                   (executable-find "emacs-lsp-booster"))
              (progn
                (message "Using emacs-lsp-booster for %s!" orig-result)
                (cons "emacs-lsp-booster" orig-result))
            orig-result)))
      :init
      (setq lsp-use-plists t)
      ;; Initiate https://github.com/blahgeek/emacs-lsp-booster for performance
      (advice-add (if (progn (require 'json)
                             (fboundp 'json-parse-buffer))
                      'json-parse-buffer
                    'json-read)
                  :around
                  #'lsp-booster--advice-json-parse)
      (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command))

;    (use-package lsp-completion
;;      :no-require
;;      :hook ((lsp-mode . lsp-completion-mode)))
;;
;;    (use-package lsp-ui
;;      :ensure t
;;      :commands
;;      (lsp-ui-doc-show
;;       lsp-ui-doc-glance)
;;      :bind (:map lsp-mode-map
;;                  ("C-c C-d" . 'lsp-ui-doc-glance))
;;      :after (lsp-mode evil)
;;      :config (setq lsp-ui-doc-enable t
;;                    evil-lookup-func #'lsp-ui-doc-glance ; Makes K in evil-mode toggle the doc for symbol at point
;;                    lsp-ui-doc-show-with-cursor nil      ; Don't show doc when cursor is over symbol - too distracting
;;                    lsp-ui-doc-include-signature t       ; Show signature
;;                    lsp-ui-doc-position 'at-point))

