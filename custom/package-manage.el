(defun x-package-install-init ()
 (let ((packages (append (mapcar 'car package-alist)
                         (mapcar 'car package-archive-contents)
                         (mapcar 'car package--builtins))))
   (mapcar (lambda (pkg)
             (let* ((desc (or
                           (if (package-desc-p pkg) pkg)
                           (cadr (assq pkg package-alist))
                           (let ((built-in (assq pkg package--builtins)))
                             (if built-in
                                 (package--from-builtin built-in)
                               (cadr (assq pkg package-archive-contents))))))
                    (summary (if desc (package-desc-summary desc) "")))
               (cons (format "%-24s %s" pkg summary) (symbol-name pkg))))
           packages)))

(defun x-package-install ()
 (interactive)
 (package-install
  (helm
   :sources
   (helm-build-sync-source "Install Package"
     :candidates #'x-package-install-init
     :candidate-number-limit 9999
      :coerce #'intern))))
