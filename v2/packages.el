(use-package markdown-mode)

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
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))

;(use-package yasnippet
;  :config (yas-global-mode 1))

(use-package company
  :config
  (setq company-idle-delay 0.005
        company-minimum-prefix-length 1)
  (global-company-mode 1))

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
  :ensure t)

(use-package web-mode
  :ensure t
  :mode (("\\.ts\\'" . web-mode)
         ("\\.js\\'" . web-mode)
         ("\\.mjs\\'" . web-mode)
         ("\\.mts\\'" . typescript-mode)
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
  )

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
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-apply-edits-after-file-operations nil)
  (setq lsp-clients-clangd-args
    '("--header-insertion=never"))
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;         (python-mode . lsp)
         (web-mode . lsp)
         (c-or-c++-mode . lsp)
         (c-mode . lsp)
         (c++-mode . lsp)
         ;(lisp-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(require 'lsp-mode)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
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



;(add-to-list 'lsp-language-id-configuration '(python-mode . "python"))
;(lsp-register-client (make-lsp-client
;                      :new-connection (lsp-stdio-connection '("basedpyright-langserver" "--stdio"))
;                      :activation-fn (lsp-activate-on "python")
;                      :server-id 'basedpyright-langserver))

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "basedpyright") ;; or basedpyright
  :config
  (setq lsp-pyright-auto-import-completions 1
        lsp-pyright-auto-search-paths 1
        lsp-pyright-diagnostic-mode "openFilesOnly"
   )
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(provide 'packages)
