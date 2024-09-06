(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :weight 'light
                    :height 140)

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :weight 'light
                    :height 140)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil
                    ;; :font "Cantarell"
                    :font "Iosevka Light"
                    :height 140
                    :weight 'light)

(setq inhibit-startup-message t)
    (tool-bar-mode 0)
    (menu-bar-mode 0)
    (scroll-bar-mode 0)
    (show-paren-mode 1)
    (set-fringe-mode 10)
    (setq ring-bell-function #'ignore)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default fill-column 72 tab-width 4)

(global-visual-line-mode t)

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
(add-to-list 'load-path "~/.emacs.d/straight/repos/auto-compile")
(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)

(setq lpr-command "gtklp")
(setq ps-lpr-command "gtklp")

(setq help-window-select t)

(recentf-mode t)
(setq recentf-save-file "~/.emacs.d/recentf"
      recentf-max-saved-items 50)

(use-package saveplace :straight t
  :init (save-place-mode 1))
(setq save-place-file "~/.emacs.d/saveplace")

(setq browse-url-browser-function 'browse-url-firefox)
;;(setq browse-url-browser-function 'w3m-browse-url)
(use-package w3m
  :straight t)

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

(setq dictionary-server "dict.org")

(use-package casual-lib
  :straight (casual-lib :type git :host github :repo "kickingvegas/casual-lib")
  :ensure nil)
(use-package casual-agenda
  :straight (casual-suite :type git :host github :repo "kickingvegas/casual-agenda")
  :ensure nil
  :bind (:map
         org-agenda-mode-map
         ("C-o" . casual-agenda-tmenu)
         ("M-j" . org-agenda-clock-goto) ; optional
         ("J" . bookmark-jump))) ; optional)

(use-package casual-calc
  :straight t
  :ensure nil
  :bind (:map calc-mode-map ("C-o" . casual-calc-tmenu)))

(use-package casual-info
  :straight t
  :ensure nil
  :bind (:map Info-mode-map ("C-o" . casual-info-tmenu)))

(use-package casual-dired
  :straight t
  :ensure nil
  :bind (:map dired-mode-map ("C-o" . casual-dired-tmenu)))

(use-package casual-avy
  :straight t
  :ensure nil
  :bind ("C-o" . casual-avy-tmenu))

(use-package casual-isearch
  :straight t
  :ensure nil
  :bind (:map isearch-mode-map ("C-o" . casual-isearch-tmenu)))

(use-package ibuffer
  :straight t
  :hook (ibuffer-mode . ibuffer-auto-mode)
  :defer t)

(use-package casual-ibuffer
  :straight t
  :ensure nil
  :bind (:map
         ibuffer-mode-map
         ("C-o" . casual-ibuffer-tmenu)
         ("F" . casual-ibuffer-filter-tmenu)
         ("s" . casual-ibuffer-sortby-tmenu)
         ("<double-mouse-1>" . ibuffer-visit-buffer) ; optional
         ("M-<double-mouse-1>" . ibuffer-visit-buffer-other-window) ; optional
         ("{" . ibuffer-backwards-next-marked) ; optional
         ("}" . ibuffer-forward-next-marked)   ; optional
         ("[" . ibuffer-backward-filter-group) ; optional
         ("]" . ibuffer-forward-filter-group)  ; optional
         ("$" . ibuffer-toggle-filter-group))  ; optional
  :after (ibuffer))

(use-package re-builder
  :straight t
  :defer t)
(use-package casual-re-builder
  :straight t
  :ensure nil
  :bind (:map
         reb-mode-map ("C-o" . casual-re-builder-tmenu)
         :map
         reb-lisp-mode-map ("C-o" . casual-re-builder-tmenu))
  :after (re-builder))

(use-package bookmark
  :straight t
  :ensure nil
  :defer t)
(use-package casual-bookmarks
  :straight t
  :ensure nil
  :bind (:map bookmark-bmenu-mode-map
              ("C-o" . casual-bookmarks-tmenu)
              ("S" . casual-bookmarks-sortby-tmenu)
              ("J" . bookmark-jump))
  :after (bookmark))

(use-package all-the-icons-ivy
  :straight t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup)
  :config (setq all-the-icons-ivy-file-commands
      '(counsel-find-file counsel-file-jump counsel-recentf counsel-projectile-find-file counsel-projectile-find-dir counsel-switch-buffer)))

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

(use-package nerd-icons
  :straight t
  :config
  (setq nerd-icons-font-family "Symbols Nerd Font Mono"))

;;(straight-use-package 'dracula-theme)
;;(load-theme 'dracula t)
(use-package spacegray-theme
  :straight t
  :defer t)
(use-package doom-themes
  :straight t
  :defer t)
;;(load-theme 'doom-palenight t)

(use-package modus-themes
  :straight t
  :defer t)

(setq modus-themes-common-palette-overrides
      '((border-mode-line-active unspecified)
        (border-mode-line-inactive unspecified)))

(setq modus-themes-headings
      '((1 . (variable-pitch 1.5))
        (2 . (1.3))
        (3 . (1.2))
        (4 . (1.1))
        (agenda-date . (1.3))
        (agenda-structure . (variable-pitch light 1.8))
        (t . (1.1))))

(setq modus-themes-org-blocks 'gray-background)
(load-theme 'modus-vivendi t)
;;(setq modus-themes-common-palette-overrides modus-themes-preset-overrides-intense)

 ;;   (use-package powerline
 ;;     :straight t
 ;;     :config
 ;;     (require 'powerline)
 ;;     (powerline-center-theme))

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))
(setq doom-modeline-height 40)
(display-time-mode 1)
(setq display-time-format "%I:%M:%S")
(setq display-time-interval 1)

(use-package minions
  :straight t
  :config (minions-mode 1)
  (keymap-global-set "<f7>" #'minions-minor-modes-menu))

(setq ispell-program-name "aspell")
(setq ispell-dictionary "english")
(setq ispell-personal-dictionary "~/.aspell.en.pws")
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-mode)
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-.") nil))
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") nil))

(use-package hackernews
  :straight t)

(use-package hnreader
  :straight t)

(use-package md4rd
  :straight t
  :config
  (setq md4rd-subs-active '(emacs math freebsd bsd compsci askcomputerscience computerarchitecture
                                  programming learnprogramming vim learnmath
                                  cprog c_language c_programming cplusplus python learnpython java javascript ruby
                                  rust learnrust lisp artificial machinelearning
                                  neuralnetworks linearalgebra explainlikeimfive
                                  css react webdev latex technology)))

(use-package greader
  :straight t)

;;(use-package debbugs
;;  :straight t)

  ;; Enable vertico
  ;; (use-package vertico
  ;;   :straight t
  ;;   :init
  ;;   (vertico-mode)

  ;;   ;; Different scroll margin
  ;;   ;; (setq vertico-scroll-margin 0)

  ;;   ;; Show more candidates
  ;;   ;; (setq vertico-count 20)

  ;;   ;; Grow and shrink the Vertico minibuffer
  ;;   ;; (setq vertico-resize t)

  ;;   ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;;   ;; (setq vertico-cycle t)
  ;;   )

  (straight-use-package '( vertico :files (:defaults "extensions/*")
                           :includes (vertico-buffer
                                      vertico-directory
                                      vertico-flat
                                      vertico-indexed
                                      vertico-mouse
                                      vertico-quick
                                      vertico-repeat
                                      vertico-reverse)))
  (vertico-mode)
  ;; Persist history over Emacs restarts. Vertico sorts by history position.
  (use-package savehist
    :straight t
    :init
    (savehist-mode))

  ;; A few more useful configurations...
  (use-package emacs
    :straight t
    :init
    ;; Add prompt indicator to `completing-read-multiple'.
    ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
    (defun crm-indicator (args)
      (cons (format "[CRM%s] %s"
                    (replace-regexp-in-string
                     "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                     crm-separator)
                    (car args))
            (cdr args)))
    (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

    ;; Do not allow the cursor in the minibuffer prompt
    (setq minibuffer-prompt-properties
          '(read-only t cursor-intangible t face minibuffer-prompt))
    (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

    ;; TAB cycle if there are only few candidates
    (setq completion-cycle-threshold 3)

    ;; Enable indentation+completion using the TAB key.
    ;; `completion-at-point' is often bound to M-TAB.
    (setq tab-always-indent 'complete)

    ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
    ;; Vertico commands are hidden in normal buffers.
    ;; (setq read-extended-command-predicate
    ;;       #'command-completion-default-include-p)

    ;; Enable recursive minibuffers
    (setq enable-recursive-minibuffers t))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :straight t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Example configuration for Consult
(use-package consult
  :straight t
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both c and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :straight t
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package corfu
  :straight t
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-excluded-modes'.
  :init
  (global-corfu-mode)
)
;; A few more useful configurations...
(use-package emacs
  :straight t
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package embark
  :straight t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :straight t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package consult-lsp
  :straight t)

(use-package amx :straight t)

;; (use-package swiper :straight t)
;; (ivy-mode)
;; (setq ivy-use-virtual-buffers t)
;; (setq enable-recursive-minibuffers t)
;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; ;;(global-set-key (kbd "M-x") 'amx)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-load-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

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

(use-package dired-rainbow
  :straight t
  :defer 2
  :config
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  (dired-rainbow-define media "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  (dired-rainbow-define log "#c17d11" ("log"))
  (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))

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

(use-package powerthesaurus
  :straight t)

(use-package hyperbole
  :straight t
  :init
  (load "hyperbole-autoloads")
  (load "hyperbole")
  :config
  (require 'hyperbole)
  (setq hbmap:dir-user "~/gtd/hyperbole/")
  (setq hyrolo-file-list '("~/gtd/hyperbole/ideas.org"))
  (setq hyrolo-date-format "%Y-%m-%d %H:%M:%S")
  (setq hyrolo-kill-buffers-after-use t)
  (global-set-key [f7] 'hyrolo-fgrep)
  :bind* ("<M-return>" . hkey-either))

(use-package inform
  :straight t
  :config
  (require 'inform))

(use-package drag-stuff
  :straight t
  :config
  (require 'drag-stuff)
  ;;(drag-stuff-global-mode 1)
  (add-hook 'prog-mode-hook #'drag-stuff-mode)
  (drag-stuff-define-keys))

(use-package pdf-view-restore
  :straight t
  :after pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

(use-package bookmark+
  :straight t
  :config
  (require 'bookmark+))

(defun my-bmk-pdf-handler-advice (bookmark)
  (bookmark-default-handler (bookmark-get-bookmark bookmark)))

(advice-add 'pdf-view-bookmark-jump-handler
            :after 'my-bmk-pdf-handler-advice)

(use-package crux
  :straight t)

(use-package substitute
  :straight t
  :config
  (require 'substitute))

(let ((map global-map))
  (define-key map (kbd "M-p s") #'substitute-target-below-point)
  (define-key map (kbd "M-p r") #'substitute-target-above-point)
  (define-key map (kbd "M-p d") #'substitute-target-in-defun)
  (define-key map (kbd "M-p b") #'substitute-target-in-buffer))

(use-package visual-regexp
  :straight t
  :config
  (require 'visual-regexp)
  (define-key global-map (kbd "C-c s") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  ;; if you use multiple-cursors, this is for you:
  (define-key global-map (kbd "C-c j") 'vr/mc-mark))

(use-package comment-dwim-2
  :straight t
  :bind (("M-;" . comment-dwim-2)))

(use-package olivetti
  :straight t)

(use-package simple-httpd
  :straight t)

(use-package which-key
  :straight t
  :config
  (require 'which-key)
  (which-key-mode))

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
  ;; (add-to-list 'erc-modules 'spelling)
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
;;(setq org-log-repeat nil)
(setq org-log-reschedule 'time)
;;(setq org-todo-repeat-to-state "REPEAT")


(setq org-agenda-files (list "~/gtd/tasks.org"
                             "~/gtd/habits.org"
                             "~/gtd/goals.org"
                             "~/gtd/birthdays.org"
                             "~/org/inbox.org"))

(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 3)
                           (org-buffer-list :maxlevel . 2)))

;; Save Org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; Refile in a single go
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)
(setq org-refile-allow-creating-parent-nodes 'confirm)

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
      org-track-ordered-property-with-tag t
      org-agenda-dim-blocked-tasks t
      org-enforce-todo-checkbox-dependencies t
      org-attach-use-inheritance t
      org-use-property-inheritance t
      org-link-frame-setup '((file . find-file)))

(setq org-agenda-include-diary t
      diary-display-function #'diary-fancy-display)
     (add-hook 'diary-list-entries-hook #'diary-include-other-diary-files)
     (add-hook 'diary-list-entries-hook #'diary-sort-entries t)

(setq org-export-backends '(ascii beamer html latex md))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(setq org-clock-sound t) ;; Standard Emacs beep
(setq org-clock-sound "~/sounds/Smallbell.wav") ;; Play this sound file, fall back to beep
(add-to-list 'org-emphasis-alist
             '("*" (:foreground "green")
               ))
(add-hook 'org-mode-hook 'org-cdlatex-mode)

(setq org-ellipsis " ▼")

;;(org-agenda nil "a")
(add-hook 'after-init-hook 'org-agenda-list)

(defun my/org-agenda-list-current-buffer ()
  (interactive)
  (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
      (call-interactively #'org-agenda)))

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
      '((sequence "REPEAT(r)" "NEXT(n@/!)" "TODO(t@/!)" "WAITING(w@/!)" "SOMEDAY(s@/!)" "PROJ(p)" "|" "DONE(d@)" "CANCELLED(c@)")))

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
        ;; Put mutually exclusive tags here
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
          (tags-todo "ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

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
         ((todo "WAITING"
                ((org-agenda-overriding-header "Waiting on External")
                 (org-agenda-files org-agenda-files)))
          (todo "TODO"
                ((org-agenda-overriding-header "TODO")
                 (org-agenda-files org-agenda-files)))
          (todo "SOMEDAY"
                ((org-agenda-overriding-header "Someday")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "PROJ"
                ((org-agenda-overriding-header "Project Backlog")
                 (org-agenda-todo-list-sublevels nil)
                 (org-agenda-files org-agenda-files)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Ready for Action")
                 (org-agenda-files org-agenda-files)))
          (tags-todo  "ACTIVE"
                      ((org-agenda-overriding-header "Active Projects")
                       (org-agenda-files org-agenda-files)))
          (todo "DONE"
                ((org-agenda-overriding-header "Completed Items")
                 (org-agenda-files org-agenda-files)))
          (todo "CANCELLED"
                ((org-agenda-overriding-header "Cancelled Projects")
                 (org-agenda-files org-agenda-files)))))))

(setq org-latex-create-formula-image-program 'dvipng)

(setq org-catch-invisible-edits 'show-and-error)

(setq org-alphabetical-lists t)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(use-package zmq
  :straight t
  :config
  (require 'zmq))
(use-package jupyter
  :straight t
  :config
  (require 'jupyter))

(use-package ein
  :straight t
  :bind ("<f9>" . ein:worksheet-execute-cell-and-goto-next-km))

(org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t) (python . t) (js . t) (ruby . t) (shell . t) (jupyter . t)))
(setq org-config-babel-evaluate nil)

(straight-use-package 'org-re-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(setq org-default-notes-file "~/gtd/notes.org")
(setq org-capture-templates
      '(("t" "Tasks / Projects")
        ("tt" "Task" entry (file+olp "~/gtd/tasks.org" "Inbox")
         (file "~/gtd/tpl-todo.txt"))
        ("d" "Daily Plan")
        ("dp" "Plan" entry (file+olp+datetree "~/gtd/dailyplan.org")
         (file "~/gtd/tpl-dailyplan.txt"))
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
        ("gg" "Goal" entry (file+headline "~/gtd/goals.org" "Goals") (file "~/gtd/tpl-goal.org"))
        ("p" "Projects")
        ("pp" "Project" entry (file+headline "~/gtd/tasks.org" "Projects")(file "~/gtd/tpl-projects.txt"))
        ("b" "Books")
        ("bb" "Add book to read" entry (file+headline "~/gtd/tasks.org" "Books to read") (file "~/gtd/tpl-book.txt") :empty-lines-after 2)
        ("s" "Someday")
        ("ss" "Someday" entry (file+headline "~/gtd/tasks.org" "Someday") "* %i%? \n %U")
        ("w" "Waiting")
        ("ww" "Waiting" entry (file+headline "~/gtd/tasks.org" "Waiting") (file "~/gtd/tpl-waiting.txt"))
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

(defun my/copy-idlink-to-clipboard() "Copy an ID link with the
headline to killring, if no ID is there then create a new unique
ID. This function works only in org-mode or org-agenda buffers.
The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
(interactive)
(when (eq major-mode 'org-agenda-mode)
(org-agenda-show)
(org-agenda-goto))
(when (eq major-mode 'org-mode) ; do this only in org-mode buffers
(setq mytmphead (nth 4 (org-heading-components)))
(setq mytmpid (funcall 'org-id-get-create))
(setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
(kill-new mytmplink)
(message "Copied %s to killring (clipboard)" mytmplink)
))
(global-set-key (kbd "<f6>") 'my/copy-idlink-to-clipboard)

(defun org-reset-checkbox-state-maybe ()
"Reset all checkboxes in an entry
if the `RESET_CHECK_BOXES' property is set"
(interactive "∗")
(if (org-entry-get (point) "RESET_CHECK_BOXES")
    (org-reset-checkbox-state-subtree)))

(defun org-checklist ()
  (when (member org-state org-done-keywords)
    (org-reset-checkbox-state-maybe)))

(defun my-clockfiles ()
  (append org-agenda-files
          (file-expand-wildcards "~/gtd/track∗.org")))

(add-hook 'org-after-todo-state-change-hook 'org-checklist)

(use-package emacsql-sqlite3
  :straight t
  :config
  (require 'emacsql-sqlite3))

(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-project-finalize-hook ()
  "Adds the captured project file to `org-agenda-files' if the
capture was not aborted."
  ;; Remove the hook since it was added temporarily
  (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Add project file to the agenda list if the capture was confirmed
  (unless org-note-abort
    (with-current-buffer (org-capture-get :buffer)
      (add-to-list 'org-agenda-files (buffer-file-name)))))

(defun my/org-roam-find-project ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Select a project file to open, creating it if necessary
  (org-roam-node-find
   nil
   nil
   (my/org-roam-filter-by-tag "Project")
   :templates
   '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
      :unnarrowed t))))

(defun my/org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                  :if-new (file+head "Inbox.org" "#+title: Inbox\n")))))

(global-set-key (kbd "C-c n b") #'my/org-roam-capture-inbox)


(defun my/org-roam-capture-task ()
  (interactive)
  ;; Add the project file to the agenda after capture is finished
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

  ;; Capture the new task, creating the project file if necessary
  (org-roam-capture- :node (org-roam-node-read
                            nil
                            (my/org-roam-filter-by-tag "Project"))
                     :templates '(("p" "project" plain "** TODO %?"
                                   :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                                                          "#+title: ${title}\n#+category: ${title}\n#+filetags: Project"
                                                          ("Tasks"))))))

(global-set-key (kbd "C-c n t") #'my/org-roam-capture-task)


(defun my/org-roam-copy-todo-to-today ()
  (interactive)
  (let ((org-refile-keep t) ;; Set this to nil to delete the original!
        (org-roam-dailies-capture-templates
          '(("t" "tasks" entry "%?"
             :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
        (org-after-refile-insert-hook #'save-buffer)
        today-file
        pos)
    (save-window-excursion
      ;;(org-roam-dailies--capture (current-time) t)
      (setq today-file (buffer-file-name))
      (setq pos (point)))

    ;; Only refile if the target file is different than the current file
    (unless (equal (file-truename today-file)
                   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Tasks" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (equal org-state "DONE")
                 (my/org-roam-copy-todo-to-today))))


(use-package org-roam
  :straight t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "journal")

  (org-roam-capture-templates
   '(("b" "book notes" plain
      "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)
      ("d" "default" plain
       "%?"
       :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
       :unnarrowed t))
     )
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))
     ))


  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         ("C-c n p" . my/org-roam-find-project)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config


  (setq org-roam-database-connector 'sqlite3)
   ;; Bind this to C-c n I

  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                    '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  (org-roam-db-autosync-mode))

(straight-use-package
 '(org-timeblock :type git :host github :repo "ichernyshovvv/org-timeblock"))

(use-package djvu
  :straight t
  :config
  (require 'djvu))

(straight-use-package
  `(djvu3 :type git :host github :repo "dalanicolai/djvu3"))
(require 'djvu3)

(use-package nov
  :straight t
  :config
  (require 'nov))


(use-package org-pdftools
  :straight t
  :config
  (require 'org-pdftools)
  :hook (org-mode . org-pdftools-setup-link))

(use-package org-noter-pdftools
  :straight t
  :after org-noter
  :config
  ;; Add a function to ensure precise note is inserted
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions (if toggle-no-questions
                                                   (not org-noter-insert-note-no-questions)
                                                 org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))

  ;; fix https://github.com/weirdNox/org-noter/pull/93/commits/f8349ae7575e599f375de1be6be2d0d5de4e6cbf
  (defun org-noter-set-start-location (&optional arg)
    "When opening a session with this document, go to the current location.
With a prefix ARG, remove start location."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((inhibit-read-only t)
           (ast (org-noter--parse-root))
           (location (org-noter--doc-approx-location (when (called-interactively-p 'any) 'interactive))))
       (with-current-buffer (org-noter--session-notes-buffer session)
         (org-with-wide-buffer
          (goto-char (org-element-property :begin ast))
          (if arg
              (org-entry-delete nil org-noter-property-note-location)
            (org-entry-put nil org-noter-property-note-location
                           (org-noter--pretty-print-location location))))))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))

(use-package org-noter
  :straight t
  :config
  ;; Your org-noter config ........
  (require 'org-noter-pdftools)
  (setq org-noter-auto-save-last-location t))

(use-package org-web-tools
  :straight t)

(defvar yt-iframe-format
  ;; You may want to change your width and height.
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(org-add-link-type
 "yt"
 (lambda (handle)
   (browse-url
    (concat "https://www.youtube.com/embed/"
            handle)))
 (lambda (path desc backend)
   (cl-case backend
     (html (format yt-iframe-format
                   path (or desc "")))
     (latex (format "\href{%s}{%s}"
                    path (or desc "video"))))))

(straight-use-package 'company-prescient)

;; Use coreutils ls
;;(when (string= system-type "freebsd")
;;  (setq dired-use-ls-dired t
;;        insert-directory-program "gls"
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
       insert-directory-program "gls")
(setq dired-listing-switches "-laGh1v --group-directories-first")
(setq delete-by-moving-to-trash t)
(setq dired-dwim-target t)

(use-package all-the-icons-dired
  :straight t
  :hook (dired-mode . all-the-icons-dired-mode)
  :config
  (setq all-the-icons-dired-monochrome nil))

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

(with-eval-after-load 'dired
  (require 'dired-x)
  ;; Set dired-x global variables here.  For example:
  ;; (setq dired-x-hands-off-my-keys nil)
  )
(add-hook 'dired-mode-hook
          (lambda ()
            ;; Set dired-x buffer-local variables here.  For example:
            ;; (dired-omit-mode 1)
            ))

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
(global-set-key [remap dabbrev-expand] 'hippie-expand)

    (use-package yasnippet-snippets :straight t)

;; (setq ispell-program-name "aspell")
;; (setq ispell-dictionary "english")
;; (setq ispell-personal-dictionary "~/.aspell.en.pws")
;; (setq flycheck-checker-error-threshold 400)
;; (use-package flycheck-aspell
;;   :straight t
;;   :config
;;     (setq ispell-silently-savep t)
;;   ;; Ensure `flycheck-aspell' is available
;;   (require 'flycheck-aspell)
;;   ;; If you want to check TeX/LaTeX/ConTeXt buffers
;;   (add-to-list 'flycheck-checkers 'tex-aspell-dynamic)
;;   ;; If you want to check Markdown/GFM buffers
;;   (add-to-list 'flycheck-checkers 'markdown-aspell-dynamic)
;;   ;; If you want to check HTML buffers
;;   (add-to-list 'flycheck-checkers 'html-aspell-dynamic)
;;   ;; If you want to check XML/SGML buffers
;;   (add-to-list 'flycheck-checkers 'xml-aspell-dynamic)
;;   ;; If you want to check Nroff/Troff/Groff buffers
;;   (add-to-list 'flycheck-checkers 'nroff-aspell-dynamic)
;;   ;; If you want to check Texinfo buffers
;;   (add-to-list 'flycheck-checkers 'texinfo-aspell-dynamic)
;;   ;; If you want to check comments and strings for C-like languages
;;   (add-to-list 'flycheck-checkers 'c-aspell-dynamic)
;;   ;; If you want to check message buffers
;;   (add-to-list 'flycheck-checkers 'mail-aspell-dynamic)
;;   )

;; (flycheck-aspell-define-checker "org"
;;   "Org" ("--add-filter" "url")
;;   (org-mode))
;; (add-to-list 'flycheck-checkers 'org-aspell-dynamic)

;; (advice-add #'ispell-pdict-save :after #'flycheck-maybe-recheck)
;; (defun flycheck-maybe-recheck (_)
;;   (when (bound-and-true-p flycheck-mode)
;;    (flycheck-buffer)))

    (use-package multiple-cursors :straight t)
    (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
    (global-set-key (kbd "C->") 'mc/mark-next-like-this)
    (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(use-package aggressive-indent :straight t)

(global-set-key (kbd "C-z") 'undo-only)
(global-set-key (kbd "C-S-z") 'undo-redo)

(straight-use-package 'popup-kill-ring)
(global-set-key "\M-y" 'popup-kill-ring)

(use-package browse-kill-ring
  :straight t
  :config
  (require 'browse-kill-ring)
  (browse-kill-ring-default-keybindings))

;; (use-package wrap-region
;;   :straight   t
;;   :config
;;   (wrap-region-global-mode t)
;;   (wrap-region-add-wrappers
;;    '(("(" ")")
;;      ("[" "]")
;;      ("{" "}")
;;      ("<" ">")
;;      ("'" "'")
;;      ("\"" "\"")
;;      ("‘" "’"   "q")
;;      ("“" "”"   "Q")
;;      ("*" "*"   "b"   org-mode)                 ; bolden
;;      ("*" "*"   "*"   org-mode)                 ; bolden
;;      ("/" "/"   "i"   org-mode)                 ; italics
;;      ("/" "/"   "/"   org-mode)                 ; italics
;;      ("~" "~"   "c"   org-mode)                 ; code
;;      ("~" "~"   "~"   org-mode)                 ; code
;;      ("=" "="   "v"   org-mode)                 ; verbatim
;;      ("=" "="   "="   org-mode)                 ; verbatim
;;      ("_" "_"   "u" '(org-mode markdown-mode))  ; underline
;;      ("**" "**" "b"   markdown-mode)            ; bolden
;;      ("*" "*"   "i"   markdown-mode)            ; italics
;;      ("`" "`"   "c" '(markdown-mode ruby-mode)) ; code
;;      ("`" "'"   "c"   lisp-mode)                ; code
;;      ))
;;   :diminish wrap-region-mode)
;; (add-to-list 'wrap-region-except-modes 'web-mode)
;; (add-to-list 'wrap-region-except-modes 'cal-mode)
;; (add-to-list 'wrap-region-except-modes 'dired-mode)

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
(global-set-key (kbd "M-g M-c") 'avy-copy-line)
(global-set-key (kbd "M-g M-m") 'avy-move-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g M-j") 'avy-goto-char-timer)
(setq avy-timeout 1.0)

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
    (require 'smartparens-config)
    (add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
    (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
    (add-hook 'org-mode-hook 'turn-on-smartparens-strict-mode)
    (sp-local-pair 'org-mode "\\[" "\\]")
  (sp-local-pair 'org-mode "$" "$")
  (sp-local-pair 'org-mode "'" "'" :actions '(rem))
  (sp-local-pair 'org-mode "=" "=" :actions '(rem))
  (sp-local-pair 'org-mode "\\left(" "\\right)" :trigger "\\l(" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left[" "\\right]" :trigger "\\l[" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left\\{" "\\right\\}" :trigger "\\l{" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left|" "\\right|" :trigger "\\l|" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)))

(setq-default abbrev-mode t)

(use-package company
  :straight t
  :after lsp-mode
  :hook
  (after-init . global-company-mode)
  ;;(prog-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.7)
  )

(setq
 company-selection-wrap-around t
 company-show-numbers t
 company-require-match 'never
 company-dabbrev-downcase nil
 company-dabbrev-ignore-case t
 company-backends '(company-nxml
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

(use-package company-lsp
  :straight t
  :commands company-lsp
  :config
  (require 'company-lsp)
  (push 'company-lsp company-backends))

;; (use-package tide
;;   :straight t
;;   :config
;;   (add-hook 'js-mode-hook #'setup-tide-mode)
;;   (add-hook 'typescript-mode-hook #'setup-tide-mode))

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1))

(use-package company-box
  :straight t
  :hook (company-mode . company-box-mode))

(use-package js2-mode
  :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package lsp-mode :straight t
  :commands (lsp lsp-deferred)
  :hook ((js-mode . lsp)
         (js2-mode . lsp)
         (typescript-mode . lsp)
         (python-mode . lsp)
         (rust-mode . lsp))
  :init
  (require 'lsp)
  (add-to-list 'lsp-enabled-clients 'clangd)
  (setq lsp-rust-server 'rust-analyzer)
  (setq lsp-semgrep-server-command '("semgrep" "lsp"))
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'cpp-mode-hook 'lsp)
  :config
  (require 'lsp-mode)
  (setq lsp-enabled-clients '(ts-ls eslint clangd jedi pylsp rls rust-analyzer semgrep-ls))

  ;; Optional: Configure lsp-mode settings
  (setq lsp-prefer-flymake nil) ;; Use flycheck instead of flymake

  (define-key lsp-mode-map (kbd "C-c i") lsp-command-map)
  (lsp-enable-which-key-integration t)
  )

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-ui-mode)
  (add-hook 'lsp-mode-hook #'flycheck-mode))


(use-package dap-mode
  :straight t
  :hook ((lsp-mode . dap-mode)
         (lsp-mode . dap-ui-mode))
  :config
  (dap-mode 1))

(use-package company
  :straight t
  :config
  (add-hook 'after-init-hook 'global-company-mode))


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

;; (use-package lsp-ui
;;   :straight t
;;   :hook
;;   (lsp-mode . lsp-ui-mode)
;;   :custom
;;   (lsp-ui-doc-position 'at-point)
;;   (lsp-ui-sideline-show-hover))'
(use-package lsp-ui
  :straight t
  :commands (lsp-ui-mode)
  :custom
  ;; Sideline
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0)
  ;; Peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory nil)
  ;; Documentation
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0.2)
  ;; IMenu
  (lsp-ui-imenu-window-width 0)
  (lsp-ui-imenu--custom-mode-line-format nil)
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :straight t
  :after lsp
  :config
  (lsp-treemacs-sync-mode 1))

(use-package lsp-ivy
  :straight t)

(use-package rust-mode
  :straight t
  :config
  (require 'rust-mode)
  (add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil))))

(use-package cargo
  :straight t
  :hook (rust-mode . cargo-minor-mode))

(add-hook 'prog-mode-hook #'(lambda () (display-line-numbers-mode 1)))

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
  (require 'dap-java)
  (add-hook 'java-mode-hook #'lsp)
  (add-to-list 'lsp-enabled-clients 'jdtls))

(use-package py-autopep8
  :straight t)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(setq js-indent-level 2)
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))

(require 'dap-firefox)

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

(use-package ggtags
  :straight t
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1)))))
(setq lsp-clients-clangd-executable "/usr/local/bin/clangd17")

(use-package emmet-mode
  :straight t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  (add-hook 'lsp-mode-hook 'emmet-mode)
  )

(use-package prettier
  :straight t)

(add-hook 'js2-mode-hook 'prettier-mode)
(add-hook 'web-mode-hook 'prettier-mode)
(add-hook 'typescript-mode-hook 'prettier-mode)

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

(defun run-typescript-file ()
  "Run the current TypeScript file."
  (interactive)
  (let ((file (buffer-file-name)))
    (shell-command (concat "npx ts-node " file))))

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

(use-package geiser-mit :straight t)
(require 'geiser-mit)

(use-package magit
  :init (use-package transient :straight (transient :type git :host github :repo "magit/transient"))
  :bind ("C-x g" . magit-status))

;;(use-package forge
;;  :straight t
;;  :after magit)

  (use-package git-gutter
    :straight t
    :init
    (global-git-gutter-mode +1))

  (custom-set-variables
   '(git-gutter:update-interval 2))

(straight-use-package 'git-timemachine
    :straight t)

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

(global-set-key (kbd "C-c i") 'tab-to-tab-stop)
;; AucTeX settings - almost no changes
(use-package tex-site
  :ensure auctex)

(use-package latex
  :ensure auctex
  :hook ((LaTeX-mode . prettify-symbols-mode))
  :bind (:map LaTeX-mode-map
         ("C-S-e" . latex-math-from-calc))
  :config
  ;; Format math as a Latex string with Calc
  (defun latex-math-from-calc ()
    "Evaluate `calc' on the contents of line at point."
    (interactive)
    (cond ((region-active-p)
           (let* ((beg (region-beginning))
                  (end (region-end))
                  (string (buffer-substring-no-properties beg end)))
             (kill-region beg end)
             (insert (calc-eval `(,string calc-language latex
                                          calc-prefer-frac t
                                          calc-angle-mode rad)))))
          (t (let ((l (thing-at-point 'line)))
               (end-of-line 1) (kill-line 0)
               (insert (calc-eval `(,l
                                    calc-language latex
                                    calc-prefer-frac t
                                    calc-angle-mode rad)))))))
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
      (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")
  )))



;; CDLatex settings
(use-package cdlatex
  :ensure t
  :hook (LaTeX-mode . turn-on-cdlatex)
  :bind (:map cdlatex-mode-map
              ("<tab>" . cdlatex-tab)))

;; Yasnippet settings
(use-package yasnippet
  :ensure t
  :hook ((LaTeX-mode . yas-minor-mode)
         (post-self-insert . my/yas-try-expanding-auto-snippets))
  :config
  (use-package warnings
    :config
    (cl-pushnew '(yasnippet backquote-change)
                warning-suppress-types
                :test 'equal))

  (setq yas-triggers-in-field t)

  ;; Function that tries to autoexpand YaSnippets
  ;; The double quoting is NOT a typo!
  (defun my/yas-try-expanding-auto-snippets ()
    (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (let ((yas-buffer-local-condition ''(require-snippet-condition . auto)))
        (yas-expand)))))

;; CDLatex integration with YaSnippet: Allow cdlatex tab to work inside Yas
;; fields
(use-package cdlatex
  :hook ((cdlatex-tab . yas-expand)
         (cdlatex-tab . cdlatex-in-yas-field))
  :config
  (use-package yasnippet
    :bind (:map yas-keymap
           ("<tab>" . yas-next-field-or-cdlatex)
           ("TAB" . yas-next-field-or-cdlatex))
    :config
    (defun cdlatex-in-yas-field ()
      ;; Check if we're at the end of the Yas field
      (when-let* ((_ (overlayp yas--active-field-overlay))
                  (end (overlay-end yas--active-field-overlay)))
        (if (>= (point) end)
            ;; Call yas-next-field if cdlatex can't expand here
            (let ((s (thing-at-point 'sexp)))
              (unless (and s (assoc (substring-no-properties s)
                                    cdlatex-command-alist-comb))
                (yas-next-field-or-maybe-expand)
                t))
          ;; otherwise expand and jump to the correct location
          (let (cdlatex-tab-hook minp)
            (setq minp
                  (min (save-excursion (cdlatex-tab)
                                       (point))
                       (overlay-end yas--active-field-overlay)))
            (goto-char minp) t))))

    (defun yas-next-field-or-cdlatex nil
      (interactive)
      "Jump to the next Yas field correctly with cdlatex active."
      (if
          (or (bound-and-true-p cdlatex-mode)
              (bound-and-true-p org-cdlatex-mode))
          (cdlatex-tab)
        (yas-next-field-or-maybe-expand)))))

;; Array/tabular input with org-tables and cdlatex
(use-package org-table
  :after cdlatex
  :bind (:map orgtbl-mode-map
              ("<tab>" . lazytab-org-table-next-field-maybe)
              ("TAB" . lazytab-org-table-next-field-maybe))
  :init
  (add-hook 'cdlatex-tab-hook 'lazytab-cdlatex-or-orgtbl-next-field 90)
  ;; Tabular environments using cdlatex
  (add-to-list 'cdlatex-command-alist '("smat" "Insert smallmatrix env"
                                       "\\left( \\begin{smallmatrix} ? \\end{smallmatrix} \\right)"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("bmat" "Insert bmatrix env"
                                       "\\begin{bmatrix} ? \\end{bmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("pmat" "Insert pmatrix env"
                                       "\\begin{pmatrix} ? \\end{pmatrix}"
                                       lazytab-position-cursor-and-edit
                                       nil nil t))
  (add-to-list 'cdlatex-command-alist '("tbl" "Insert table"
                                        "\\begin{table}\n\\centering ? \\caption{}\n\\end{table}\n"
                                       lazytab-position-cursor-and-edit
                                       nil t nil))
  :config
  ;; Tab handling in org tables
  (defun lazytab-position-cursor-and-edit ()
    ;; (if (search-backward "\?" (- (point) 100) t)
    ;;     (delete-char 1))
    (cdlatex-position-cursor)
    (lazytab-orgtbl-edit))

  (defun lazytab-orgtbl-edit ()
    (advice-add 'orgtbl-ctrl-c-ctrl-c :after #'lazytab-orgtbl-replace)
    (orgtbl-mode 1)
    (open-line 1)
    (insert "\n|"))

  (defun lazytab-orgtbl-replace (_)
    (interactive "P")
    (unless (org-at-table-p) (user-error "Not at a table"))
    (let* ((table (org-table-to-lisp))
           params
           (replacement-table
            (if (texmathp)
                (lazytab-orgtbl-to-amsmath table params)
              (orgtbl-to-latex table params))))
      (kill-region (org-table-begin) (org-table-end))
      (open-line 1)
      (push-mark)
      (insert replacement-table)
      (align-regexp (region-beginning) (region-end) "\\([:space:]*\\)& ")
      (orgtbl-mode -1)
      (advice-remove 'orgtbl-ctrl-c-ctrl-c #'lazytab-orgtbl-replace)))

  (defun lazytab-orgtbl-to-amsmath (table params)
    (orgtbl-to-generic
     table
     (org-combine-plists
      '(:splice t
                :lstart ""
                :lend " \\\\"
                :sep " & "
                :hline nil
                :llend "")
      params)))

  (defun lazytab-cdlatex-or-orgtbl-next-field ()
    (when (and (bound-and-true-p orgtbl-mode)
               (org-table-p)
               (looking-at "[[:space:]]*\\(?:|\\|$\\)")
               (let ((s (thing-at-point 'sexp)))
                 (not (and s (assoc s cdlatex-command-alist-comb)))))
      (call-interactively #'org-table-next-field)
      t))

  (defun lazytab-org-table-next-field-maybe ()
    (interactive)
    (if (bound-and-true-p cdlatex-mode)
        (cdlatex-tab)
      (org-table-next-field))))

(setq latex-run-command "lualatex")

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
      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \w\|$\\)\\|^[\"]\"[#'()]")

(defun gm-nnir-group-make-gmail-group (query)
  "Use GMail search syntax.
See https://support.google.com/mail/answer/7190?hl=en for syntax. "
  (interactive "sGMail Query: ")
  (let ((nnir-imap-default-search-key "imap")
        (q (format "X-GM-RAW \"%s\"" query)))
    (cond
     ((gnus-group-group-name)           ; Search current group
      (gnus-group-make-nnir-group
       nil                              ; no extra params needed
       `(nnir-specs (nnir-query-spec (query ,q)))))
     (t (error "Not on a group.")))))

(define-key gnus-group-mode-map "/" 'gm-nnir-group-make-gmail-group)

(defhydra hydra-elfeed ()
  "filter"
  ("S" (elfeed-search-set-filter "@6-month-ago +systemcrafters") "systemcrafters")
  ("h" (elfeed-search-set-filter "@6-month-ago +hackernews") "hackernews")
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

(use-package mastodon
  :straight t
  :config
  (setq mastodon-instance-url "https://emacs.ch"
        mastodon-active-user "polyrob"))

(use-package denote
  :straight t
  :config
  (require 'denote)
  (setq denote-directory (expand-file-name "~/denote/notes/")))
