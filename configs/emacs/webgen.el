;; Define a new major mode for the language
(define-derived-mode webgen-mode prog-mode "Webgen"
  "Major mode for editing Webgen files."
  ;; Syntax highlighting rules
  (setq font-lock-defaults '(webgen-font-lock-keywords)))

;; Highlighting tags
(defvar webgen-font-lock-keywords
  '(("^\\.[a-zA-Z]*" . 'font-lock-keyword-face)))

;; Define the face for the matched patterns
(defface font-lock-keyword-face
  '((t (:foreground "blue" :weight bold)))
  "Face for highlighting tags")

;; Add the major mode to the auto-mode-alist
(add-to-list 'auto-mode-alist '("\\.wg\\'" . webgen-mode))

;; Export so that we can just (require 'webgen-mode)
(provide 'webgen-mode)
