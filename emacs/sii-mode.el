;; a simple major mode, sii-mode
;; still has issues with comments containing "strings"

(setq sii-highlights
      '(("#.*" . font-lock-comment-face)
		(".*?:" . font-lock-function-name-face)))


(define-derived-mode sii-mode fundamental-mode "sii"
  "major mode for editing mymath language code."
  (setq font-lock-defaults '(sii-highlights)))
