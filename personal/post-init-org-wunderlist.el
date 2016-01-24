(setq org-wunderlist-client-id "f716323cd603aac64853"
      org-wunderlist-token "9b85f921c83faeefba386495c3d55c4b0528bf82c9a1d4647d7d15d40431"
      org-wunderlist-file  "~/journal/Wunderlist.org"
      org-wunderlist-dir "~/journal/org-wunderlist/")



(require 'request)

(setq wunder-headers
      '(("X-Client-ID" "f716323cd603aac64853")
        ("X-Access-Token" "577f7ba6367dc123ea70ebc256dffee58fc958ebdd5c7f478ce41dcbe661")))

(request "https://a.wunderlist.com/api/v1/tasks"
         :headers wunder-headers
         :error (function* (lambda (&key response &allow-other-keys)
                              (progn (print "\n\nError")
                                     (whats-down response))))
         :success (function* (lambda (&key data &allow-other-keys)
                                (progn (print "\n\n")
                                       (setq whuts-up data))))
         :sync t)

(print "test")

(print whuts-up)
(print whats-down)
