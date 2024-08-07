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
(global-set-key (kbd "M-s") 'find-file-in-project)

(defun reload-init-file ()
  (interactive)
  (save-excursion
  (load-file user-init-file)
    (message "Reloaded init file.")))
(global-set-key (kbd "C-c C-l") 'reload-init-file)
