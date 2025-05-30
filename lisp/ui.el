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



;; Key-bindings
(evil-define-key 'treemacs treemacs-mode-map (kbd "r") #'treemacs-rename-file)
(evil-define-key 'treemacs treemacs-mode-map (kbd "yy") #'treemacs-copy-file)
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)
(defun toggle-treemacs ()
    (interactive)
      (save-excursion
          (treemacs)
            (treemacs-add-and-display-current-project-exclusively)
              (message "Treemacs!")))

(global-set-key [f8] 'toggle-treemacs)
(global-set-key [?\C-\=] 'text-scale-increase)
(global-set-key [?\C-\+] 'text-scale-increase)
(global-set-key [?\C-\-] 'text-scale-decrease)

(provide 'ui)

