;;; core.el --- Core bootstrap -*- lexical-binding: t; -*-
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; The cached archive index goes stale: MELPA rebuilds packages and deletes the
;; old tarballs, so installing from an old index 404s. On failure, refresh the
;; index once and retry (by name, so the fresh version is picked up).
(define-advice package-install (:around (orig pkg &rest args) refresh-and-retry)
  (condition-case nil
      (apply orig pkg args)
    (error
     (package-refresh-contents)
     (apply orig (if (package-desc-p pkg) (package-desc-name pkg) pkg) args))))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(provide 'core)
