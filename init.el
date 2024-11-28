;;; init.el --- Emacs configuration -*- lexical-binding: t -*-

;;; Commentary:

;; Save the contents of this file to ~/.config/emacs/init.el and
;; you're ready to boot up Emacs.

;; Hack this file! One of the best ways to get started with Emacs is
;; to look at other peoples' configurations and extract the pieces
;; that work for you. That's where this configuration started. I
;; encourage you to read through the code in this file and explore the
;; functions and variables using the built-in help system (details
;; below). Happy hacking!

;; "C-<chr>  means hold the CONTROL key while typing the character <chr>.
;; Thus, C-f would be: hold the CONTROL key and type f." (Emacs tutorial)
;;
;; - C-h t: Start the Emacs tutorial
;; - C-h o some-symbol: Describe symbol
;; - C-h C-q: Pull up the quick-help cheatsheet

;;; Code:

;; Performance tweaks for modern machines
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb

;; Remove extra UI clutter by hiding the scrollbar, menubar, and toolbar.
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/include")

(use-package desktop
  :ensure t
  :config
  (defun restore-desktop (frame)
    "Restores desktop and cancels hook after first frame opens.
     So the daemon can run at startup and it'll still work"
    (with-selected-frame frame
      (desktop-save-mode 1)
      (desktop-read)
      (remove-hook 'after-make-frame-functions 'restore-desktop)))
  (add-to-list 'desktop-globals-to-save 'dirvish--history)
  (setq desktop-restore-forces-onscreen nil)
  (setq desktop-restore-eager 5)
  (setq desktop-auto-save-timeout 5)
  (add-hook 'after-make-frame-functions 'restore-desktop))

;(desktop-save-mode 1)

(setq scroll-conservatively 10)
(setq scroll-margin 7)

;; Set the font. Note: height = px * 100
(set-face-attribute 'default nil :font "Noto Sans Mono" :height 120)

;; Add unique buffer names in the minibuffer where there are many
;; identical files. This is super useful if you rely on folders for
;; organization and have lots of files with the same name,
;; e.g. foo/index.ts and bar/index.ts.
(require 'uniquify)

;; Automatically insert closing parens
(electric-pair-mode t)

;; Visualize matching parens
(show-paren-mode 1)

;; Prefer spaces to tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2)

;; Automatically save your place in files
; (save-place-mode t)

;; Save history in minibuffer to keep recent commands easily accessible
(savehist-mode t)

;; Keep track of open files
; (recentf-mode t)

;; Keep files up-to-date when they change outside Emacs
(global-auto-revert-mode t)

;; Display line numbers only when in programming modes
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; The `setq' special form is used for setting variables. Remember
;; that you can look up these variables with "C-h v variable-name".
(setq uniquify-buffer-name-style 'forward
      window-resize-pixelwise t
      frame-resize-pixelwise t
      load-prefer-newer t
      backup-by-copying t
      ;; Backups are placed into your Emacs directory, e.g. ~/.config/emacs/backups
      backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))
      ;; I'll add an extra note here since user customizations are important.
      ;; Emacs actually offers a UI-based customization menu, "M-x customize".
      ;; You can use this menu to change variable values across Emacs. By default,
      ;; changing a variable will write to your init.el automatically, mixing
      ;; your hand-written Emacs Lisp with automatically-generated Lisp from the
      ;; customize menu. The following setting instead writes customizations to a
      ;; separate file, custom.el, to keep your init.el clean.
      custom-file (expand-file-name "custom.el" user-emacs-directory))



(setq use-short-answers t)
(setq confirm-nonexistent-file-or-buffer nil)
(setq create-lockfiles nil)
(setq warning-minimum-level :error)
(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; Bring in package utilities so we can install packages from the web.
(require 'package)

;; Add MELPA, an unofficial (but well-curated) package registry to the
;; list of accepted package registries. By default Emacs only uses GNU
;; ELPA and NonGNU ELPA, https://elpa.gnu.org/ and
;; https://elpa.nongnu.org/ respectively.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Unless we've already fetched (and cached) the package archives,
;; refresh them.
;(unless package-archive-contents
;  (package-refresh-contents))

(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;; Add the :vc keyword to use-package, making it easy to install
;; packages directly from git repositories.
(unless (package-installed-p 'vc-use-package)
  (package-vc-install "https://github.com/slotThe/vc-use-package"))
(require 'vc-use-package)

;; A quick primer on the `use-package' function (refer to
;; "C-h f use-package" for the full details).
;;
;; (use-package my-package-name
;;   :ensure t    ; Ensure my-package is installed
;;   :after foo   ; Load my-package after foo is loaded (seldom used)
;;   :init        ; Run this code before my-package is loaded
;;   :bind        ; Bind these keys to these functions
;;   :custom      ; Set these variables
;;   :config      ; Run this code after my-package is loaded

;; A package with a great selection of themes:
;; https://protesilaos.com/emacs/ef-themes
;(use-package ef-themes
;  :ensure t
;  :config
;  (ef-themes-select 'ef-autumn))

;(use-package persp-mode
;  :ensure t
;  :config
;      (add-hook 'window-setup-hook #'(lambda () (persp-mode 1))))


(use-package all-the-icons
  :ensure t)

(use-package doom-themes
  :after all-the-icons
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  ;(doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;(use-package gruvbox-theme
;  :config
;  (load-theme 'gruvbox-dark-medium t))



;; Minibuffer completion is essential to your Emacs workflow and
;; Vertico is currently one of the best out there. There's a lot to
;; dive in here so I recommend checking out the documentation for more
;; details: https://elpa.gnu.org/packages/vertico.html. The short and
;; sweet of it is that you search for commands with "M-x do-thing" and
;; the minibuffer will show you a filterable list of matches.
(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  :init
  (vertico-mode))

;; Improve the accessibility of Emacs documentation by placing
;; descriptions directly in your minibuffer. Give it a try:
;; "M-x find-file".
(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

;; Adds intellisense-style code completion at point that works great
;; with LSP via Eglot. You'll likely want to configure this one to
;; match your editing preferences, there's no one-size-fits-all
;; solution.
;;(use-package corfu
;;  :ensure t
;;  :init
;;  (global-corfu-mode)
;;  :custom
;;  (corfu-auto t)
;;  ;; You may want to play with delay/prefix/styles to suit your preferences.
;;  (corfu-auto-delay 0)
;;  (corfu-auto-prefix 0)
;;  (completion-styles '(basic)))

;; Adds LSP support. Note that you must have the respective LSP
;; server installed on your machine to use it with Eglot. e.g.
;; rust-analyzer to use Eglot with `rust-mode'.
;;(use-package eglot
;;  :ensure t
;;  :bind (("s-<mouse-1>" . eglot-find-implementation)
;;         ("C-c ." . eglot-code-action-quickfix))
;;  ;; Add your programming modes here to automatically start Eglot,
;;  ;; assuming you have the respective LSP server installed.
;;  :hook ((web-mode . eglot-ensure))
;;  :config
;;  ;; You can configure additional LSP servers by modifying
;;  ;; `eglot-server-programs'. The following tells eglot to use TypeScript
;;  ;; language server when working in `web-mode'.
;;  (add-to-list 'eglot-server-programs
;;               '(web-mode . ("typescript-language-server" "--stdio"))))







;(use-package lsp-ui
;  :ensure t
;  :commands lsp-ui-mode)
(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))


(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))


(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode)
  (add-hook 'kotlin-mode-hook 'flycheck-mode)
  (add-hook 'kotlin-ts-mode-hook 'flycheck-mode)
  (flycheck-add-mode 'typescript-tslint 'web-mode))


(use-package company
  :ensure t
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1) 
  (global-company-mode))
(add-hook 'after-init-hook 'global-company-mode)

(use-package company-quickhelp
  :after company
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))



;; Add extra context to Emacs documentation to help make it easier to
;; search and understand. This configuration uses the keybindings 
;; recommended by the package author.
;(use-package helpful
;  :ensure t
;  :bind (("C-h f" . #'helpful-callable)
;         ("C-h v" . #'helpful-variable)
;         ("C-h k" . #'helpful-key)
;         ("C-c C-d" . #'helpful-at-point)
;         ("C-h F" . #'helpful-function)
;         ("C-h C" . #'helpful-command)))

;; Adds vim emulation. Activate `evil-mode' to swap your default Emacs
;; keybindings with the modal editor of great infamy. There's a ton of
;; keybindings that Evil needs to modify, so this configuration also
;; includes `evil-collection' to fill in the gaps.
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


(use-package lsp-mode
  :after evil
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-clients-clangd-args '("--header-insertion=never")) 
  :commands lsp
  :custom
  (lsp-enable-snippet t)
  :config (defun md/lsp-setup()
    ;; recommended by LSP docs for performance
    (setq read-process-output-max (* 1024 1024)) ;; 1mb

    (lsp-enable-imenu)
    (setq
          lsp-auto-configure t
          lsp-enable-dap-auto-configure nil ; Don't try to auto-enable dap: this creates a lot of binding clashes
          lsp-auto-guess-root t ; Uses projectile to guess the project root.
          lsp-before-save-edits t
          lsp-eldoc-enable-hover t
          lsp-eldoc-render-all nil
          lsp-completion-enable t
          lsp-completion-show-detail t
          lsp-completion-show-kind t
          lsp-enable-file-watchers t
          lsp-file-watch-threshold 100
          lsp-enable-folding t
          lsp-enable-imenu t
          lsp-enable-indentation t
          lsp-enable-links t
          lsp-clients-python-library-directories `("/usr/" ,(expand-file-name "~/.virtualenvs"), "./venv") ; This seems appropriate
          lsp-enable-on-type-formatting nil
          lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
          lsp-enable-symbol-highlighting nil
          lsp-enable-text-document-color nil
          lsp-enable-xref t
          lsp-flycheck-live-reporting nil
          lsp-idle-delay 0.1
          lsp-imenu-show-container-name t
          lsp-imenu-sort-methods '(position kind name)
          lsp-pyls-plugins-flake8-enabled t
          lsp-signature-auto-activate t
          lsp-signature-render-documentation t
          lsp-signature-doc-lines 10
          lsp-javascript-suggest-complete-function-calls t
          lsp-typescript-suggest-complete-function-calls t
          lsp-headerline-breadcrumb-enable nil)
    (lsp-register-custom-settings
     '(

       ("pyls.plugins.pyls_black.enabled" t t)
       ("pyls.plugins.pyls_isort.enabled" t t)

       ;; Disable these as they're duplicated by flake8
       ("pyls.plugins.pycodestyle.enabled" nil t)
       ("pyls.plugins.mccabe.enabled" nil t)
       ("pyls.plugins.pyflakes.enabled" nil t))))
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (web-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (c-mode . lsp-deferred)
         (c++-mode . lsp-deferred)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-before-initialize . md/lsp-setup))
  :bind (:map evil-normal-state-map
              ("gh" . lsp-describe-thing-at-point)
              ("gr" . lsp-find-references)
              ("gD" . lsp-find-implementation)
              ("gd" . lsp-find-definition)
              ;:map md/leader-map
              ("Ni" . imenu)
              ("Ff" . lsp-format-buffer)
              ("FR" . lsp-rename)))


;(defun my/lsp ()
;  (unless (eq major-mode <REPLACE-ME-WITH-MAJOR-MODE>)
;    (lsp)))

;; Treemacs stuff
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


;; Snippets
(use-package yasnippet                  ; Snippets
  :ensure t
  :config
  (yas-global-mode 1))

;(use-package yasnippet-snippets         ; Collection of snippets
;  :ensure t)


;; TypeScript, JS, and JSX/TSX support.
(load "config-web")
(load "config-c")


(use-package evil-multiedit
 :ensure t)

(use-package fzf
               :bind
                   ;; Don't forget to set keybinds!
                     :config
                       (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
                                     fzf/executable "fzf"
                                             fzf/git-grep-args "-i --line-number %s"
                                                     ;; command used for `fzf-grep-*` functions
                                                             ;; example usage for ripgrep:
                                                                     ;; fzf/grep-command "rg --no-heading -nH"
                                                                             fzf/grep-command "grep -nrH"
                                                                                     ;; If nil, the fzf buffer will appear at the top of the window
                                                                                             fzf/position-bottom t
                                                                                                     fzf/window-height 15))
(use-package undo-tree
  :ensure t
  :after evil
  :diminish
  :config
  (evil-set-undo-system 'undo-tree)
  (global-undo-tree-mode 1))


(defun toggle-tabs ()
  (interactive)
  (save-excursion
  (tab-line-mode)
  (message "Tabs!")))

(defun maybe-toggle-tabs ()
  (interactive)
  (save-excursion
  (if (bound-and-true-p tab-line-mode)
    (message "tabs already on")
  (toggle-tabs))))




(defun tabs-prev ()
  (interactive)
  (save-excursion
  (maybe-toggle-tabs)
  (tab-line-switch-to-prev-tab)
  ))

(defun tabs-next ()
  (interactive)
  (save-excursion
  (maybe-toggle-tabs)
  (tab-line-switch-to-next-tab)
  ))
;; Key-bindings
(evil-define-key 'treemacs treemacs-mode-map (kbd "r") #'treemacs-rename-file)
(evil-define-key 'treemacs treemacs-mode-map (kbd "yy") #'treemacs-copy-file)
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)
(global-set-key (kbd "M-1") 'tabs-prev)
(global-set-key (kbd "M-2") 'tabs-next)
(defun toggle-treemacs ()
  (interactive)
  (save-excursion
  (treemacs)
  (treemacs-add-and-display-current-project-exclusively)
  (message "Treemacs!")))



(global-set-key [f8] 'toggle-treemacs)
;;(global-set-key [f7] 'toggle-tabs)
(global-set-key [?\C-\=] 'text-scale-increase)
(global-set-key [?\C-\+] 'text-scale-increase)
(global-set-key [?\C-\-] 'text-scale-decrease)
(global-set-key (kbd "M-s") 'fzf-git)


(defun reload-init-file ()
  (interactive)
  (save-excursion
  (load-file user-init-file)
    (message "Reloaded init file.")))

;;
;; Multiedit
;;
;; Highlights all matches of the selection in the buffer.
(define-key evil-visual-state-map "R" 'evil-multiedit-match-all)
;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
;; incrementally add the next unmatched match.
(define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Match selected region.
(define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
;; Insert marker at point
;(define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

;; Same as M-d but in reverse.
(define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
(define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

;; OPTIONAL: If you prefer to grab symbols rather than words, use
;; `evil-multiedit-match-symbol-and-next` (or prev).

;; Restore the last group of multiedit regions.
(define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

;; RET will toggle the region under the cursor
; (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; ...and in visual mode, RET will disable all fields outside the selected region
(define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

;; For moving between edit regions
;(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
;(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
;(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
;(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defun my/do-then-quit (&rest args)
;  (let ((win (selected-window)))
;    (apply (car args) (rest args))
;    (quit-window nil win)))
;
;(advice-add #'xref-goto-xref :around #'my/do-then-quit)


;;;;;;;;;;;;;;;

(use-package restart-emacs
  :ensure t
	:config
	(setq restart-emacs-restore-frames t))


(require 'compile)

(add-to-list 'compilation-error-regexp-alist-alist
             '(my-search-program
               "^\\(/[^:]+\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3))

(add-to-list 'compilation-error-regexp-alist 'my-search-program)



(defun run-search-program (directory search-term)
  "Run the search_program executable with the specified DIRECTORY and SEARCH-TERM, and display the output in a buffer."
  (interactive "DDirectory: \nsSearch term: ")
  (let ((output-buffer (get-buffer-create "*Search Program Output*"))
        (command (format "/home/ianertson/workspace/qs/build/qs %s %s" directory search-term)))
    (with-current-buffer output-buffer
      (read-only-mode -1)
      (erase-buffer)
      (insert (format "Running command: %s\n\n" command))
      (let ((exit-code (call-process-shell-command command nil output-buffer)))
        (insert (format "\n\nProcess finished with exit code %d" exit-code))
        (read-only-mode 1))
      (compilation-mode))
    (display-buffer output-buffer)))

