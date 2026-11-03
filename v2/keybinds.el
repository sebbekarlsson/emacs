;;; keybinds.el --- Keybindings -*- lexical-binding: t; -*-
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

;; After `restart-emacs', reopen the buffer you were in at the same cursor
;; position. Only a restart saves this, so a normal quit + start is unaffected.
(defvar my/restart-session-file
  (expand-file-name ".cache/restart-session.eld" user-emacs-directory)
  "Where `restart-emacs' leaves the buffer and cursor position to reopen.")

(defvar my/restart-session-state nil
  "Buffer and cursor position to write out while `restart-emacs' is running.")

(defun my/restart-session-capture (orig &rest args)
  "Note the selected buffer and cursor position, then call ORIG with ARGS."
  (let* ((win (selected-window))
         (file (with-current-buffer (window-buffer win)
                 (or buffer-file-name
                     (and (derived-mode-p 'dired-mode) default-directory)))))
    (setq my/restart-session-state
          (and file (list :file file
                          :point (window-point win)
                          :start (window-start win))))
    (unwind-protect
        (apply orig args)
      ;; Only reached if the restart didn't happen (e.g. cancelled at a prompt).
      (setq my/restart-session-state nil))))

(defun my/restart-session-save ()
  "Write `my/restart-session-state' to disk if a restart is in progress."
  (when my/restart-session-state
    (make-directory (file-name-directory my/restart-session-file) t)
    (with-temp-file my/restart-session-file
      (prin1 my/restart-session-state (current-buffer)))))

(defun my/restart-session-restore ()
  "Reopen the buffer and cursor position saved by the last `restart-emacs'."
  (when (file-exists-p my/restart-session-file)
    (let ((state (ignore-errors
                   (with-temp-buffer
                     (insert-file-contents my/restart-session-file)
                     (read (current-buffer))))))
      (delete-file my/restart-session-file)
      (let ((file (plist-get state :file)))
        (when (and file (file-exists-p file))
          (find-file file)
          (goto-char (min (plist-get state :point) (point-max)))
          (set-window-start (selected-window)
                            (min (plist-get state :start) (point-max))))))))

(advice-add 'restart-emacs :around #'my/restart-session-capture)
(add-hook 'kill-emacs-hook #'my/restart-session-save)
(add-hook 'emacs-startup-hook #'my/restart-session-restore)

(provide 'keybinds)
