;(global-set-key (kbd "<M-D>") nil)
;(global-unset-key (kbd "<M-D>"))

;(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
;(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-changedir)
;(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
;(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
;(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
;(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
;(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
;(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
;(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
;(evil-define-key 'normal neotree-mode-map (kbd "D") 'neotree-delete-node)
;(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
;(evil-define-key 'normal neotree-mode-map (kbd "yy") 'neotree-copy-node)


(evil-define-key 'treemacs treemacs-mode-map (kbd "r") #'treemacs-rename-file)
(evil-define-key 'treemacs treemacs-mode-map (kbd "yy") #'treemacs-copy-file)


;(global-set-key (kbd "<M-n>") 'evil-mc-make-and-goto-next-match)
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)

                                        ;(global-set-key (kbd "<M-l>") 'neotree-toggle)

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

(global-set-key (kbd "C-c C-l") 'reload-init-file)    ; Reload .emacs file
