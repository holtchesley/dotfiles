(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/journal/goals.org" "Captured")
         "*** TODO %?\n %i\n %a")))

(defun personal-refile-to (file headline)
  "Move current headline to specified location"
  (org-mark-ring-push)
  (let ((pos (save-excursion
               (find-file file)
               (org-find-exact-headline-in-buffer headline))))
    (org-refile nil nil (list headline file nil pos)))
  (org-mark-ring-goto)
  )

(defun personal-do-within-a-week ()
  "File to do next week"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Within a week"))

(defun personal-do-as-a-monthly ()
  "File to do as a monnthly"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Monthlies"))

(defun personal-do-eventually ()
  "File to do eventually"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Eventually"))

(defun personal-do-read-book ()
  "File to read sometime"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Books to read"))

(defun personal-do-today ()
  "File to do today"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Today"))

(defun personal-do-habit ()
  "File to do as a habit"
  (interactive)
  (personal-refile-to "~/journal/goals.org" "Habits"))

(defun personal-archive-done-in-subtree ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'tree))

(defun personal-list-props ()
  (interactive)
  (message "%s" (org-entry-properties)))

(defmacro -> (&rest body)
  (let ((result (pop body)))
    (dolist (form body result)
      (setq result (append (list (car form) result)
                           (cdr form))))))

(defun personal-get-todo-info ()
  (interactive)
  (let ((todo-info
         (-> '()
             (plist-put "client-id"      (org-entry-get (point) "WUN-CLIENT-ID" t nil))
             (plist-put "access-token"   (org-entry-get (point) "WUN-ACCESS-TOKEN" t nil))
             (plist-put "list-id"        (org-entry-get (point) "WUN-LIST-ID" t nil))
             (plist-put "task-id"        (org-entry-get (point) "WUN-TASK-ID" t nil))
             (plist-put "scheduled-time" (let ((tdate (org-get-scheduled-time (point))))
                                           (if tdate (iso-8601-format tdate) nil)))
             (plist-put "title"          (replace-regexp-in-string "^\*+ " "" (org-entry-get (point) "ITEM" t nil))))))
    (message "%s" todo-info)))

(defun iso-8601-format (time)
   (concat
    (format-time-string "%Y-%m-%dT%T" time)
    ((lambda (x) (concat (substring x 0 3) ":" (substring x 3 5)))
     (format-time-string "%z" time))))


(replace-regexp-in-string "^\*+ " "" "** Take out Garbage")

(cdr (assoc "foo" '(("foo" . "bar"))))
