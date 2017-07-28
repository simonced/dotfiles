
;;; If the diary folder is not available, you'll have to create it with 'make-directory
;;; after calling ced/diary-open-today for the first time
(setq ced-diary-folder "~/diary/")

(setq ced-diary-default-content "#+STARTUP: showeverything

* Email (draft)

Subject: 作業の報告

大河原様

今日の作業の報告です。



* Notes

")


(defun ced/diary-open-today ()
  "Open the diary file of the current day.
If already opened, switch to it.
If not, opens it from disk.
If not available, create it."
  (interactive)
  (ced/diary-open-date (ced/diary-get-date-today))
  )


(defun ced/diary-open-yesterday ()
  "Open the diary file of the current day.
If already opened, switch to it.
If not, opens it from disk.
If not available, create it."
  (interactive)
  (ced/diary-open-date (ced/diary-get-date-yesterday))
  ;; TODO NOT ONLY for yesterday buffer!
  (read-only-mode t)
  )


(defun ced/diary-open-date (date_)
  "Date_ format: YYYY-MM-DD
If nil, today's date is automatically used."
  (let ((diary-file (ced/diary-make-filename date_)))
	;; (switch-to-buffer today-file)
	(find-file diary-file)
	;; if last position and top position are the same, we init with default content
	(when (= (point-min) (point-max))
	  (message "empty page! init TODO")
	  (ced/diary-make-default-content)
	  )
	(end-of-buffer)
	)
  )


(defun ced/diary-get-date-today ()
  "Simply returns today's date with format: YYYY-MM-DD"
  (format-time-string "%F" nil)
  )


(defun ced/diary-get-date-yesterday ()
  "Simply returns today's date with format: YYYY-MM-DD"
  (format-time-string "%F" (time-subtract (current-time) 86400))
  )


(defun ced/diary-make-default-content ()
  "Simply append some default content (like org capture) in the diary page"
  (insert ced-diary-default-content)
  )


(defun ced/diary-make-filename (date_)
  "Simply prepares the name of the diary file."
  ;; maybe I should check the format of date_ ?
  (let ((date date_))
	(when (not date) (setq date (ced/diary-get-date-today)))
	(concat ced-diary-folder (format "page_%s.org" date)))
  )
