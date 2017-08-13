;; a simple major mode, sii-mode
;; still has issues with comments containing "strings"


(defvar sii-mode-syntax-table nil "Syntax table for `sii-mode'.")


(setq sii-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?# "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))


(setq sii-highlights
      '((".*?:" . font-lock-variable-name-face)))


(define-derived-mode sii-mode fundamental-mode "sii"
  "major mode for editing mymath language code."
  (setq font-lock-defaults '(sii-highlights))
  (set-syntax-table sii-mode-syntax-table)
  )
