

; (defun insert-newline-and-indent-for-brace ()
;  "Insert a newline and, if the previous character is a '{', add two spaces, a newline, and ensure proper indentation."
;  (interactive)
;  (newline-and-indent) ; Inserts a newline and indents according to the current mode
;  (let ((prev-char (char-before (1- (point)))))
;    (when (and prev-char (char-equal prev-char ?{))
;      (insert "  ") ; Inserts two spaces
;      (save-excursion
;        (newline-and-indent) ; Inserts another newline and indents
;        (insert "}") ; Inserts the closing brace
;        (indent-for-tab-command))))) ; Correctly indents the closing brace


(defun count-spaces ()
  "Count the number of spaces from the start of the current line to the first non-space character."
  (save-excursion
    (beginning-of-line)
    (let ((start (point)))
      (skip-chars-forward " ")
      (- (point) start))))


(defun count-spaces-at (line-number)
  "Count the number of spaces from the start of the line specified by LINE-NUMBER."
  (interactive "nEnter line number: ")
  (save-excursion
    (goto-line line-number)
    (beginning-of-line)
    (let ((start (point)))
      (skip-chars-forward " ")
      (- (point) start))))

(defun is-prev-all-spaces ()
  "Check if the line above the cursor contains only spaces."
  (interactive)
  (save-excursion
    (forward-line -1) ; Move to the previous line
    (let ((line-start (line-beginning-position))
          (line-end (line-end-position)))
      (string-match-p "^[[:space:]]*$" (buffer-substring line-start line-end)))))


(defun my-indent ()
 (interactive)
 (message "bepa")
        (insert "\n\n")
        (forward-char -1)
        (dotimes ( i (current-column) )
        (insert " "))
        (forward-char -1)
        (insert "  ") )

(defun my-indent2 ()
 (interactive)
 (message "bepa")
        (let ((oldindent (count-spaces)) (oldcol (current-column)) (oldline (line-number-at-pos)))
        (insert "\n")
        (dotimes ( i oldindent )
        (insert " "))
        (goto-line oldline)
        (move-to-column oldcol)
        (insert "\n")
        (dotimes ( i (if (<= oldindent 0) 2 (+ 2 oldindent)) )
        (insert " "))
 (message "bepa")
        ))
(defun insert-newline-and-indent-for-brace ()
  "Insert a newline and, if the previous or current character is a '{', add two spaces, a newline, and ensure proper indentation."
  (interactive)
;  (newline-and-indent) ; Inserts a newline and indents according to the current mode
  (let ( (spaces-above (count-spaces-at (- (line-number-at-pos) 1))) (prev-char (char-before (1- (point))))
        (current-char (following-char)))

    (if (or (not (or (and (is-prev-all-spaces) (> spaces-above 1)) (looking-at "}") (looking-at "{"))))

(electric-indent-just-newline 1))

(if (looking-at "}")
  (my-indent2)
)
(interactive (insert "\n")
(dotimes ( i spaces-above )
        (insert " ")))
)

        

        )







(with-eval-after-load 'evil-maps
  (define-key evil-insert-state-map (kbd "RET") 'insert-newline-and-indent-for-brace)) 


;; default
(define-key evil-insert-state-map (kbd "RET") 'insert-newline-and-indent-for-brace)
;; for other mode
(evil-define-key 'insert 'c-mode-map (kbd "RET") 'insert-newline-and-indent-for-brace)
