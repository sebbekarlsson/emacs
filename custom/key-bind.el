;(global-set-key (kbd "<M-D>") nil)
;(global-unset-key (kbd "<M-D>"))

(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-changedir)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "c") 'neotree-create-node)
(evil-define-key 'normal neotree-mode-map (kbd "D") 'neotree-delete-node)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-rename-node)
(evil-define-key 'normal neotree-mode-map (kbd "yy") 'neotree-copy-node)

;(global-set-key (kbd "<M-n>") 'evil-mc-make-and-goto-next-match)
(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)

(global-set-key (kbd "<M-l>") 'neotree-toggle)
(global-set-key [f8] 'neotree-toggle)

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

(global-set-key (kbd "C-c C-l") 'reload-init-file)    ; Reload .emacs file


 ;  (:when (modulep! :editor multiple-cursors)
 ;     :prefix "gz"
 ;     :nv "d" #'evil-mc-make-and-goto-next-match
 ;     :nv "D" #'evil-mc-make-and-goto-prev-match
 ;     :nv "s" #'evil-mc-skip-and-goto-next-match
 ;     :nv "S" #'evil-mc-skip-and-goto-prev-match
 ;     :nv "c" #'evil-mc-skip-and-goto-next-cursor
 ;     :nv "C" #'evil-mc-skip-and-goto-prev-cursor
 ;     :nv "j" #'evil-mc-make-cursor-move-next-line
 ;     :nv "k" #'evil-mc-make-cursor-move-prev-line
 ;     :nv "m" #'evil-mc-make-all-cursors
 ;     :nv "n" #'evil-mc-make-and-goto-next-cursor
 ;     :nv "N" #'evil-mc-make-and-goto-last-cursor
 ;     :nv "p" #'evil-mc-make-and-goto-prev-cursor
 ;     :nv "P" #'evil-mc-make-and-goto-first-cursor
 ;     :nv "q" #'evil-mc-undo-all-cursors
 ;     :nv "t" #'+multiple-cursors/evil-mc-toggle-cursors
 ;     :nv "u" #'+multiple-cursors/evil-mc-undo-cursor
 ;     :nv "z" #'+multiple-cursors/evil-mc-toggle-cursor-here
 ;     :v  "I" #'evil-mc-make-cursor-in-visual-selection-beg
 ;     :v  "A" #'evil-mc-make-cursor-in-visual-selection-end)





;;; neotree
;(:after neotree
;  :map neotree-mode-map
;  "q"     #'neotree-hide
;  "RET"   #'neotree-enter
;  "SPC"   #'neotree-quick-look
;  "v"     #'neotree-enter-vertical-split
;  "s"     #'neotree-enter-horizontal-split
;  "c"     #'neotree-create-node
;  "D"     #'neotree-delete-node
;  "g"     #'neotree-refresh
;  "r"     #'neotree-rename-node
;  "R"     #'neotree-refresh
;  "h"     #'+neotree/collapse-or-up
;  "l"     #'+neotree/expand-or-open
;  "n"     #'neotree-next-line
;  "p"     #'neotree-previous-line
;  "N"     #'neotree-select-next-sibling-node
;  "P"     #'neotree-select-previous-sibling-node)
;

;(:when (modulep! :ui neotree)
;        :desc "Project sidebar"              "p" #'+neotree/open
;        :desc "Find file in project sidebar" "P" #'+neotree/find-this-file)
