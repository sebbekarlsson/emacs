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
               :config (yas-global-mode 1))

;(use-package company
;               :config
;                 (setq company-idle-delay 0.2
;                               company-minimum-prefix-length 1)
;                 (global-company-mode 1))


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
(define-key evil-normal-state-map (kbd "gd") 'lsp-bridge-find-def)


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


(provide 'packages)

