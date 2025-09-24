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

;(evil-define-key 'lsp-bridge evil-normal-state-map (kbd "gD") #'lsp-bridge-find-def)
;(evil-define-key 'treemacs treemacs-mode-map (kbd "yy") #'treemacs-copy-file)
(define-key evil-normal-state-map (kbd "gd") 'lsp-find-definition)


; :bind (:map evil-normal-state-map
;              ("gh" . lsp-describe-thing-at-point)
;              ("gr" . lsp-find-references)
;              ("gD" . lsp-find-implementation)
;              ("gd" . lsp-find-definition)
;              ;:map md/leader-map
;              ("Ni" . imenu)
;              ("Ff" . lsp-format-buffer)
;              ("FR" . lsp-rename)))

;; For moving between edit regions
;(define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
;(define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
;(define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
;(define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
(evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

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

(defun my/treemacs-after-create-file-advice (&rest _)
  "Restart lsp-bridge after creating a file in treemacs."
  (run-at-time
   "0.1 sec" nil
   (lambda ()
     (when buffer-file-name
       (lsp-bridge-restart-process)))))

(advice-add 'treemacs-create-file :after #'my/treemacs-after-create-file-advice)

(provide 'keybinds)
