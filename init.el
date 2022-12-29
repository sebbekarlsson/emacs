(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


(add-to-list 'load-path "~/.emacs.d/custom")
(require 'glms-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(package-selected-packages
   '(company-glsl lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'gruvbox-dark-medium t)

(set-frame-font "DejaVu Sans Mono 12" nil t)

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(require 'evil)
(evil-mode 1)

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-changedir)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)

(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)



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

(setq lsp-warn-no-matched-clients nil)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)


(setq gc-cons-threshold (* 100 1024 1024)
            read-process-output-max (* 1024 1024)
                  treemacs-space-between-root-nodes nil
                        company-idle-delay 0.0
                              company-minimum-prefix-length 1
                                    lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
                        (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
                          (require 'dap-cpptools)
                            (yas-global-mode))


(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq use-short-answers t)
(setq confirm-nonexistent-file-or-buffer nil)

(setq inhibit-startup-message t
            inhibit-startup-echo-area-message t)

(global-display-line-numbers-mode)

(set-face-foreground 'vertical-border
  (face-background 'vertical-border nil t))


(global-set-key [?\C-\+] 'text-scale-increase)
(global-set-key [?\C-\=] 'text-scale-increase)
(global-set-key [?\C-\-] 'text-scale-decrease)


(defun reload-init-file ()
    (interactive)
      (load-file user-init-file))

(global-set-key (kbd "C-c C-l") 'reload-init-file)    ; Reload .emacs file
