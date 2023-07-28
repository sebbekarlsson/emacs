(setq warning-minimum-level :error)
(setq-default indent-tabs-mode nil)

(add-hook 'after-change-major-mode-hook 
          '(lambda () 
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 2)
             (setq tab-width 2)))


(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))


(add-hook 'js-json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq tab-width 2)
            (setq js-indent-level 2)))



(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))


(setq use-short-answers t)
(setq confirm-nonexistent-file-or-buffer nil)

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)



(setq lsp-warn-no-matched-clients nil)
(setq neo-confirm-create-file 'off-p)
(setq neo-confirm-delete-file 'off-p)
(setq neo-confirm-delete-directory-recursively 'off-p)
(setq neo-confirm-create-directory 'off-p)


(setq lsp-clients-clangd-args '("--header-insertion=never"))

(setq create-lockfiles nil)
