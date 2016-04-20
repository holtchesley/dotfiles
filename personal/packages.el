
;;; packages.el --- personal Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Brennan Chesley
;; Copyright (c) 2014-2015 Brennan Chesley
;;
;; Author: Brennan Chesley <thecrunchy@gmail.com>
;;
;; This file is not part of GNU Emacs.

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(defvar personal-pre-extensions
      '(restclient))

(setq personal-packages
      '(
        ob-restclient
        uuidgen
      ))

;; List of packages to exclude.
(setq personal-excluded-packages '())

;; For each package, define a function personal/init-<package-name>
;;
;; (defun personal/init-my-package ()
;;   "Initialize my package"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
(defun personal/init-ob-restclient ()
  (use-package ob-restclient
    :defer t
    :config
    (org-babel-do-load-languages 'org-babel-load-languages '((restclient . t)))
    ))

(defun personal/init-uuidgen ()
  (use-package uuidgen))
