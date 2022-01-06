    (setq inhibit-startup-message t)
    (tool-bar-mode 0)
    (menu-bar-mode 0)
    (scroll-bar-mode 0)
    (show-paren-mode 1)
    (set-fringe-mode 10)
    (setq ring-bell-function #'ignore)

    (fset 'yes-or-no-p 'y-or-n-p)

    (setq-default fill-column 72 tab-width 4)

    (setq custom-file "~/.emacs-custom.el")
    (load custom-file)

    (make-directory "~/.emacs.d/autosave/" t)
    (make-directory "~/.emacs.d/backups/" t)

    (setq backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
    (defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
    (setq auto-save-list-file-prefix autosave-dir)
    (setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

    (global-auto-revert-mode 1)

    (prefer-coding-system 'utf-8)
    (set-language-environment "UTF-8")

    (require 'uniquify)
    (setq uniquify-buffer-name-style 'forward)

    (use-package auto-compile :straight t)
      ;;; init.el --- user init file
    (setq load-prefer-newer t)
    (add-to-list 'load-path "~/.emacs.d/straight/repos/packed")
    (add-to-list 'load-path "~/.emacs.d/straight/repos/auto-compile")
    (require 'auto-compile)
    (auto-compile-on-load-mode) (auto-compile-on-save-mode)

    (setq lpr-command "gtklp")
    (setq ps-lpr-command "gtklp")

  (setq load-prefer-newer t)

  (setq help-window-select t)

  (recentf-mode t)
  (setq recentf-save-file "~/.emacs.d/recentf"
        recentf-max-saved-items 50)

(use-package saveplace :straight t
  :init (save-place-mode 1))
(setq save-place-file "~/.emacs.d/saveplace")

    (use-package w3m
      :straight t
      :config
      (setq browse-url-browser-function 'w3m-browse-url))

    (defun wicked/w3m-open-current-page-in-firefox ()
      "Open the current URL in Mozilla Firefox."
      (interactive)
      (browse-url-firefox w3m-current-url))

    (defun wicked/w3m-open-link-or-image-in-firefox ()
      "Open the current link or image in Firefox."
      (interactive)
      (browse-url-firefox (or (w3m-anchor)
                                (w3m-image))))
    (with-eval-after-load 'w3m
      (progn
        (define-key w3m-mode-map "f" 'wicked/w3m-open-current-page-in-firefox)
        (define-key w3m-mode-map "F" 'wicked/w3m-open-link-or-image-in-firefox)))

      (setq echo-keystrokes 0.5)

    (setq-default indent-tabs-mode nil)

    (setq frame-title-format
          '("" invocation-name ": " (:eval (replace-regexp-in-string
                                            "^ +" "" (buffer-name)))))

    (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

  (setq disabled-command-function nil)

     (setq use-dialog-box nil)

    (setq savehist-file "~/.emacs.d/savehist"
          history-length 150)

(setq system-uses-terminfo nil)

    ;; (straight-use-package 'color-theme-modern)
    ;; (load-theme 'midnight t t)
    ;; (enable-theme 'midnight)
(straight-use-package 'dracula-theme)
(load-theme 'dracula t)

    (use-package powerline
      :straight t
      :config
      (require 'powerline)
      (powerline-center-theme))

(use-package ivy-rich :straight t
  :after (ivy)
  :config
  (require 'ivy-rich)
  (ivy-rich-mode 1))

    (use-package amx :straight t)

    (use-package counsel :straight t)

(use-package swiper :straight t)
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "M-x") 'amx)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-load-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

(use-package calfw
  :straight t
  :config
  (require 'calfw))
(use-package calfw-org
  :straight t
  :config
  (require 'calfw-org))

    (straight-use-package 'lorem-ipsum)
    (require 'lorem-ipsum)
    (global-set-key (kbd "C-c C-i s") 'lorem-ipsum-insert-sentences)
    (global-set-key (kbd "C-c C-i p") 'lorem-ipsum-insert-paragraphs)
    (global-set-key (kbd "C-c C-i l") 'lorem-ipsum-insert-list)

    (straight-use-package 'rainbow-delimiters)
    (require 'rainbow-delimiters)
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

    (use-package rainbow-mode
      :straight t
      :init
      (add-hook 'prog-mode-hook 'rainbow-mode))

    (use-package define-word
           :straight t
           :defer t
           :bind (("C-c d" . define-word-at-point)
                 ("C-c D" . define-word))
           :config
           (setq define-word-default-service 'webster))
    ;;(global-set-key (kbd "C-c d") 'define-word-at-point)
    ;;(global-set-key (kbd "C-c D") 'define-word)

    (use-package fzf :straight t)

    (defun my-zsh ()
      (interactive)
      (ansi-term "zsh"))

    (straight-use-package 'highlight-indent-guides)
    (setq highlight-indent-guides-method 'column)
    (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

    (use-package which-key
      :straight t
      :config
      (require 'which-key)
      (which-key-mode)  )

    (global-set-key (kbd "<f5>") 'revert-buffer)

    (defun config-visit ()
      (interactive)
      (find-file "~/.emacs.d/myinit.org"))
    (global-set-key (kbd "C-c e") 'config-visit)

     (defun config-reload ()
       "Reloads ~/.emacs.d/myinit.org at runtime"
       (interactive)
       (org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org")))
    (global-set-key (kbd "C-c r") 'config-reload)

         (defvar my-cpp-other-file-alist
           '(("\\.cpp\\'" (".hpp" ".ipp"))
             ("\\.ipp\\'" (".hpp" ".cpp"))
             ("\\.hpp\\'" (".ipp" ".cpp"))
             ("\\.cxx\\'" (".hxx" ".ixx"))
             ("\\.ixx\\'" (".cxx" ".hxx"))
             ("\\.hxx\\'" (".ixx" ".cxx"))
             ("\\.c\\'" (".h"))
             ("\\.h\\'" (".c"))
             ))

    (setq-default ff-other-file-alist 'my-cpp-other-file-alist)
    (add-hook
         'c-mode-hook
          (lambda ()
          (local-set-key (kbd "M-o") #'ff-find-other-file)))

    (use-package hydra :straight t)

    (global-set-key (kbd "C-x C-b") 'ibuffer)
    (setq ibuffer-saved-filter-groups
          (quote (("default"
                   ("dired" (mode . dired-mode))
                   ("org" (name . "^.*org$"))

                   ("web" (or (mode . web-mode) (mode . js2-mode)))
                   ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
                   ("mu4e" (name . "\*mu4e\*"))
                   ("programming" (or
                                   (mode . python-mode)
                                   (mode . c++-mode)))
                   ("emacs" (or
                             (name . "^\\*scratch\\*$")
                             (name . "^\\*Messages\\*$")))
                   ))))
    (add-hook 'ibuffer-mode-hook
              (lambda ()
                (ibuffer-auto-mode 1)
                (ibuffer-switch-to-saved-filter-groups "default")))

    ;; don't show these
    ;;(add-to-list 'ibuffer-never-show-predicates "zowie")
    ;; Don't show filter groups if there are no buffers in that group
    (setq ibuffer-show-empty-filter-groups nil)

    ;; Don't ask for confirmation to delete marked buffers
    (setq ibuffer-expert t)

    ;;(global-set-key (kbd "C-s") 'isearch-forward-regexp)
    ;;(global-set-key (kbd "C-r") 'isearch-backward-regexp)
    ;;(global-set-key (kbd "C-M-s") 'isearch-forward)
    ;;(global-set-key (kbd "C-M-r") 'isearch-backward)

(use-package helpful :straight t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

    (straight-use-package 'znc)

    (use-package erc
      :straight t
      :config
      (add-to-list 'erc-modules 'notifications)
      (add-to-list 'erc-modules 'spelling)
      (require 'erc-desktop-notifications)
      (erc-update-modules))

    ;; Make ERC client hide chat JOINS/PARTS/QUITS
    (setq erc-hide-list '("JOIN" "MODE" "NICK" "PART" "QUIT"
                          "324" "329" "332" "333" "353" "477"))

    ;; Use erc-fill to make for more visually pleasing display
    (setq erc-fill-function 'erc-fill-static)
    (setq erc-fill-static-center 15)


    ;; Set ERC client to ignore server messages
    (setq erc-server-303-functions nil)

    ;; Change prompt for each channel buffer to match the channel name.
    (setq erc-prompt (lambda () (concat "[" (buffer-name) "]")))

    ;; Add package erc-scrolltoplace
    (straight-use-package 'erc-scrolltoplace)
    (require 'erc-scrolltoplace)
    (add-to-list 'erc-modules 'scrolltoplace)
    (erc-update-modules)

    ;; Receive a notificatiion when getting a private message/nickname mentioned.
    (defun my/erc-notify (nickname message)
      "Displays a notification message for ERC."
      (let* ((channel (buffer-name))
             (nick (erc-hl-nicks-trim-irc-nick nickname))
             (title (if (string-match-p (concat "^" nickname) channel)
                        nick
                      (concat nick " (" channel ")")))
             (msg (s-trim (s-collapse-whitespace message))))
        (alert (concat nick ": " msg) :title title)))

    (use-package erc-hl-nicks
      :straight t)

(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive)
(setq org-habit-show-all-today t)
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-agenda-start-on-weekday 0)
(setq org-log-repeat nil)

(setq org-agenda-files (list "~/gtd/tasks.org"
                             "~/gtd/habits.org"
                             "~/gtd/goals.org"
                             "~/gtd/birthdays.org"))

(setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; Refile in a single go
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)

;; other useful settings
(setq org-clock-into-drawer "CLOCKING")
(setq org-export-with-smart-quotes t)
(setq org-src-fontify-natively t)
(setq org-src-window-setup 'current-window)
(add-hook 'org-mode-hook 'org-indent-mode)
(setq org-confirm-babel-evaluate nil)

(setq org-startup-indented t
      org-cycle-include-plain-lists 'integrate
      org-return-follows-link t
      org-src-fontify-natively t
      org-src-preserve-indentation t
      org-enforce-todo-dependencies t
      org-enforce-todo-checkbox-dependencies t
      org-link-frame-setup '((file . find-file)))

(setq org-export-backends '(ascii beamer html latex md))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(setq org-ellipsis " ▼")

;;(org-agenda nil "a")
(add-hook 'after-init-hook 'org-agenda-list)

    (global-set-key "\C-cl" 'org-store-link)
    (global-set-key "\C-ca" 'org-agenda)
    (global-set-key "\C-cc" 'org-capture)
    (global-set-key "\C-cb" 'org-switchb)
    (global-set-key (kbd "<f11>") 'org-clock-goto)
    (global-set-key (kbd "C-<f11>") 'org-clock-in)
    (global-set-key (kbd "M-<f11>") 'org-clock-out)

    (straight-use-package 'org-superstar)
    (require 'org-superstar)
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
    (org-superstar-configure-like-org-bullets)

;; org TODO Keywords
(setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "REPEAT(r)" "WAITING(w)" "SOMEDAY(s)" "PROJ(p)" "|" "DONE(d!)" "CANCELLED(c)")))

    (setq org-todo-keyword-faces
          (quote (("TODO" :foreground "red" :weight bold)
                  ("NEXT" :foreground "#00ffff" :weight bold)
                  ("REPEAT" :foreground "magenta" :weight bold)
                  ("WAITING" :foreground "orange" :weight bold)
                  ("SOMEDAY" :foreground "cyan" :weight bold)
                  ("PROJ" :foreground "#ffc252" :weight bold)
                  ("DONE" :foreground "green" :weight bold)
                  ("CANCELLED" :foreground "yellow" :weight bold))))

(setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

    (setq org-latex-create-formula-image-program 'dvipng)

    (setq org-catch-invisible-edits 'show-and-error)

    (setq org-alphabetical-lists t)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t) (python . t) (js . t) (ruby . t)))
(setq org-config-babel-evaluate nil)

    (straight-use-package 'org-re-reveal)
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
    (setq org-reveal-mathjax t)

    (setq org-default-notes-file "~/gtd/notes.org")
    (setq org-capture-templates
          '(("t" "Tasks / Projects")
            ("tt" "Task" entry (file+olp "~/gtd/tasks.org" "Inbox")
             "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
            ("j" "Journal Entries")
            ("jj" "Journal" entry
             (file+olp+datetree "~/gtd/Journal.org")
             "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
             :clock-in :clock-resume
             :empty-lines 1)
            ("n" "Notes")
            ("nn" "Notes" entry (file+headline "~/gtd/notes.org" "Notes")
             "* %?   \n  %i\n  %u\n  %a")
            ("l" "Link")
            ("ll" "Link" entry(file+headline "~/gtd/links.org" "Links")
             "* %? %^L %^g \n%T" :prepend t)
            ("g" "Goals")
            ("gg" "Goal" entry (file+headline "~/gtd/goals.org" "Goals") "* %i%? \n %U")
            ("p" "Projects")
            ("pp" "Project" entry (file+headline "~/gtd/project.org" "Project")  "* %i%? \n %U")
            ("s" "Someday")
            ("ss" "Someday" entry (file+headline "~/gtd/someday-maybe.org" "Someday/Maybe") "* %i%? \n %U")
            ))

    (setq org-M-RET-may-split-line nil)

    (defhydra hydra-org (:color blue :timeout 12 :columns 4)
      "Org commands"
      ("i" (lambda () (interactive) (org-clock-in '(4))) "Clock in")
      ("o" org-clock-out "Clock out")
      ("q" org-clock-cancel "Cancel a clock")
      ("<f10>" org-clock-in-last "Clock in the last task")
      ("j" (lambda () (interactive) (org-clock-goto '(4))) "Go to a clock"))
    (global-set-key (kbd "<f10>") 'hydra-org/body)

    (straight-use-package 'ox-twbs)

    (straight-use-package 'org-cliplink)
    (global-set-key (kbd "C-x p i") 'org-cliplink)

;; Use coreutils ls
;;(when (string= system-type "freebsd")
;;  (setq dired-use-ls-dired t
;;        insert-directory-program "/usr/local/bin/gls"
;;        dired-listing-switches "-aBhl --group-directories-first"))
;; projectile
(use-package projectile
  :straight t
  :config
  (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/")
    (setq projectile-project-search-path '("~/Projects/")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :straight t
  :config
  (counsel-projectile-mode))

(setq dired-use-ls-dired t
       insert-directory-program "/usr/local/bin/gls")
(setq dired-listing-switches "-laGh1v --group-directories-first")
(setq delete-by-moving-to-trash t)

(use-package all-the-icons-dired
  :straight t
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :straight t
  :hook
  (dired-mode . dired-hide-dotfiles-mode)
  :config
  (define-key dired-mode-map (kbd "C-c t") 'dired-hide-dotfiles-mode)
  )

    (use-package dired+
      :straight t
      :config
      (require 'dired+))

    (setq hippie-expand-try-functions-list
          '(try-expand-dabbrev-visible
            try-expand-dabbrev
            try-expand-dabbrev-all-buffers
            try-expand-dabbrev-from-kill
            try-expand-list
            try-expand-list-all-buffers
            try-complete-file-name-partially
            try-complete-file-name
            try-expand-all-abbrevs))

    (straight-use-package 'yasnippet)
    (yas-global-mode 1)

    (use-package yasnippet-snippets :straight t)

    (add-hook 'text-mode-hook 'turn-on-auto-fill)

    (add-hook 'text-mode-hook 'turn-on-flyspell)

    (use-package multiple-cursors :straight t)
    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

    (use-package aggressive-indent :straight t)

    (use-package undo-tree
      :straight t
      :diminish undo-tree-mode
      :init
      (global-undo-tree-mode 1)
      :config
      (defalias 'redo 'undo-tree-redo)
      :bind (("C-z" . undo)     ; Zap to character isn't helpful
             ("C-S-z" . redo)))

    (straight-use-package 'popup-kill-ring)
    (global-set-key "\M-y" 'popup-kill-ring)

    (use-package browse-kill-ring
      :straight t
      :config
      (require 'browse-kill-ring)
      (browse-kill-ring-default-keybindings))

    (use-package wrap-region
      :straight   t
      :config
      (wrap-region-global-mode t)
      (wrap-region-add-wrappers
       '(("(" ")")
         ("[" "]")
         ("{" "}")
         ("<" ">")
         ("'" "'")
         ("\"" "\"")
         ("‘" "’"   "q")
         ("“" "”"   "Q")
         ("*" "*"   "b"   org-mode)                 ; bolden
         ("*" "*"   "*"   org-mode)                 ; bolden
         ("/" "/"   "i"   org-mode)                 ; italics
         ("/" "/"   "/"   org-mode)                 ; italics
         ("~" "~"   "c"   org-mode)                 ; code
         ("~" "~"   "~"   org-mode)                 ; code
         ("=" "="   "v"   org-mode)                 ; verbatim
         ("=" "="   "="   org-mode)                 ; verbatim
         ("_" "_"   "u" '(org-mode markdown-mode))  ; underline
         ("**" "**" "b"   markdown-mode)            ; bolden
         ("*" "*"   "i"   markdown-mode)            ; italics
         ("`" "`"   "c" '(markdown-mode ruby-mode)) ; code
         ("`" "'"   "c"   lisp-mode)                ; code
         ))
      :diminish wrap-region-mode)
    (add-to-list 'wrap-region-except-modes 'web-mode)
    (add-to-list 'wrap-region-except-modes 'cal-mode)
    (add-to-list 'wrap-region-except-modes 'dired-mode)

    (use-package whitespace
      :straight t
      :bind ("C-c T w" . whitespace-mode)
      :init
      (setq whitespace-line-column nil
            whitespace-display-mappings '((space-mark 32 [183] [46])
                                          (newline-mark 10 [9166 10])
                                          (tab-mark 9 [9654 9] [92 9])))
      :config
      (set-face-attribute 'whitespace-space       nil :foreground "#666666" :background nil)
      (set-face-attribute 'whitespace-newline     nil :foreground "#666666" :background nil)
      (set-face-attribute 'whitespace-indentation nil :foreground "#666666" :background nil)
      :diminish whitespace-mode)

     (use-package smart-comment
       :straight t
       :bind ("M-;" . smart-comment))

    (add-hook 'before-save-hook 'delete-trailing-whitespace)

    (use-package flycheck
      :straight t
      :init
      (add-hook 'after-init-hook 'global-flycheck-mode)
      :config
      (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

    (use-package expand-region
      :straight t
      :config
      (defun ha/expand-region (lines)
        "Prefix-oriented wrapper around Magnar's `er/expand-region'.

         Call with LINES equal to 1 (given no prefix), it expands the
         region as normal.  When LINES given a positive number, selects
         the current line and number of lines specified.  When LINES is a
         negative number, selects the current line and the previous lines
         specified.  Select the current line if the LINES prefix is zero."
        (interactive "p")
        (cond ((= lines 1)   (er/expand-region 1))
              ((< lines 0)   (ha/expand-previous-line-as-region lines))
              (t             (ha/expand-next-line-as-region (1+ lines)))))

      (defun ha/expand-next-line-as-region (lines)
        (message "lines = %d" lines)
        (beginning-of-line)
        (set-mark (point))
        (end-of-line lines))

      (defun ha/expand-previous-line-as-region (lines)
        (end-of-line)
        (set-mark (point))
        (beginning-of-line (1+ lines)))

      :bind ("C-=" . ha/expand-region))

    (use-package hungry-delete
      :straight t
      :config
      (global-hungry-delete-mode))

    (global-hl-line-mode t)

    (when (fboundp 'winner-mode)
      (winner-mode 1))

    (use-package ace-window
      :straight t
      :init
      (progn
        (global-set-key (kbd "M-o") 'ace-window)
        (custom-set-faces)
        '(aw-leading-char face
                          ((t (:inherit ace-jump-face-foreground :height 3.0))))))

    (use-package avy
      :straight t
      :config
      (avy-setup-default))
    (global-set-key (kbd "C-|") 'avy-goto-char)
    (global-set-key (kbd "C-'") 'avy-goto-char-2)
    (global-set-key (kbd "M-g f") 'avy-goto-line)
    (global-set-key (kbd "M-g w") 'avy-goto-word-1)
    (global-set-key (kbd "M-g e") 'avy-goto-word-0)

    (use-package neotree
      :straight t)
    (require 'neotree)
    (global-set-key [f8] 'neotree-toggle)

    (use-package vimish-fold
      :straight t)
    (require 'vimish-fold)
    (global-set-key (kbd "C-c v f") #'vimish-fold)
    (global-set-key (kbd "C-c v v") #'vimish-fold-delete)
    (vimish-fold-global-mode 1)

    (use-package linum-relative
      :straight t
      :config
      (defun linum-new-mode ()
        "If line numbers aren't displayed, then display them.
          Otherwise, toggle between absolute and relative numbers."
        (interactive)
        (if linum-mode
            (linum-relative-toggle)
          (linum-mode 1)))

      :bind ("s-k" . linum-new-mode))

    (use-package smartparens
      :straight t
      :config
      (progn
        (show-smartparens-global-mode t)))

    (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
    (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

    (when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

    ;; Set wraparound
    (setq windmove-wrap-around t)

(use-package company
  :straight t
  :after lsp-mode
  :hook
  (prog-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-dealy 0.0)
  )

(setq
 company-selection-wrap-around t
 company-show-numbers t
 company-require-match 'never
 company-dabbrev-downcase nil
 company-dabbrev-ignore-case t
 company-backends '(company-jedi company-nxml
                                 company-css company-capf
                                 (company-dabbrev-code company-keywords)
                                 company-files company-dabbrev company-clang)
 company-jedi-python-bin "python")

(setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
        company-echo-metadata-frontend
        company-preview-frontend)
      company-auto-complete t)
(add-hook 'prog-mode-hook 'company-mode)

    (use-package company-jedi
      :straight t
      :config
      (defun my/python-mode-hook ()
        (add-to-list 'company-backends 'company-jedi))

      (add-hook 'python-mode-hook 'my/python-mode-hook)
      )

(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode))

(use-package lsp-ui
  :straight t
  :hook
  (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-treemacs
  :straight t
  :after lsp)

(use-package lsp-ivy
  :straight t)

    (add-hook 'prog-mode-hook '(lambda () (display-line-numbers-mode 1)))

    (use-package color-identifiers-mode
      :straight t
      :init
      (add-hook 'prog-mode-hook 'color-identifiers-mode))

    (use-package go-mode :straight t)
    (defun my-go-mode-hook ()
      ;;Use goimports instead of go-fmt
      (setq gofmt-command "goimports")
      ;; Call Gofmt before saving
      (add-hook 'before-save-hook 'gofmt-before-save)
      ;; Customize compile command to run go build
      (if (not (string-match "go" compile-command))
          (set (make-local-variable 'compile-command)
               "go build -v && go test -v && go vet"))
      ;; Godef jump key binding
      (local-set-key (kbd "M-.") 'godef-jump)
      (local-set-key (kbd "M-*") 'pop-tag-mark))

    (add-hook 'go-mode-hook 'my-go-mode-hook)

    (defun auto-complete-for-go ()
      (auto-complete-mode 1))
    (add-hook 'go-mode-hook 'auto-complete-for-go)

    (use-package go-eldoc
      :straight t
      :config
      (add-hook 'go-mode-hook 'go-eldoc-setup))

    (use-package godoctor
      :straight t)

    (use-package go-guru
      :straight t)

(use-package lsp-java
  :straight t
  :config
  (require 'lsp-java)
  (add-hook 'java-mode-hook #'lsp)
  (add-to-list 'lsp-enabled-clients 'jdtls))

;; (use-package jdee
;;   :straight t)
;; (load "jdee")
;; (custom-set-variables '(jdee-server-dir "~/.emacs.d/straight/repos/jdee-server"))

(use-package lsp-jedi
  :straight t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))
(add-hook 'python-mode-hook 'lsp)
;;(setq python-shell-interpreter "/usr/local/bin/python3.7")

    ;; (use-package elpy
    ;;   :straight t
    ;;   :config
    ;;   (when (require 'elpy nil t)
    ;;     (elpy-enable))
    ;;   (setq elpy-rpc-backend "jedi"))
    ;; (setq elpy-rpc-python-command "python3.7")
    ;; (setq python-shell-interpreter "/usr/local/bin/python3.7")

    (use-package py-autopep8
      :straight t)
    (require 'py-autopep8)
    (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

  (setq js-indent-level 2)
  (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))

    (use-package js2-mode
      :straight t
      :init
      (setq js-basic-indent 2)
      (setq-default js2-basic-indent 2
                    js2-basic-offset 2
                    js2-auto-indent-p t
                    js2-cleanup-whitespace t
                    js2-enter-indents-newline t
                    js2-indent-on-enter-key t
                    js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON" "jQuery" "$"))

      (add-hook 'js2-mode-hook
                (lambda ()
                  (push '("function" . ?ƒ) prettify-symbols-alist)))

      (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

      (add-hook 'js2-mode-hook
                (lambda () (flycheck-select-checker "javascript-eslint")))

    (use-package js-comint
      :straight t)
    (require 'js-comint)

    (defun inferior-js-mode-hook-setup ()
      (add-hook 'comint-output-filter-functions 'js-comint-process-output))
    (add-hook 'inferior-js-mode-hook 'inferior-js-mode-hook-setup t)

    ;; You can also customize `js-comint-drop-regexp' to filter output
    (when (eq system-type 'gnu/linux)
      (setq inferior-js-program-command "nodejs")
      (setq inferior-js-program-arguments '("--interactive")))
    (when (eq system-type 'berkeley-unix)
      (setq inferior-js-program-command "node")
      (setq inferior-js-program-arguments '("--interactive")))

    (add-hook 'js2-mode-hook
              (lambda ()
                (local-set-key (kbd "C-x C-e") 'js-send-last-sexp)
                (local-set-key (kbd "C-M-x") 'js-send-last-sexp-and-go)
                (local-set-key (kbd "C-c b") 'js-send-buffer)
                (local-set-key (kbd "C-c C-b") 'js-send-buffer-and-go)
                (local-set-key (kbd "C-c l") 'js-load-file-and-go)))

    (setq auto-mode-alist
          (cons '("\\.m$" . octave-mode) auto-mode-alist))

    (setq auto-mode-alist
          (cons '("\\.m$" . octave-mode) auto-mode-alist))

    (add-hook 'octave-mode-hook
              (lambda ()
                (abbrev-mode 1)
                (auto-fill-mode 1)
                (if (eq window-system 'x)
                    (font-lock-mode 1))))

    (use-package htmlize
      :straight t)

(use-package lsp-mode :straight t
  :commands (lsp lsp-deferred)
  :init
  (require 'lsp)
  (add-to-list 'lsp-enabled-clients 'clangd)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'cpp-mode-hook 'lsp)
  :config
  (define-key lsp-mode-map (kbd "s-h") lsp-command-map)
  (lsp-enable-which-key-integration t))
(use-package dap-mode :straight t)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      lsp-idle-delay 0.1 ;; clangd is fast
      ;; be more ide-ish
      lsp-headerline-breadcrumb-enable t)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

    (use-package ggtags
      :straight t
      :config
      (add-hook 'c-mode-common-hook
                (lambda ()
                  (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                    (ggtags-mode 1))))
      )

(use-package web-mode
  :straight t)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-enable-auto-pairing t)
(setq web-mode-enable-css-colorization t)

;; Set Indentation
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

;; For Emmet to switch between html and css properly in the same document,
;; this hook is added.
(add-hook 'web-mode-before-auto-complete-hooks
          '(lambda ()
             (let ((web-mode-cur-language
                    (web-mode-language-at-pos)))
               (if (string= web-mode-cur-language "php")
                   (yas-activate-extra-mode 'php-mode)
                 (yas-deactivate-extra-mode 'php-mode))
               (if (string= web-mode-cur-language "css")
                   (setq emmet-use-css-transform t)
                 (setq emmet-use-css-transform nil)))))

    (use-package emmet-mode
      :straight t
      :config
      (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
      (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
      (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
      )

  (use-package dumb-jump
    :straight t
    :config
    (dumb-jump-mode))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; set eldoc default delay
(setq eldoc-idle-delay 0.1
      eldoc-echo-area-use-multiline-p nil)

(use-package typescript-mode
  :straight t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-enabled-clients 'ts-ls)
  (setq typescript-indent-level 2))

(setq css-indent-offset 2)

(defun my-info-copy-current-node-name (arg)
  "Copy the lispy form of the current node.
With a prefix argument, copy the link to the online manual
instead."
  (interactive "P")
  (let* ((manual (file-name-sans-extension
                  (file-name-nondirectory Info-current-file)))
         (node Info-current-node)
         (link (if (not arg)
                   (format "(info \"(%s) %s\")" manual node)
                 ;; NOTE this will only work with emacs-related nodes...
                 (format "https://www.gnu.org/software/emacs/manual/html_node/%s/%s.html"
                         manual (if (string= node "Top")
                                    "index"
                                  (replace-regexp-in-string " " "-" node))))))
    (kill-new link)
    (message link)))

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd "c") 'my-info-copy-current-node-name))

  (use-package magit
    :straight t
    :init
    (progn
      (bind-key "C-x g" 'magit-status)
      ))

;;(use-package forge
;;  :straight t
;;  :after magit)

  (use-package git-gutter
    :straight t
    :init
    (global-git-gutter-mode +1))

  (custom-set-variables
   '(git-gutter:update-interval 2))

  (use-package git-timemachine
    :straight t
    )

        (defhydra hydra-git-gutter (:body-pre (git-gutter-mode 1)
				  :hint nil)
	"
      Git gutter:
	_j_: next hunk        _s_tage hunk     _q_uit
	_k_: previous hunk    _r_evert hunk    _Q_uit and deactivate git-gutter
	^ ^                   _p_opup hunk
	_h_: first hunk
	_l_: last hunk        set start _R_evision
      "
	("j" git-gutter:next-hunk)
	("k" git-gutter:previous-hunk)
	("h" (progn (goto-char (point-min))
		    (git-gutter:next-hunk 1)))
	("l" (progn (goto-char (point-min))
		    (git-gutter:previous-hunk 1)))
	("s" git-gutter:stage-hunk)
	("r" git-gutter:revert-hunk)
	("p" git-gutter:popup-hunk)
	("R" git-gutter:set-start-revision)
	("q" nil :color blue)
	("Q" (progn (git-gutter-mode -1)
		    ;; git-gutter-fringe doesn't seem to
		    ;; clear the markup right away
		    (sit-for 0.1)
		    (git-gutter:clear))
	     :color blue))

  (use-package markdown-mode
    :straight t
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
           ("\\.md\\'" . markdown-mode)
           ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "multimarkdown"))

    (use-package tex-site
      :straight auctex
      :mode ("\\.tex\\'" . latex-mode)
      :config
      (setq TeX-auto-save t)
      (setq TeX-parse-self t)
      (setq-default TeX-master nil)
      (add-hook 'LaTeX-mode-hook
                (lambda ()
                  (rainbow-delimiters-mode)
                  (company-mode)
                  (smartparens-mode)
                  (turn-on-reftex)
                  (setq reftex-plug-into-AUCTeX t)
                  (reftex-isearch-minor-mode)
                  (setq TeX-PDF-mode t)
                  (setq TeX-source-correlate-method 'synctex)
                  (setq TeX-source-correlate-start-server t)))

      ;; Update PDF buffers after successful LaTeX runs
      (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
                #'TeX-revert-document-buffer)

      ;; to use pdfview with auctex
      (add-hook 'LaTeX-mode-hook 'pdf-tools-install)

      ;; to use pdfview with auctex
      (setq TeX-view-program-selection '((output-pdf "pdf-tools"))
            TeX-source-correlate-start-server t)
      (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))

    (use-package reftex
      :straight t
      :defer t
      :config
      (setq reftex-cite-prompt-optional-args t))

  (defun fa/add-latex-acronym (region-beg region-end)
    "This function reads the written out form of an acronym via the
  minibuffer and adds it to the acronym list in a latex
  document. Addtionally, it sorts all acronyms in the list."
    (interactive "r")
    (save-excursion
      (let ((acronym
             (if (region-active-p)
                 (buffer-substring region-beg region-end)
               (read-from-minibuffer "Acronym: ")))
            (full-name (read-from-minibuffer "Full Name: ")))
        (beginning-of-buffer)
        (if (search-forward "\\begin{acronym}" nil t)
            (progn
              (deactivate-mark)
              (open-line 1)
              (forward-line 1)
              (insert (concat "  \\acro{" acronym "}{" full-name "}"))
              (beginning-of-line)
              (sort-lines nil (point) (search-forward "\\end{acronym}" nil nil)))
          (user-error "No acronym environment found")))))

    (setq user-mail-address "transitive@gmail.com")
    (setq user-full-name "Robert Cina")

    (setq gnus-select-method
          '(nnimap "gmail"
                   (nnimap-address "imap.gmail.com")
                   (nnimap-server-port 993)
                   (nnimap-stream ssl)))

    (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
          smtpmail-auth-credentials '(("smtp.gmail.com" 587
                                       "user@gmail.com" nil))
          smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587
          gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

    (defhydra hydra-elfeed ()
      "filter"
      ("l" (elfeed-search-set-filter "@6-month-ago +lobsters") "lobsters")
      ("m" (elfeed-search-set-filter "@6-month-ago +Math") "Math")
      ("c" (elfeed-search-set-filter "@6-months-ago +cs") "cs")
      ("e" (elfeed-search-set-filter "@6-months-ago +emacs") "emacs")
      ("B" (elfeed-search-set-filter "@6-months-ago +BSD") "BSD")
      ("p" (elfeed-search-set-filter "@6-months-ago +programming") "programming")
      ("*" (elfeed-search-set-filter "@6-months-ago +star") "Starred")
      ("M" elfeed-toggle-star "Mark")
      ("A" (elfeed-search-set-filter "@6-months-ago") "All")
      ("T" (elfeed-search-set-filter "@1-day-ago") "Today")
      ("Q" bjm/elfeed-save-db-and-bury "Quit Elfeed" :color blue)
      ("q" nil "quit" :color blue)
      )

    (use-package elfeed
      :straight t
      :bind (:map elfeed-search-mode-map
                  ("q" . bjm/elfeed-save-db-and-bury)
                  ("Q" . bjm/elfeed-save-db-and-bury)
                  ("m" . elfeed-toggle-star)
                  ("M" . elfeed-toggle-star)
                  ("j" . hydra-elfeed/body)
                  ("J" . hydra-elfeed/body)
                  )
      )

(use-package elfeed-goodies
  :straight t
  :config
  (elfeed-goodies/setup))


    (use-package elfeed-org
      :straight t
      :config
      (elfeed-org)
      (setq rmh-elfeed-org-files (list "~/elfeed/elfeed.org")))

    (setq elfeed-db-directory "~/elfeed/elfeeddb")


    (defun elfeed-mark-all-as-read ()
      (interactive)
      (mark-whole-buffer)
      (elfeed-search-untag-all-unread))


    ;;functions to support syncing .elfeed between machines
    ;;makes sure elfeed reads index from disk before launching
    (defun bjm/elfeed-load-db-and-open ()
      "Wrapper to load the elfeed db from disk before opening"
      (interactive)
      (elfeed-db-load)
      (elfeed)
      (elfeed-search-update--force))

    ;;write to disk when quiting
    (defun bjm/elfeed-save-db-and-bury ()
      "Wrapper to save the elfeed db to disk before burying buffer"
      (interactive)
      (elfeed-db-save)
      (quit-window))



    (defalias 'elfeed-toggle-star
      (elfeed-expose #'elfeed-search-toggle-all 'star))

  (use-package ox-hugo
    :straight t            ;Auto-install the package from Melpa (optional)
    :after ox)

(straight-use-package 'org-noter)

(use-package term
  :straight t
  :config
  (setq explicit-shell-file-name "zsh")
  ;;(setq explicit-zsh-args '())
  ;;(setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  )

(use-package eterm-256color
  :straight t
  :hook
  (add-hook 'term-mode-hook #'eterm-256color-mode)
  )

(use-package vterm
  :straight t
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))

(defun efs/configure-shell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate Buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size 10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t)
  )

(use-package eshell-git-prompt
  :straight t)

(use-package eshell
  :straight t
  :hook (eshell-first-time-mode . efs/configure-shell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))
  (eshell-git-prompt-use-theme 'powerline))
