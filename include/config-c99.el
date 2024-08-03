(require 'style-c99)
;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" style-c99)
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
