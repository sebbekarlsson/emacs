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
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-headerline-breadcrumb-enable-diagnostics nil)
  (setq lsp-apply-edits-after-file-operations nil)
  (setq lsp-disabled-clients '(deno-ls pylsp))
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
         (lsp-mode . lsp-enable-which-key-integration)


         )
  :commands lsp)

(require 'lsp-mode)
(setq typescript-indent-level 2)
(add-to-list 'lsp--formatting-indent-alist '(web-mode . typescript-indent-level))

;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (defun lsp-ui-sideline--compute-height nil '(height unspecified))
  (setq lsp-ui-doc-max-width 80)
  (setq lsp-ui-doc-max-height 20)
  (setq lsp-ui-doc-position 'at-point)
  (setq lsp-ui-doc-alignment 'window)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-diagnostic-max-lines 3)
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







;; Claude code
;; install required inheritenv dependency:
(use-package inheritenv
  :vc (:url "https://github.com/purcell/inheritenv" :rev :newest))

;; for eat terminal backend:
(use-package eat :ensure t)

;; for vterm terminal backend:
(use-package vterm :ensure t)

;; install claude-code.el
(use-package claude-code :ensure t
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :config
  ;; optional IDE integration with Monet
 ; (add-hook 'claude-code-process-environment-functions #'monet-start-server-function)
;  (monet-mode 1)

  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map)

  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))



;; Set your key binding for the command map.
;(global-set-key (kbd "C-c C-a") claude-code-command-map)

;; Set terminal type for the Claude terminal emulation (default is "xterm-256color").
;; This determines terminal capabilities like color support.
;; See the documentation for eat-term-name for more information.
;(setq claude-code-term-name "xterm-256color")

;; Change the path to the Claude executable (default is "claude").
;; Useful if Claude is not in your PATH or you want to use a specific version.

;(setq claude-code-program "/home/ianertson/.local/bin/claude")

;; Set command line arguments for Claude
;; For example, to enable verbose output
;;(setq claude-code-program-switches '("--verbose"))

;; Add hooks to run after Claude is started
;(add-hook 'claude-code-start-hook 'my-claude-setup-function)

;; Adjust initialization delay (default is 0.1 seconds)
;; This helps prevent terminal layout issues if the buffer is displayed before Claude is fully ready.
;(setq claude-code-startup-delay 0.2)

;; Configure the buffer size threshold for confirmation prompt (default is 100000 characters)
;; If a buffer is larger than this threshold, claude-code-send-region will ask for confirmation
;; before sending the entire buffer to Claude.
;(setq claude-code-large-buffer-threshold 100000)

;; Configure key binding style for entering newlines and sending messages in Claude buffers.
;; Available styles:
;;   'newline-on-shift-return - S-return inserts newline, RET sends message (default)
;;   'newline-on-alt-return   - M-return inserts newline, RET sends message
;;   'shift-return-to-send    - RET inserts newline, S-return sends message
;;   'super-return-to-send    - RET inserts newline, s-return sends message (Command+Return on macOS)
(setq claude-code-newline-keybinding-style 'newline-on-shift-return)

;; Enable or disable notifications when Claude finishes and awaits input (default is t).
;(setq claude-code-enable-notifications t)

;; Customize the notification function (default is claude-code--default-notification).
;; The function should accept two arguments: title and message.
;; The default function displays a message and pulses the modeline for visual feedback.
;(setq claude-code-notification-function 'claude-code--default-notification)

;; Example: Use your own notification function
;(defun my-claude-notification (title message)
;  "Custom notification function for Claude Code."
;  ;; Your custom notification logic here
;  (message "[%s] %s" title message))
;(setq claude-code-notification-function 'my-claude-notification)

;; Configure kill confirmation behavior (default is t).
;; When t, claude-code-kill prompts for confirmation before killing instances.
;; When nil, kills Claude instances without confirmation.
;(setq claude-code-confirm-kill t)

;; Enable/disable window resize optimization (default is t)
;; When enabled, terminal reflows are only triggered when window width changes,
;; not when only height changes. This prevents unnecessary redraws when splitting
;; windows vertically, improving performance and reducing visual artifacts.
;; Set to nil if you experience issues with terminal display after resizing.
;(setq claude-code-optimize-window-resize t)

;; Enable/disable no-delete-other-windows parameter (default is nil)
;; When enabled, Claude Code windows have the no-delete-other-windows
;; parameter set. This prevents the Claude window from being closed
;; when you run delete-other-windows or similar commands, keeping the
;; Claude buffer visible and accessible.
;(setq claude-code-no-delete-other-windows t)

;; Automatically select the Claude buffer when toggling it open (default is nil)
;; When set to t, claude-code-toggle will switch focus to the Claude buffer
;; after displaying it. When nil, the buffer is displayed but focus remains
;; in the current buffer.
;(setq claude-code-toggle-auto-select t)
;; -------------

(provide 'packages)
