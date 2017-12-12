;;; C’est mon buffer e-lisp par default.
;;; Il n’est pas sauvegarde! Faire attention ;)

(defun ced/getPageTitle (url)
  (interactive)
  "Fetch page title of page at given URL"
 
  (switch-to-buffer (url-retrieve-synchronously url))
  (goto-char (point-min))
  (re-search-forward "<title>\\(.*?\\)</title>")
  (let ((text (match-string-no-properties 1)))
	(kill-this-buffer)
	;; do something with the encoding!
	(mm-decode-string text "utf-8")
	)
  )

;;; testing our thing
(message (ced/getPageTitle "http://www.ritoushien.net"))

