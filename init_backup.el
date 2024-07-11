(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;(require 'mmm-auto)

(add-to-list 'load-path "~/.emacs.d/custom")

;(setq mmm-global-mode 'maybe)
;(mmm-add-mode-ext-class 'kotlin-mode "\\.kt\\'" 'tree-sitter-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(connection-local-criteria-alist
   '(((:application eshell)
      eshell-connection-default-profile)
     ((:application tramp :protocol "kubernetes")
      tramp-kubernetes-connection-local-default-profile)
     ((:application tramp :protocol "flatpak")
      tramp-container-connection-local-default-flatpak-profile tramp-flatpak-connection-local-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile
      (eshell-path-env-list))
     (tramp-flatpak-connection-local-default-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-kubernetes-connection-local-default-profile
      (tramp-config-check . tramp-kubernetes--current-context-data)
      (tramp-extra-expand-args 97
                               (tramp-kubernetes--container
                                (car tramp-current-connection))
                               104
                               (tramp-kubernetes--pod
                                (car tramp-current-connection))
                               120
                               (tramp-kubernetes--context-namespace
                                (car tramp-current-connection))))
     (tramp-container-connection-local-default-flatpak-profile
      (tramp-remote-path "/app/bin" tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin"))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state=abcde" "-o" "ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . tramp-ps-time)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o" "pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "stat=abcde" "-o" "ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (user . string)
       (group . string)
       (comm . 52)
       (state . 5)
       (ppid . number)
       (pgrp . number)
       (ttname . string)
       (time . tramp-ps-time)
       (nice . number)
       (etime . tramp-ps-time)
       (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o" "pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "-o" "state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format
       (pid . number)
       (euid . number)
       (user . string)
       (egid . number)
       (group . string)
       (comm . 52)
       (state . string)
       (ppid . number)
       (pgrp . number)
       (sess . number)
       (ttname . string)
       (tpgid . number)
       (minflt . number)
       (majflt . number)
       (time . tramp-ps-time)
       (pri . number)
       (nice . number)
       (vsize . number)
       (rss . number)
       (etime . number)
       (pcpu . number)
       (pmem . number)
       (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh")
      (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":")
      (null-device . "/dev/null"))))
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(lsp-enable-on-type-formatting nil)
 '(package-selected-packages
   '(nil yaml-mode dired-git-info magit kotlin-mode lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'gruvbox-dark-medium t)

(set-frame-font "DejaVu Sans Mono 12" nil t)



(require 'evil)
(evil-mode 1)

(require 'evil-mc)
(global-evil-mc-mode  1)

(require 'evil-multiedit)
(evil-multiedit-default-keybinds)

(require 'find-file-in-project)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
                                           projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)



(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'kotlin-mode-hook 'lsp)
(add-hook 'kotlin-ts-mode-hook 'lsp)
;(add-hook 'vue-mode 'lsp)
(add-hook 'web-mode-hook 'lsp)
;(add-hook 'mmm-mode 'lsp)


(setq lsp-enable-on-type-formatting nil)


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode)
  (setq lsp-enable-on-type-formatting nil))


(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


(global-display-line-numbers-mode)

(set-face-foreground 'vertical-border
                     (face-background 'vertical-border nil t))


;(defun include-paths ()
;  (setq flycheck-clang-include-path (list 
;                                     
;                                     (expand-file-name "./_deps/*/include")
;                                     (expand-file-name "./build/_deps/*/include")
;                                     
;
;                                     )))
;
;(add-hook 'c++-mode-hook 'include-paths)


(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode)
  (add-hook 'kotlin-mode-hook 'flycheck-mode)
  (add-hook 'kotlin-ts-mode-hook 'flycheck-mode))

(use-package company
  :ensure t
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

(require 'shader-mode)

;; uniquify changes conflicting buffer names from file<2> etc
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

(require 'web-mode)
;(require 'vue-mode)
(require 'lsp-mode)

(load "web")
(load "kot")
(load "opts")
(load "treemacs-config")
(load "package-manage")
(load "key-bind")
(require 'glms-mode)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '(("~/workspace/" . 1))))


(add-to-list 'image-types 'svg)
;
;(setq vue-mode-packages
;  '(vue-mode lsp-mode web-mode))
;
;(setq vue-mode-excluded-packages '())
;
;
;(defun vue-mode/init-vue-mode ()
;  (use-package vue-mode
;               :config
;               ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
;               (setq mmm-submode-decoration-level 0)))
;
;(add-hook 'mmm-mode-hook
;          (lambda ()
;            (set-face-background 'mmm-default-submode-face nil)))


;; I use Kotlin mode, not perfect, but works. Just start LSP when Kotlin mode starts.
;; hook keyword replaces (add-to-list 'kotlin-mode-hook 'lsp)
;; You can omit the hook and start lsp manually with M-x lsp if you want.
(use-package kotlin-mode
  :hook
  (kotlin-mode . lsp))


;; [2020-05-17 Sun] Disabling to prevent (lsp--auto-configure) from calling (lsp-ui-mode)
(use-package lsp-ui
  :disabled)

(use-package lsp-mode
  :demand t
  :config
  (defun md/lsp-setup()
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
          lsp-headerline-breadcrumb-enable nil)
    (lsp-register-custom-settings
     '(

       ("pyls.plugins.pyls_black.enabled" t t)
       ("pyls.plugins.pyls_isort.enabled" t t)

       ;; Disable these as they're duplicated by flake8
       ("pyls.plugins.pycodestyle.enabled" nil t)
       ("pyls.plugins.mccabe.enabled" nil t)
       ("pyls.plugins.pyflakes.enabled" nil t))))
  :hook
   ;; NOTE: we don't have a python-mode hook - it gets handled by pyvenv-track-virtualenv
  (;;(js-mode . lsp)
   ;;(web-mode . lsp)
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



(add-hook 'c-mode-hook
          (lambda ()
            (set 'c-electric-flag t)))

(add-hook 'c++-mode-hook
          (lambda ()
            (set 'c-electric-flag t)))


;(setq electric-indent-chars (remq ?\{ electric-indent-chars))

;(add-hook 'c-mode-hook
;          (lambda ()
;            (setq-local electric-indent-chars (remq ?\{ electric-indent-chars))))





(require 'c99-style)
;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" c99-style)
  ;; other customizations
  (setq tab-width 2)
  ;; keybindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map "\M-a" 'backward-sexp)
  (define-key c-mode-base-map "\M-e" 'forward-sexp)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(setq c++-mode-hook
      '(lambda ()
         (font-lock-mode 1)
         ))
