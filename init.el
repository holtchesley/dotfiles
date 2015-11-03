(require 'cask "/usr/local/Cellar/cask/0.7.2/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ido-mode t)
(setq ido-enable-flex-matching t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places")
      backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))



(require 'use-package)

(fset 'yes-or-no-p 'y-or-n-p)

(load-theme 'cyberpunk t)
(set-cursor-color "yellow")

(progn
  (windmove-default-keybindings)
  (global-set-key (kbd "C-c e") 'eval-and-replace)
  (global-set-key (kbd "C-c t b") 'untabify-buffer)
  (global-set-key (kbd "C-c t r") 'untabify)
  (global-set-key (kbd "M-/") 'comment-or-uncomment-region)
  (global-set-key (kbd "C-x g") 'magit-status)
  )

(require 'company)
(setq company-idle-delay 0.2)
(setq company-minmum-prefix-length 2)
(global-company-mode)

(use-package dash)
(require 'dash)

(use-package smex
  :init
  (progn
    (smex-initialize))
  :bind
  (("M-x" . smex)
   ("M-X" . smex-major-mode-commands)))


(use-package yasnippet
  :config
  (progn
    (setq yas-snippet-dirs `("~/.emacs.d/snippets/"))
    (yas-global-mode 1)))


(use-package volatile-highlights)


(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))


(use-package multiple-cursors
  :bind 
   (("C-c m a" . mc/mark-all-like-this)
    ("C-c m m" . mc/mark-all-like-this-dwim)
    ("C-c m l" . mc/edit-lines)
    ("C-c m n" . mc/mark-next-like-this)
    ("C-c m p" . mc/mark-previous-like-this)
    ("C-c m s" . mc/mark-sgml-tag-pair)
    ("C-c m d" . mc/mark-all-like-this-in-defun)))


(use-package git-gutter
  :bind (("C-c g g" . git-gutter:toggle)
         ("C-c g p" . git-gutter:previous-diff)
         ("C-c g n" . git-gutter:next-diff)
         ("C-c g d" . git-gutter:popup-diff)
         ("C-c g r" . git-gutter:revert-hunk))
  :config
  (progn
    (setq git-gutter:window-width 2)
    (setq git-gutter:lighter " G-+")
    (setq git-gutter:modified-sign "~ ")
    (setq git-gutter:added-sign "+ ")
    (setq git-gutter:deleted-sign "- ")
    (setq git-gutter:unchanged-sign "  ")
    (global-git-gutter-mode t)))


(use-package ace-jump-mode)

(use-package yaml-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
    (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))))

(use-package ruby-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode)))
  :config
  (progn
    (defun ruby-interpolate ()
  "In a double quoted string, interpolate."
  (interactive)
  (insert "#")
  (let ((properties (text-properties-at (point))))
    (when (and
           (memq 'font-lock-string-face properties)
           (save-excursion
             (ruby-forward-string "\"" (line-end-position) t)))
      (insert "{}")
      (backward-char 1))))

    (add-hook 'ruby-mode-hook
              '(lambda ()
                 (outline-minor-mode)
                 (setq outline-regexp " *\\(def \\|class\\|module\\|describe \\|it \\)")))

    (add-hook 'ruby-mode-hook
              (lambda ()
                (define-key ruby-mode-map "{" nil)
                (define-key ruby-mode-map "}" nil)))))

(use-package markdown-mode
  :init
  (progn
    (add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))))

(use-package js2-mode)

(use-package magit
  :config
  (progn
    (add-hook 'magit-log-edit-mode-hook
          (lambda ()
             (set-fill-column 72)
             (auto-fill-mode 1)))))


(defun sudo-edit (&optional arg)
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))


(use-package ansi-color
  :config
  (ansi-color-for-comint-mode-on))

(use-package popwin
  :init
  (progn
;;    (setq display-buffer-alist '(popwin:display-buffer))
    (setq popwin:special-display-config
          '(("*Help*"  :height 30)
            ("*Completions*" :noselect t)
            ("*Messages*" :noselect t :height 30)
            ("*Apropos*" :noselect t :height 30)
            ("*compilation*" :noselect t)
            ("*Backtrace*" :height 30)
            ("*Messages*" :height 30)
            ("*Occur*" :noselect t)
            ("*Ido Completions*" :noselect t :height 30)
            ("*magit-commit*" :noselect t :height 40 :width 80 :stick t)
            ("*magit-diff*" :noselect t :height 40 :width 80)
            ("*magit-edit-log*" :noselect t :height 15 :width 80)
            ("\\*ansi-term\\*.*" :regexp t :height 30)
            ("*shell*" :height 30)
            (".*overtone.log" :regexp t :height 30)
            ("*gists*" :height 30)
            ("*sldb.*":regexp t :height 30)
            ("*cider-error*" :height 30 :stick t)
            ("*cider-doc*" :height 30 :stick t)
            ("*cider-src*" :height 30 :stick t)
            ("*cider-result*" :height 30 :stick t)
            ("*cider-macroexpansion*" :height 30 :stick t)
            ("*Kill Ring*" :height 30)
            ("*Compile-Log*" :height 30 :stick t)
            ("*git-gutter:diff*" :height 30 :stick t)))

    ;; (defun live-show-messages ()
    ;;   (interactive)
    ;;   (popwin:display-buffer "*Messages*"))

    ;; (defun live-display-messages ()
    ;;   (interactive)
    ;;   (popwin:display-buffer "*Messages*"))
    ))


(use-package mouse
  :config
  (progn
    (defun initialise-mouse-mode (&optional frame)
      "Initialise mouse mode for the current terminal."
      (if (not frame) ;; The initial call.
          (xterm-mouse-mode 1)
        ;; Otherwise called via after-make-frame-functions.
        (if xterm-mouse-mode
            ;; Re-initialise the mode in case of a new terminal.
            (xterm-mouse-mode 1))))

    ;; Evaluate both now (for non-daemon emacs) and upon frame creation
    ;; (for new terminals via emacsclient).
    (initialise-mouse-mode)
    (add-hook 'after-make-frame-functions 'initialise-mouse-mode)

    (setq mouse-yank-at-point t)

    (global-set-key [mouse-4] '(lambda ()
                                 (interactive)
                                 (scroll-down 1)))

    (global-set-key [mouse-5] '(lambda ()
                                 (interactive)
                                 (scroll-up 1)))))


(progn
  (add-to-list 'auto-mode-alist '("\\.el$" . emacs-lisp-mode))
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

(defun live-lisp-describe-thing-at-point ()
  "Show the documentation of the Elisp function and variable near point.
   This checks in turn:
     -- for a function name where point is
     -- for a variable name where point is
     -- for a surrounding function call"
          (interactive)
          (let (sym)
            ;; sigh, function-at-point is too clever.  we want only the first half.
            (cond ((setq sym (ignore-errors
                               (with-syntax-table emacs-lisp-mode-syntax-table
                                 (save-excursion
                                   (or (not (zerop (skip-syntax-backward "_w")))
                                       (eq (char-syntax (char-after (point))) ?w)
                                       (eq (char-syntax (char-after (point))) ?_)
                                       (forward-sexp -1))
                                   (skip-chars-forward "`'")
                                   (let ((obj (read (current-buffer))))
                                     (and (symbolp obj) (fboundp obj) obj))))))
                   (describe-function sym))
                  ((setq sym (variable-at-point)) (describe-variable sym)))))


(defun live-lisp-top-level-p ()
  "Returns true if point is not within a given form i.e. it's in
  toplevel 'whitespace'. Only works for lisp modes."
  (= 0 (car (syntax-ppss))))

(defun live-check-lisp-top-level-p ()
  "Returns true if point is not within a given form i.e. it's in
  toplevel 'whitespace'. Only works for lisp modes."
  (interactive)
  (if (live-lisp-top-level-p)
      (message "top level")
    (message "not top level")))

(defun live-whitespace-at-point-p ()
  "Returns true if the char at point is whitespace"
  (string-match "[ \n\t]" (buffer-substring (point) (+ 1 (point)))))
  )


(use-package idomenu
  :init
  (progn
    (defvar live-symbol-names)
    (defvar live-name-and-pos)
    (defun live-ido-goto-symbol (&optional symbol-list)
      "Refresh imenu and jump to a place in the buffer using Ido."
      (interactive)
      (unless (featurep 'imenu)
        (require 'imenu nil t))
      (cond
       ((not symbol-list)
        (let ((ido-mode ido-mode)
              (ido-enable-flex-matching
               (if (boundp 'ido-enable-flex-matching)
                   ido-enable-flex-matching t))
              live-name-and-pos live-symbol-names position selected-symbol)
          (unless ido-mode
            (ido-mode 1)
            (setq ido-enable-flex-matching t))
          (while (progn
                   (imenu--cleanup)
                   (setq imenu--index-alist nil)
                   (live-ido-goto-symbol (imenu--make-index-alist))
                   (setq selected-symbol
                         (ido-completing-read "Symbol? " live-symbol-names))
                   (string= (car imenu--rescan-item) selected-symbol)))
          (unless (and (boundp 'mark-active) mark-active)
            (push-mark nil t nil))
          (setq position (cdr (assoc selected-symbol live-name-and-pos)))
          (cond
           ((overlayp position)
            (goto-char (overlay-start position)))
           (t
            (goto-char position)))))
       ((listp symbol-list)
        (dolist (symbol symbol-list)
          (let (name position)
            (cond
             ((and (listp symbol) (imenu--subalist-p symbol))
              (live-ido-goto-symbol symbol))
             ((listp symbol)
              (setq name (car symbol))
              (setq position (cdr symbol)))
             ((stringp symbol)
              (setq name symbol)
              (setq position
                    (get-text-property 1 'org-imenu-marker symbol))))
            (unless (or (null position) (null name)
                        (string= (car imenu--rescan-item) name))
              (add-to-list 'live-symbol-names name)
              (add-to-list 'live-name-and-pos (cons name position))))))))
    )
  :config
  (progn
    (ido-mode t)
    (setq ido-enable-prefix nil
      ido-create-new-buffer 'always
      ido-max-prospects 10
      ido-default-file-method 'selected-window
      ido-everywhere 1)
    (icomplete-mode 1)))

(use-package flx-ido
  :config (flx-ido-mode 1))


(use-package ibuffer-git
  :config (setq ibuffer-formats '((mark modified read-only git-status-mini " "
      (name 18 18 :left :elide)
      " "
      (size 9 -1 :right)
      " "
      (git-status 8 8 :left :elide)
      " "
      (mode 16 16 :left :elide)
      " " filename-and-process))))



(progn
  (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
  (setq delete-old-versions -1)
  (setq version-control t)
  (setq vc-make-backup-files t)
  (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t))))



(use-package auto-compile
  :config
  (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1))



(progn
  (font-lock-add-keywords 'lisp-mode
                          '((live-fontify-hex-colors)))
  (font-lock-add-keywords 'emacs-lisp-mode
                          '((live-fontify-hex-colors)))
  (font-lock-add-keywords 'lisp-interaction-mode
                          '((live-fontify-hex-colors)))
  (font-lock-add-keywords 'css-mode
                          '((live-fontify-hex-colors))))


(use-package thingatpt)
(use-package paredit
  :config
  (progn
    (defun live-paredit-next-top-level-form ()
      (interactive)
      (while (ignore-errors (paredit-backward-up) t))
      (live-paredit-forward))

    (defun live-paredit-previous-top-level-form ()
      (interactive)
      (if (ignore-errors (paredit-backward-up) t)
          (while (ignore-errors (paredit-backward-up) t))
        (paredit-backward)))

    (defun live-paredit-forward ()
      "Feels more natural to move to the beginning of the next item
   in the sexp, not the end of the current one."
      (interactive)
      (if (and (not (paredit-in-string-p))
               (save-excursion
                 (ignore-errors
                   (forward-sexp)
                   (forward-sexp)
                   t)))
          (progn
            (forward-sexp)
            (forward-sexp)
            (backward-sexp))
        (paredit-forward)))

    (defun live-paredit-forward-slurp-sexp-neatly ()
      (interactive)
      (save-excursion
        (cond ((or (paredit-in-comment-p)
                   (paredit-in-char-p))
               (error "Invalid context for slurping S-expressions."))
              ((paredit-in-string-p)
               (paredit-forward-slurp-into-string))
              (t

               (save-excursion
                 (paredit-forward-up)
                 (paredit-backward-down)
                 (paredit-forward-slurp-sexp)
                 (just-one-space)))))
      (when (not (save-excursion
                   (ignore-errors
                     (backward-sexp)
                     t)))
        (delete-horizontal-space)))

    (defun live-paredit-forward-kill-sexp (&optional arg)
      (interactive "p")
      (cond ((or (paredit-in-comment-p)
                 (paredit-in-string-p)) (kill-word (or arg 1)))
            (t (kill-sexp (or arg 1)))))

    (defun live-paredit-backward-kill-sexp (&optional arg)
      (interactive "p")
      (cond ((or (paredit-in-comment-p)
                 (paredit-in-string-p)) (backward-kill-word (or arg 1)))
            (t (backward-kill-sexp (or arg 1)))))

    (defun live-paredit-backward-kill ()
      (interactive)
      (let ((m (point-marker)))
        (paredit-backward-up)
        (forward-char)
        (delete-region (point) m)))

    (defun live-paredit-delete-horizontal-space ()
      (interactive)
      (just-one-space -1)
      (paredit-backward-delete))

    (defun live-paredit-tidy-trailing-parens ()
      (interactive)
      (save-excursion
        (while (ignore-errors (paredit-forward-up) t))
        (backward-char)
        (live-paredit-delete-horizontal-space)
        (while
            (or
             (eq (char-before) ?\))
             (eq (char-before) ?\})
             (eq (char-before) ?\]))
          (backward-char)
          (live-paredit-delete-horizontal-space))))

    (defun live-paredit-reindent-defun (&optional argument)
      "Reindent the definition that the point is on. If the point is
  in a string or a comment, fill the paragraph instead, and with
  a prefix argument, justify as well. Doesn't mess about with
  Clojure fn arglists when filling-paragraph in docstrings.

  Also tidies up trailing parens when in a lisp form"
      (interactive "P")
      (cond ((paredit-in-comment-p) (fill-paragraph argument))
            ((paredit-in-string-p) (progn
                                     (save-excursion
                                       (paredit-forward-up)
                                       (insert "\n"))
                                     (fill-paragraph argument)
                                     (save-excursion
                                       (paredit-forward-up)
                                       (delete-char 1))))
            (t (when (not (live-paredit-top-level-p))
                 (progn (save-excursion
                          (end-of-defun)
                          (beginning-of-defun)
                          (indent-sexp))
                        (live-paredit-tidy-trailing-parens))))))


;;    (defun live-paredit-forward-down ()
;;      "Doesn't freeze Emacs if attempted to be called at end of
;;   buffer. Otherwise similar to paredit-forward-down."
;;      (interactive)
;;      (if (save-excursion
;;            (forward-comment (buffer-size))
;;            (not (live-end-of-buffer-p)))
;;          (paredit-forward-down)
;;        (error "unexpected end of buffer")))

    (defun live-paredit-top-level-p ()
      "Returns true if point is not within a given form i.e. it's in
  toplevel 'whitespace'"
      (not
       (save-excursion
         (ignore-errors
           (paredit-forward-up)
           t))))

    (defun live-paredit-copy-sexp-at-point ()
      (interactive)
      (kill-new (thing-at-point 'sexp)))))

(use-package mic-paren
  :config
  (paren-activate))


(use-package highlight)

(use-package eval-sexp-fu
  :config
  (progn
    (setq eval-sexp-fu-flash-duration 0.5)

    (defun live-bounds-of-preceding-sexp ()
      "Return the bounds of sexp before the point. Copies semantics
   directly from the fn preceding-sexp to ensure highlighted area
   is identical to that which is evaluated."
      (let ((opoint (point))
            ignore-quotes
            expr)
        (save-excursion
          (with-syntax-table emacs-lisp-mode-syntax-table
            ;; If this sexp appears to be enclosed in `...'
            ;; then ignore the surrounding quotes.
            (setq ignore-quotes
                  (or (eq (following-char) ?\')
                      (eq (preceding-char) ?\')))
            (forward-sexp -1)
            ;; If we were after `?\e' (or similar case),
            ;; use the whole thing, not just the `e'.
            (when (eq (preceding-char) ?\\)
              (forward-char -1)
              (when (eq (preceding-char) ??)
                (forward-char -1)))

            ;; Skip over hash table read syntax.
            (and (> (point) (1+ (point-min)))
                 (looking-back "#s" (- (point) 2))
                 (forward-char -2))

            ;; Skip over `#N='s.
            (when (eq (preceding-char) ?=)
              (let (labeled-p)
                (save-excursion
                  (skip-chars-backward "0-9#=")
                  (setq labeled-p (looking-at "\\(#[0-9]+=\\)+")))
                (when labeled-p
                  (forward-sexp -1))))

            (save-restriction
              ;; vladimir@cs.ualberta.ca 30-Jul-1997: skip ` in
              ;; `variable' so that the value is returned, not the
              ;; name
              (if (and ignore-quotes
                       (eq (following-char) ?`))
                  (forward-char))
              (cons (point) opoint))))))

    (defun live-bounds-of-defun ()
      "Return the bounds of the defun around point. Copies semantics
   directly from the fn eval-defun-2 to ensure highlighted area
   is identical to that which is evaluated."
      (save-excursion
        (end-of-defun)
        (beginning-of-defun)
        (let ((beg (point))
              (end (progn
                     (read current-buffer)
                     (point))))
          (cons beg end))))

    ;; fix up esf to highlight exactly what emacs evaluates
    (defun live-esf-initialize-elisp ()
      (define-eval-sexp-fu-flash-command eval-last-sexp
        (eval-sexp-fu-flash (when (ignore-errors (preceding-sexp))
                              (with-esf-end-of-sexp
                               (live-bounds-of-preceding-sexp)))))
      (define-eval-sexp-fu-flash-command eval-defun
        (eval-sexp-fu-flash (live-bounds-of-defun))))

    (live-esf-initialize-elisp)

    ;; cider extensions


    (defun live-bounds-of-cider-last-sexp ()
      "Return the bounds of the defun around point. Copies semantics
   directly from the fn cider-last-sexp to ensure highlighted
   area is identical to that which is evaluated."
      (cons (save-excursion (backward-sexp) (point)) (point)))

    (defun live-esf-initialize-cider ()
      (define-eval-sexp-fu-flash-command cider-eval-last-sexp
        (eval-sexp-fu-flash (live-bounds-of-cider-last-sexp)))

      (define-eval-sexp-fu-flash-command cider-pprint-eval-last-sexp
        (eval-sexp-fu-flash (live-bounds-of-cider-last-sexp)))

      (define-eval-sexp-fu-flash-command cider-eval-defun-at-point
        (eval-sexp-fu-flash (let ((bounds (cider--region-for-defun-at-point)))
                              (cons (first bounds) (second bounds)))))


      (progn
        ;; Defines:
        ;; `eval-sexp-fu-cider-sexp-inner-list',
        ;; `eval-sexp-fu-cider-sexp-inner-sexp'
        ;; and the pprint variants respectively.
        (define-eval-sexp-fu-eval-sexp eval-sexp-fu-cider-eval-sexp
          cider-eval-last-sexp)
        (define-eval-sexp-fu-eval-sexp eval-sexp-fu-cider-pprint-eval-sexp
          cider-pprint-eval-last-sexp)))

    (eval-after-load 'cider
      '(live-esf-initialize-cider))))

(use-package clojure-test-mode)

(use-package clojure-mode
  :init
  (progn
    (defun live-transpose-words-with-hyphens (arg)
      "Treat hyphens as a word character when transposing words"
      (interactive "*p")
      (with-syntax-table clojure-mode-with-hyphens-as-word-sep-syntax-table
        (transpose-words arg)))
    (setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode))
                              auto-mode-alist)))
  :bind (("M-t" . live-transpose-words-with-hyphens))
  :config
  (progn
    (eval-after-load 'clojure-mode
      '(font-lock-add-keywords
        'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                         (0 (progn (compose-region (match-beginning 1)
                                                   (match-end 1) "λ")
                                   nil))))))
    (eval-after-load 'clojure-mode
      '(font-lock-add-keywords
        'clojure-mode `(("\\(#\\)("
                         (0 (progn (compose-region (match-beginning 1)
                                                   (match-end 1) "ƒ")
                                   nil))))))
    (eval-after-load 'clojure-mode
      '(font-lock-add-keywords
        'clojure-mode `(("\\(#\\){"
                         (0 (progn (compose-region (match-beginning 1)
                                                   (match-end 1) "∈")
                                   nil))))))
    (eval-after-load 'find-file-in-project
      '(add-to-list 'ffip-patterns "*.clj"))
    (dolist (x '(scheme emacs-lisp lisp clojure))
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'enable-paredit-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'rainbow-delimiters-mode))
    ))
    
    
(use-package clj-refactor
  :init
  (add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")))
  :bind (("C-:" . cljr-cycle-stringlike)
         ("C->" . cljr-cycle-coll)))
  
  
(use-package cider
  :init
  (progn
    (add-hook 'cider-repl-mode-hook
              (lambda ()
                (cider-turn-on-eldoc-mode)
                (paredit-mode 1)))

    (add-hook 'cider-mode-hook
              (lambda ()
                (cider-turn-on-eldoc-mode)
                (paredit-mode 1))))
  :config
  (progn
    (setq cider-popup-stacktraces nil)
    (setq cider-popup-stacktraces-in-repl nil)
    (add-to-list 'same-window-buffer-names "*cider*")
  ;; Specify the print length to be 100 to stop infinite sequences killing
  ;; things. This might be dangerous for some people relying on
  ;; *print-length* being larger. Consider a work around
    ;; (defun live-nrepl-set-print-length ()      (nrepl-send-string-sync "(set! *print-length* 100)" "clojure.core"))

                                        ;
    (add-hook 'nrepl-connected-hook 'live-nrepl-set-print-length)

    (setq nrepl-port "4555")))

(use-package popup)

(use-package fuzzy)

;; (use-package auto-complete)

;; (use-package auto-complete-config
;;   :bind (("C-M-n" . ac-next)
;;          ("C-M-p" . ac-previous)
;;          ("\t" . ac-complete)
;;          ("\r" . nil))
;;   :config
;;   (progn
;;     (ac-config-default)
;;     (setq ac-comphist-file "~/.emacs.d/tmp/")
;;     (global-auto-complete-mode t)
;;     (setq ac-auto-show-menu t)
;;     (setq ac-dwim t)
;;     (setq ac-use-menu-map t)
;;     (setq ac-quick-help-delay 1)
;;     (setq ac-quick-help-height 60)
;;     (setq ac-disable-inline t)
;;     (setq ac-show-menu-immediately-on-auto-complete t)
;;     (setq ac-auto-start 2)
;;     (setq ac-candidate-menu-min 0)

;;     (set-default 'ac-sources
;;                  '(ac-source-dictionary
;;                    ac-source-words-in-buffer
;;                    ac-source-words-in-same-mode-buffers
;;                    ac-source-semantic
;;                    ac-source-yasnippet))

;;     (dolist (mode '(magit-log-edit-mode log-edit-mode org-mode text-mode haml-mode
;;                                         sass-mode yaml-mode csv-mode espresso-mode haskell-mode
;;                                         html-mode nxml-mode sh-mode smarty-mode clojure-mode
;;                                         lisp-mode textile-mode markdown-mode tuareg-mode))
;;       (add-to-list 'ac-modes mode))))



(use-package latex-preview-pane
  :config
  (setq pdf-latex-command "/usr/texbin/pdflatex"))


(use-package python
  :mode ("\\.py\\'" . python-mode)
  :bind (("RET" . newline-and-indent))
  :interpreter ("python" . python-mode))

(use-package racer
  :init (add-to-list 'auto-mode-alist '("\\.rs" . rust-mode))
  :config
  (progn (setq racer-cmd "/Users/bc/bin/racer")
         (setq racer-rust-src-path "/Users/bc/Documents/rusten/rust/src")
    ))

;(use-package flycheck)

;(use-package flycheck-rust)

(use-package rust-mode
  :bind (("M-." . racer-find-definition))
  :config (add-hook 'rust-mode-hook
                    '(lambda () (racer-activate)
                       (racer-turn-on-eldoc)
                       (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
                       (set (make-local-variable 'company-backends) '(company-racer)))))




(server-start)
