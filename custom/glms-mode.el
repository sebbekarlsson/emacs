(setq glms-font-lock-keywords
      (let* (
            ;; define several category of keywords
            (x-keywords '("typedef" "break" "while" "for" "return" "for" "if" "else" "switch" "import" "as" "readonly" "uniform"))
            (x-types '("file" "bool" "enum" "struct" "function" "number" "object" "string" "array" "image" "layout" "buffer" "vec2" "vec3" "vec4" "iterator" "int" "float" "sampler2D" "sampler3D" "samplerCube" "void" "json" "response"))
            (x-constants '("PI" "TAU" "true" "false" "null"))
            (x-functions 
              '(
                "fetch"
                "print"
                "cos"
                "sin"
                "tan"
                "atan"
                "fract"
                "smoothstep"
                "mat4"
                "mat3"
                "cross"
                "dot"
                "lerp"
                "mix"
                "log"
                "log10"
                "pow"
                "sqrt"
                "normalize"
                "unit"
                "clamp"
                "max"
                "min"
                "abs"
                "distance"
                "length"
                "perspective"
                "ortho"
                "quatFor"
                "cantor"
                "decant"
                ))

            ;; generate regex string for each category of keywords
            (x-keywords-regexp (regexp-opt x-keywords 'words))
            (x-types-regexp (regexp-opt x-types 'words))
            (x-constants-regexp (regexp-opt x-constants 'words))
            (x-functions-regexp (regexp-opt x-functions 'words)))

        `(
          (,x-types-regexp . 'font-lock-type-face)
          (,x-constants-regexp . 'font-lock-constant-face)
          (,x-functions-regexp . 'font-lock-function-name-face)
          (,x-keywords-regexp . 'font-lock-keyword-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

;;;###autoload
(define-derived-mode glms-mode c-mode "glms mode"
  "Major mode for editing GLMS"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((glms-font-lock-keywords))))

(add-to-list 'auto-mode-alist '("\\.gs\\'" . glms-mode))

(provide 'glms-mode)
