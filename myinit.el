(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file) (load custom-file))

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :weight 'light
                    :height 140)

(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :weight 'light
                    :height 140)

(set-face-attribute 'variable-pitch nil
                    :font "Iosevka Light"
                    :weight 'light
                    :height 140)

(setq inhibit-startup-message t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(set-fringe-mode 10)
(show-paren-mode 1)
(setq ring-bell-function #'ignore)
(setq use-dialog-box nil)
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default fill-column 72
              tab-width 4
              indent-tabs-mode nil)
(global-visual-line-mode t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(global-hl-line-mode t)
(setq disabled-command-function nil)
(setq echo-keystrokes 0.5)
(setq help-window-select t)
(setq frame-title-format
      '("" invocation-name ": "
        (:eval (replace-regexp-in-string "^ +" "" (buffer-name)))))

(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(make-directory "~/.emacs.d/autosave/" t)
(make-directory "~/.emacs.d/backups/" t)

(setq backup-directory-alist '((".*" . "~/.emacs.d/backups/")))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq auto-save-list-file-prefix autosave-dir
      auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(recentf-mode t)
(setq recentf-save-file "~/.emacs.d/recentf"
      recentf-max-saved-items 50)

(use-package saveplace :straight t
  :init (save-place-mode 1))
(setq save-place-file "~/.emacs.d/saveplace")

(setq auto-revert-use-notify nil)
(global-auto-revert-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(setq load-prefer-newer t)
(use-package auto-compile :straight t
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode))

;; Print via CUPS
(setq lpr-command "gtklp"
      ps-lpr-command "gtklp")

;; Fix oh-my-zsh eterm color issue
(setq system-uses-terminfo nil)

;; Dictionary
(setq dictionary-server "dict.org")

;; Set these paths explicitly and early — before any packages load.
;; /usr/local/bin  — jupyter, ruff
;; ~/.local/bin    — black (installed via pip install --user)
(dolist (path '("/usr/local/bin" "/home/rob/.local/bin"))
  (add-to-list 'exec-path path))
(setenv "PATH" (concat "/usr/local/bin:/home/rob/.local/bin:" (getenv "PATH")))

;; exec-path-from-shell syncs the rest of the shell PATH for completeness.
(use-package exec-path-from-shell :straight t
  :config
  (exec-path-from-shell-initialize))

(use-package modus-themes :straight t :defer t)
(use-package doom-themes  :straight t :defer t)
(use-package spacegray-theme :straight t :defer t)

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

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

(use-package nerd-icons
  :straight t
  :config
  (setq nerd-icons-font-family "Symbols Nerd Font Mono"))

(use-package doom-modeline
  :straight t
  :init (doom-modeline-mode 1))

(setq doom-modeline-height 40
      doom-modeline-env-enable-python nil)
(display-time-mode 1)
(setq display-time-format "%I:%M:%S"
      display-time-interval 1)

(use-package minions
  :straight t
  :config
  (minions-mode 1)
  (keymap-global-set "<f7>" #'minions-minor-modes-menu))

(straight-use-package '(vertico :files (:defaults "extensions/*")
                         :includes (vertico-buffer
                                    vertico-directory
                                    vertico-flat
                                    vertico-indexed
                                    vertico-mouse
                                    vertico-quick
                                    vertico-repeat
                                    vertico-reverse)))
(vertico-mode)

(use-package savehist :straight t
  :init
  (setq savehist-file "~/.emacs.d/savehist"
        history-length 150)
  (savehist-mode))

(use-package emacs :straight t
  :init
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  (setq completion-cycle-threshold 3
        tab-always-indent 'complete
        enable-recursive-minibuffers t))

(use-package orderless :straight t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult :straight t
  :bind (("C-c h"   . consult-history)
         ("C-c m"   . consult-mode-command)
         ("C-c k"   . consult-kmacro)
         ("C-x M-:" . consult-complex-command)
         ("C-x b"   . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ("M-#"     . consult-register-load)
         ("M-'"     . consult-register-store)
         ("C-M-#"   . consult-register)
         ("M-y"     . consult-yank-pop)
         ("M-g e"   . consult-compile-error)
         ("M-g f"   . consult-flymake)
         ("M-g g"   . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o"   . consult-outline)
         ("M-g m"   . consult-mark)
         ("M-g k"   . consult-global-mark)
         ("M-g i"   . consult-imenu)
         ("M-g I"   . consult-imenu-multi)
         ("M-s d"   . consult-find)
         ("M-s D"   . consult-locate)
         ("M-s g"   . consult-grep)
         ("M-s G"   . consult-git-grep)
         ("M-s r"   . consult-ripgrep)
         ("M-s l"   . consult-line)
         ("M-s L"   . consult-line-multi)
         ("M-s k"   . consult-keep-lines)
         ("M-s u"   . consult-focus-lines)
         ("M-s e"   . consult-isearch-history)
         :map isearch-mode-map
         ("M-e"   . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (setq consult-narrow-key "<")
  (with-eval-after-load 'consult
    (consult-customize
     consult-theme
     consult-ripgrep consult-git-grep consult-grep
     consult-bookmark consult-recent-file consult-xref
     :preview-key '(:debounce 0.4 any))))

(use-package consult-lsp :straight t)

(use-package marginalia :straight t
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init (marginalia-mode))

(use-package corfu :straight t
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode 1)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.15)
  (corfu-auto-prefix 2)
  (corfu-cycle t))

(use-package cape :straight t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package yasnippet-capf :straight t
  :after (yasnippet)
  :init
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package embark :straight t
  :bind (("C-."   . embark-act)
         ("C-;"   . embark-dwim)
         ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult :straight t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package amx :straight t)

(use-package which-key :straight t
  :config (which-key-mode))

(use-package hydra :straight t)

(use-package helpful :straight t
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command]  . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key]      . helpful-key))

;; Config helpers
(defun config-visit ()
  "Open the Emacs configuration file."
  (interactive)
  (find-file "~/.emacs.d/myinit.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  "Reload the Emacs configuration file."
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org")))
(global-set-key (kbd "C-c r") 'config-reload)

;; Buffer & window management
(global-set-key (kbd "<f5>")     'revert-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-z")     'undo-only)
(global-set-key (kbd "C-S-z")   'undo-redo)
(global-set-key (kbd "M-o")     'ace-window)

;; Search
(global-set-key (kbd "C-|")   'avy-goto-char)
(global-set-key (kbd "C-'")   'avy-goto-char-2)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g E") 'avy-goto-word-0)
(global-set-key (kbd "M-g M-j") 'avy-goto-char-timer)
(global-set-key (kbd "M-g M-c") 'avy-copy-line)
(global-set-key (kbd "M-g M-m") 'avy-move-line)

;; Editing utilities
(global-set-key [remap dabbrev-expand] 'hippie-expand)

;; Lorem ipsum
(global-set-key (kbd "C-c C-i s") 'lorem-ipsum-insert-sentences)
(global-set-key (kbd "C-c C-i p") 'lorem-ipsum-insert-paragraphs)
(global-set-key (kbd "C-c C-i l") 'lorem-ipsum-insert-list)

;; Substitute
(define-key global-map (kbd "M-p s") #'substitute-target-below-point)
(define-key global-map (kbd "M-p r") #'substitute-target-above-point)
(define-key global-map (kbd "M-p d") #'substitute-target-in-defun)
(define-key global-map (kbd "M-p b") #'substitute-target-in-buffer)

;; Visual regexp
(define-key global-map (kbd "C-c s") 'vr/replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
(define-key global-map (kbd "C-c j") 'vr/mc-mark)

;; Other
(global-set-key [f8]  'neotree-toggle)
(global-set-key [f10] 'hydra-org/body)
(global-set-key (kbd "<f6>") 'my/copy-idlink-to-clipboard)
(global-set-key (kbd "C-x p i") 'org-cliplink)

(setq ibuffer-saved-filter-groups
      '(("default"
         ("dired"       (mode . dired-mode))
         ("org"         (name . "^.*org$"))
         ("web"         (or (mode . web-mode) (mode . js2-mode)))
         ("shell"       (or (mode . eshell-mode) (mode . shell-mode)))
         ("mu4e"        (name . "\*mu4e\*"))
         ("programming" (or (mode . python-mode) (mode . c++-mode)))
         ("emacs"       (or (name . "^\\*scratch\\*$")
                            (name . "^\\*Messages\\*$"))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil
      ibuffer-expert t)

(defvar my-cpp-other-file-alist
  '(("\\.cpp\\'" (".hpp" ".ipp"))
    ("\\.ipp\\'" (".hpp" ".cpp"))
    ("\\.hpp\\'" (".ipp" ".cpp"))
    ("\\.cxx\\'" (".hxx" ".ixx"))
    ("\\.ixx\\'" (".cxx" ".hxx"))
    ("\\.hxx\\'" (".ixx" ".cxx"))
    ("\\.c\\'" (".h"))
    ("\\.h\\'" (".c"))))

(setq-default ff-other-file-alist 'my-cpp-other-file-alist)
(add-hook 'c-mode-hook
          (lambda ()
            (local-set-key (kbd "M-o") #'ff-find-other-file)))

(use-package ace-window :straight t
  :init
  (global-set-key (kbd "M-o") 'ace-window))

(use-package avy :straight t
  :config
  (avy-setup-default)
  (setq avy-timeout 1.0))

(when (fboundp 'winner-mode)
  (winner-mode 1))

(use-package neotree :straight t
  :config (global-set-key [f8] 'neotree-toggle))

(use-package casual
  :straight (casual :type git :host github :repo "kickingvegas/casual"))

(setq ispell-program-name "aspell"
      ispell-dictionary "english"
      ispell-personal-dictionary "~/.aspell.en.pws")

(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)

;; Free up C-. and C-; from flyspell (used by embark)
(with-eval-after-load 'flyspell
  (define-key flyspell-mode-map (kbd "C-.") nil)
  (define-key flyspell-mode-map (kbd "C-;") nil))

(use-package yasnippet :straight t
  :config
  (yas-global-mode 1)
  (define-key yas-minor-mode-map (kbd "C-c j") yas-maybe-expand)
  (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
  (setq yas-trigger-key "TAB"))

(use-package yasnippet-snippets :straight t :after yasnippet)

(use-package multiple-cursors :straight t)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)

(use-package expand-region :straight t
  :config
  (defun ha/expand-region (lines)
    "Prefix-aware wrapper around `er/expand-region'.
With no prefix: expand normally. Positive prefix: select down N lines.
Zero prefix: select current line. Negative prefix: select up N lines."
    (interactive "p")
    (cond ((= lines 1)  (er/expand-region 1))
          ((< lines 0)  (ha/expand-previous-line-as-region lines))
          (t            (ha/expand-next-line-as-region (1+ lines)))))

  (defun ha/expand-next-line-as-region (lines)
    (beginning-of-line)
    (set-mark (point))
    (end-of-line lines))

  (defun ha/expand-previous-line-as-region (lines)
    (end-of-line)
    (set-mark (point))
    (beginning-of-line (1+ lines)))

  :bind ("C-=" . ha/expand-region))

(use-package smartparens :straight t
  :config
  (require 'smartparens-config)
  (add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)
  (add-hook 'org-mode-hook      'turn-on-smartparens-strict-mode)
  ;; Org-mode pair shortcuts
  (sp-local-pair 'org-mode "\\[" "\\]")
  (sp-local-pair 'org-mode "$" "$")
  (sp-local-pair 'org-mode "'" "'" :actions '(rem))
  (sp-local-pair 'org-mode "=" "=" :actions '(rem))
  (sp-local-pair 'org-mode "\\left("  "\\right)"  :trigger "\\l(" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left["  "\\right]"  :trigger "\\l[" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left\\{" "\\right\\}" :trigger "\\l{" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (sp-local-pair 'org-mode "\\left|"  "\\right|"  :trigger "\\l|" :post-handlers '(sp-latex-insert-spaces-inside-pair))
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

;; Aggressive indentation (keeps code always indented)
(use-package aggressive-indent :straight t)

;; Hungry delete — remove all whitespace in one delete keystroke
(use-package hungry-delete :straight t
  :config (global-hungry-delete-mode))

;; Comment smarter
(use-package comment-dwim-2 :straight t
  :bind ("M-;" . comment-dwim-2))

;; Drag lines/regions up and down
(use-package drag-stuff :straight t
  :config
  (add-hook 'prog-mode-hook #'drag-stuff-mode)
  (drag-stuff-define-keys))

;; Text folding à la Vim
(use-package vimish-fold :straight t
  :config
  (vimish-fold-global-mode 1)
  (global-set-key (kbd "C-c v f") #'vimish-fold)
  (global-set-key (kbd "C-c v v") #'vimish-fold-delete))

;; Substitute (structural find/replace)
(use-package substitute :straight t
  :config (require 'substitute))

;; Visual regexp
(use-package visual-regexp :straight t
  :config (require 'visual-regexp))

;; Abbrev mode
(setq-default abbrev-mode t)

(use-package ws-butler :straight t
  :hook ((text-mode . ws-butler-mode)
         (prog-mode . ws-butler-mode)))

;; Auto-fill in text modes
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Hippie expand
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

(use-package whitespace :straight t
  :bind ("C-c T w" . whitespace-mode)
  :init
  (setq whitespace-line-column nil
        whitespace-display-mappings
        '((space-mark   32 [183] [46])
          (newline-mark 10 [9166 10])
          (tab-mark      9 [9654 9] [92 9])))
  :config
  (set-face-attribute 'whitespace-space       nil :foreground "#666666" :background nil)
  (set-face-attribute 'whitespace-newline     nil :foreground "#666666" :background nil)
  (set-face-attribute 'whitespace-indentation nil :foreground "#666666" :background nil))

(straight-use-package 'highlight-indent-guides)
(setq highlight-indent-guides-method 'column)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(straight-use-package 'rainbow-delimiters)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package rainbow-mode :straight t
  :init (add-hook 'prog-mode-hook 'rainbow-mode))

(setq dired-use-ls-dired t
      insert-directory-program "gls"
      dired-listing-switches "-laGh1v --group-directories-first"
      delete-by-moving-to-trash t
      dired-dwim-target t)

(use-package all-the-icons-dired :straight t
  :hook (dired-mode . all-the-icons-dired-mode)
  :config (setq all-the-icons-dired-monochrome nil))

(use-package dired-hide-dotfiles :straight t
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (define-key dired-mode-map (kbd "C-c t") 'dired-hide-dotfiles-mode))

(use-package dired+ :straight t
  :config (require 'dired+))

(use-package dired-rainbow :straight t :defer 2
  :config
  (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
  (dired-rainbow-define html       "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
  (dired-rainbow-define xml        "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
  (dired-rainbow-define document   "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
  (dired-rainbow-define markdown   "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
  (dired-rainbow-define database   "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
  (dired-rainbow-define media      "#de751f" ("mp3" "mp4" "mkv" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
  (dired-rainbow-define image      "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
  (dired-rainbow-define log        "#c17d11" ("log"))
  (dired-rainbow-define shell      "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
  (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
  (dired-rainbow-define compiled   "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
  (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
  (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
  (dired-rainbow-define packaged   "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
  (dired-rainbow-define encrypted  "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
  (dired-rainbow-define fonts      "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
  (dired-rainbow-define partition  "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
  (dired-rainbow-define vc         "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
  (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*"))

(with-eval-after-load 'dired
  (require 'dired-x))

(use-package projectile :straight t
  :config (projectile-mode)
  :custom ((projectile-completion-system 'default))
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/")
    (setq projectile-project-search-path '("~/Projects/")))
  (setq projectile-switch-project-action #'projectile-dired
        projectile-verbose nil
        projectile-report-on-errors nil
        projectile-indexing-method 'native))

(use-package bookmark+ :straight t
  :config (require 'bookmark+))

;; Restore PDF position after jumping to a bookmark
(defun my-bmk-pdf-handler-advice (bookmark)
  (bookmark-default-handler (bookmark-get-bookmark bookmark)))

(advice-add 'pdf-view-bookmark-jump-handler
            :after 'my-bmk-pdf-handler-advice)

;; 2. THE LSP SUITE
(use-package lsp-mode
  :straight t
  :commands (lsp lsp-deferred)
  :hook ((js-mode          . lsp)
         (js2-mode         . lsp)
         (typescript-mode  . lsp)
         (python-mode      . lsp-deferred)
         (python-ts-mode   . lsp-deferred)
         (rust-mode        . lsp)
         (rust-ts-mode     . lsp)
         (go-mode          . lsp-deferred)
         (go-ts-mode       . lsp-deferred)
         (c-mode           . lsp)
         (c-ts-mode        . lsp)
         (c++-mode         . lsp)
         (c++-ts-mode      . lsp)
         (java-mode        . lsp-deferred)
         (java-ts-mode     . lsp-deferred))
  :init
  ;; Move the silence flags to the very top of :init
  (setq lsp-warn-no-matched-clients nil)
  (setq lsp-log-io nil)
  (setq lsp-completion-provider :none
        lsp-rust-server 'rust-analyzer
        lsp-headerline-breadcrumb-enable t
        lsp-idle-delay 0.1
        gc-cons-threshold (* 100 1024 1024)
        read-process-output-max (* 1024 1024))
  :config
  ;; Explicitly define enabled/disabled to stop the "searching" noise
  (setq lsp-enabled-clients '(gopls jdtls clangd pylsp rust-analyzer ruff))
  (setq lsp-disabled-clients '(rls semgrep-ls))

  ;; Use clippy for Rust to avoid the 'no library targets' error
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")

  (define-key lsp-mode-map (kbd "C-c i") lsp-command-map)
  (lsp-enable-which-key-integration t))

;; 3. UI, SNIPPETS, AND DIAGNOSTICS
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'flycheck-mode)
  (yas-global-mode))

(use-package lsp-ui :straight t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0)
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-show-directory nil)
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-doc-delay 0.2)
  (lsp-ui-imenu-window-width 0)
  (lsp-ui-imenu--custom-mode-line-format nil))

(use-package lsp-treemacs :straight t :after lsp
  :config (lsp-treemacs-sync-mode 1))

(use-package dap-mode :straight t
  :hook ((lsp-mode . dap-mode)
         (dap-mode . dap-ui-mode))
  :config
  ;; dap-cpptools is a sub-module of dap-mode; require it here after dap-mode loads
  (require 'dap-cpptools))

(use-package flycheck :straight t
  :init (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package consult-flycheck :straight t
  :bind (("M-g F" . consult-flycheck)))

(use-package sideline :straight t
  :hook (flycheck-mode . sideline-mode))

(use-package sideline-flycheck :straight t
  :hook (flycheck-mode . sideline-flycheck-setup)
  :custom
  (sideline-flycheck-display-mode 'line)
  (sideline-backends-right '(sideline-flycheck)))

(use-package treesit-auto :straight t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode)
  (setq treesit-extra-load-path '("/usr/local/lib/tree-sitter" "/usr/local/lib"))
  (setq treesit-auto-langs '(python java c c++ rust html css json)) ; Add the ones you use
  ;; Add these manually since the auto-function failed
  (add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))
  (add-to-list 'major-mode-remap-alist '(java-mode   . java-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c-mode      . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode    . c++-ts-mode))
  (add-to-list 'major-mode-remap-alist '(go-mode     . go-ts-mode))) ;; This does the remapping automatically

(add-hook 'prog-mode-hook #'(lambda () (display-line-numbers-mode 1)))

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook       'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.1
      eldoc-echo-area-use-multiline-p nil)

(use-package ggtags :straight t
  :config
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1)))))

(setq lsp-clients-clangd-executable "/usr/local/bin/clangd19")

(use-package rust-mode :straight t
  :config
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil))))

(use-package cargo :straight t
  :hook (rust-mode . cargo-minor-mode))

(setq python-shell-interpreter "/usr/local/bin/python"
      python-indent-guess-indent-offset-verbose nil)



(with-eval-after-load 'dap-mode
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy))

(use-package lsp-pyls :straight nil
  :after lsp-mode
  :init
  (setq lsp-clients-python-command "pylsp"
        lsp-pyls-disable-warning t)

  (defun my/python-lsp-start ()
    (interactive)
    (setq-local lsp-enabled-clients '(pyls))
    (setq-local lsp-disabled-clients '(jedi pyright))
    (lsp-deferred))

  (defun my/python-organize-imports ()
    (interactive)
    (when (buffer-file-name)
      (shell-command
       (format "/usr/local/bin/ruff check --select I --fix %s"
               (shell-quote-argument (buffer-file-name))))
      (revert-buffer t t t)))

  (defun my/lsp-organize-imports-dwim ()
    (interactive)
    (if (derived-mode-p 'python-mode)
        (my/python-organize-imports)
      (lsp-organize-imports)))

  (defun my/python-lsp-client-setup ()
    (setq-local lsp-enabled-clients '(pyls))
    (setq-local lsp-disabled-clients '(jedi pyright))
    (local-set-key (kbd "C-c i l") #'my/python-lsp-start))

  (add-hook 'python-mode-hook #'my/python-lsp-client-setup)
  :config
  (define-key lsp-command-map (kbd "r o") #'my/lsp-organize-imports-dwim))

;; --- Ruff (linter) ---
;; Ruff is configured as a flycheck checker by pointing flycheck directly
;; at the ruff executable — no extra package needed.
(with-eval-after-load 'flycheck
  (flycheck-define-checker python-ruff
    "A Python linter using ruff."
    :command ("/usr/local/bin/ruff"
              "check"
              "--output-format=concise"
              "--stdin-filename" source-original
              "-")
    :standard-input t
    :error-filter (lambda (errors)
                    (let ((errors (flycheck-sanitize-errors errors)))
                      (seq-do #'flycheck-flake8-fix-error-level errors)
                      errors))
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more upper))
              (optional " [*]")
              " "
              (message) line-end))
    :modes python-mode)

  ;; Use ruff as the primary checker in python buffers.
  (add-to-list 'flycheck-checkers 'python-ruff)
  (defun my/python-set-ruff-checker ()
    (when (derived-mode-p 'python-mode)
      (setq-local flycheck-checker 'python-ruff)))
  (add-hook 'python-mode-hook #'my/python-set-ruff-checker))

;; --- Ruff auto-fix on save ---
;; Runs after blacken formats the buffer, so the save order is:
;;   1. black  — formats code style
;;   2. ruff   — fixes lint issues (unused imports, etc.)
;;   3. delete-trailing-whitespace — final cleanup
(defun my/ruff-fix-buffer ()
  "Run ruff --fix on the current file and revert the buffer to reflect changes."
  (when (and (eq major-mode 'python-mode)
             (buffer-file-name))
    (shell-command
     (format "/usr/local/bin/ruff check --fix %s"
             (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t)))

(add-hook 'python-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'my/ruff-fix-buffer nil t)))

(use-package go-mode :straight t)

(defun my-go-mode-hook ()
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (unless (string-match "go" compile-command)
    (set (make-local-variable 'compile-command)
         "go build -v && go test -v && go vet"))
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(use-package go-eldoc   :straight t :config (add-hook 'go-mode-hook 'go-eldoc-setup))
(use-package godoctor  :straight t)
(use-package go-guru   :straight t)

(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "gopls")
                    :major-modes '(go-mode go-ts-mode)
                    :priority 0
                    :server-id 'gopls)))
(use-package go-ts-mode
  :ensure nil
  :hook (go-ts-mode . lsp-deferred))

(use-package lsp-java :straight t
  :hook (java-mode . lsp-deferred)
  :config
  (require 'lsp-java)
  (require 'dap-java)
  (add-to-list 'lsp-enabled-clients 'jdtls))

(setq js-indent-level 2)

(use-package js2-mode :straight t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'"  . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode)))

(use-package typescript-mode :straight t
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-enabled-clients 'ts-ls)
  (setq typescript-indent-level 2))

(defun run-typescript-file ()
  "Run the current TypeScript file using ts-node."
  (interactive)
  (shell-command (concat "npx ts-node " (buffer-file-name))))

(with-eval-after-load 'dap-mode
  (require 'dap-firefox))

(setq css-indent-offset 2)

(use-package scss-mode :straight t
  :mode "\\.scss\\'"
  :config (setq scss-compile-at-save nil))

(use-package emmet-mode :straight t
  :hook ((html-mode . emmet-mode)
         (sgml-mode . emmet-mode)
         (web-mode  . emmet-mode)
         (css-mode  . emmet-mode)))

(use-package prettier :straight t
  :defer t)

(use-package auto-rename-tag :straight t
  :hook ((html-mode . auto-rename-tag-mode)
         (web-mode  . auto-rename-tag-mode)))

(use-package geiser-mit :straight t)
(require 'geiser-mit)

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (when (eq window-system 'x)
              (font-lock-mode 1))))

(use-package dumb-jump :straight t :config (dumb-jump-mode))
(use-package htmlize :straight t)
(use-package crux :straight t)
(use-package editorconfig :straight t
  :config (editorconfig-mode 1))

(use-package apheleia :straight t
  :config
  (setf (alist-get 'python-mode apheleia-mode-alist) '(black))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) '(black))
  (setf (alist-get 'js2-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'js-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'typescript-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'css-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'html-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'web-mode apheleia-mode-alist) '(prettier))
  (setf (alist-get 'go-mode apheleia-mode-alist) '(gofmt))
  (apheleia-global-mode +1))

(use-package envrc :straight t
  :config
  (envrc-global-mode))

(require 'org-id)
(setq org-id-link-to-org-use-id 'create-if-interactive)

;; Files
(setq org-agenda-files '("~/gtd/tasks.org"
                          "~/gtd/habits.org"
                          "~/gtd/goals.org"
                          "~/gtd/birthdays.org"
                          "~/org/inbox.org"))
(setq org-default-notes-file "~/gtd/notes.org")

;; Logging & clocking
(setq org-habit-show-all-today t
      org-agenda-start-with-log-mode t
      org-log-done 'time
      org-log-into-drawer t
      org-log-reschedule 'time
      org-clock-into-drawer "CLOCKING"
      org-clock-sound "~/sounds/Smallbell.wav")

;; Agenda
(setq org-agenda-start-on-weekday 0
      org-agenda-include-diary t
      diary-display-function #'diary-fancy-display)
(add-hook 'diary-list-entries-hook #'diary-include-other-diary-files)
(add-hook 'diary-list-entries-hook #'diary-sort-entries t)

;; Refile
(setq org-refile-targets '((nil :maxlevel . 9)
                            (org-agenda-files :maxlevel . 3)
                            (org-buffer-list :maxlevel . 2))
      org-outline-path-complete-in-steps nil
      org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes 'confirm)
(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; General behaviour
(setq org-export-with-smart-quotes t
      org-src-fontify-natively t
      org-src-window-setup 'current-window
      org-src-preserve-indentation t
      org-confirm-babel-evaluate nil
      org-startup-indented t
      org-cycle-include-plain-lists 'integrate
      org-return-follows-link t
      org-enforce-todo-dependencies t
      org-track-ordered-property-with-tag t
      org-agenda-dim-blocked-tasks t
      org-enforce-todo-checkbox-dependencies t
      org-attach-use-inheritance t
      org-use-property-inheritance t
      org-link-frame-setup '((file . find-file))
      org-catch-invisible-edits 'show-and-error
      org-M-RET-may-split-line nil
      org-alphabetical-lists t
      org-ellipsis " ▼"
      org-export-backends '(ascii beamer html latex md))

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'org-cdlatex-mode)

;; Habits
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

;; Emphasis (green bold)
(add-to-list 'org-emphasis-alist '("*" (:foreground "green")))

;; Latex preview
(setq org-latex-create-formula-image-program 'dvipng)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)
(global-set-key (kbd "<f11>")   'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "M-<f11>") 'org-clock-out)

(setq org-todo-keywords
      '((sequence "REPEAT(r)" "NEXT(n@/!)" "TODO(t@/!)" "WAITING(w@/!)"
                  "SOMEDAY(s@/!)" "PROJ(p)" "|" "DONE(d@)" "CANCELLED(c@)")))

(setq org-todo-keyword-faces
      '(("TODO"      :foreground "red"     :weight bold)
        ("NEXT"      :foreground "#00ffff" :weight bold)
        ("REPEAT"    :foreground "magenta" :weight bold)
        ("WAITING"   :foreground "orange"  :weight bold)
        ("SOMEDAY"   :foreground "cyan"    :weight bold)
        ("PROJ"      :foreground "#ffc252" :weight bold)
        ("DONE"      :foreground "green"   :weight bold)
        ("CANCELLED" :foreground "yellow"  :weight bold)))

(setq org-tag-alist
      '((:startgroup)
        (:endgroup)
        ("@errand" . ?E)
        ("@home"   . ?H)
        ("@work"   . ?W)
        ("agenda"  . ?a)
        ("planning". ?p)
        ("publish" . ?P)
        ("batch"   . ?b)
        ("note"    . ?n)
        ("idea"    . ?i)))

(setq org-agenda-custom-commands
      '(("d" "Dashboard"
         ((agenda "" ((org-deadline-warning-days 7)))
          (todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))
          (tags-todo "ACTIVE"
                     ((org-agenda-overriding-header "Active Projects")))))

        ("n" "Next Tasks"
         ((todo "NEXT"
                ((org-agenda-overriding-header "Next Tasks")))))

        ("W" "Work Tasks" tags-todo "+work-email")

        ("e" "Low Effort Next Actions"
         tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
         ((org-agenda-overriding-header "Low Effort Tasks")
          (org-agenda-max-todos 20)
          (org-agenda-files org-agenda-files)))

        ("w" "Workflow Status"
         ((todo "WAITING"  ((org-agenda-overriding-header "Waiting on External")
                             (org-agenda-files org-agenda-files)))
          (todo "TODO"     ((org-agenda-overriding-header "TODO")
                             (org-agenda-files org-agenda-files)))
          (todo "SOMEDAY"  ((org-agenda-overriding-header "Someday")
                             (org-agenda-todo-list-sublevels nil)
                             (org-agenda-files org-agenda-files)))
          (todo "PROJ"     ((org-agenda-overriding-header "Project Backlog")
                             (org-agenda-todo-list-sublevels nil)
                             (org-agenda-files org-agenda-files)))
          (todo "NEXT"     ((org-agenda-overriding-header "Ready for Action")
                             (org-agenda-files org-agenda-files)))
          (tags-todo "ACTIVE" ((org-agenda-overriding-header "Active Projects")
                                (org-agenda-files org-agenda-files)))
          (todo "DONE"     ((org-agenda-overriding-header "Completed Items")
                             (org-agenda-files org-agenda-files)))
          (todo "CANCELLED" ((org-agenda-overriding-header "Cancelled")
                              (org-agenda-files org-agenda-files)))))))

(setq org-capture-templates
      '(("t" "Tasks / Projects")
        ("tt" "Task" entry (file+olp "~/gtd/tasks.org" "Inbox")
         (file "~/gtd/tpl-todo.txt"))

        ("d" "Daily Plan")
        ("dp" "Plan" entry (file+olp+datetree "~/gtd/dailyplan.org")
         (file "~/gtd/tpl-dailyplan.txt"))

        ("j" "Journal Entries")
        ("jj" "Journal" entry (file+olp+datetree "~/gtd/Journal.org")
         "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
         :clock-in :clock-resume :empty-lines 1)

        ("n" "Notes")
        ("nn" "Note" entry (file+headline "~/gtd/notes.org" "Notes")
         "* %?   \n  %i\n  %u\n  %a")

        ("l" "Links")
        ("ll" "Link" entry (file+headline "~/gtd/links.org" "Links")
         "* %? %^L %^g \n%T" :prepend t)

        ("g" "Goals")
        ("gg" "Goal" entry (file+headline "~/gtd/goals.org" "Goals")
         (file "~/gtd/tpl-goal.org"))

        ("p" "Projects")
        ("pp" "Project" entry (file+headline "~/gtd/tasks.org" "Projects")
         (file "~/gtd/tpl-projects.txt"))

        ("b" "Books")
        ("bb" "Book" entry (file+headline "~/gtd/tasks.org" "Books to read")
         (file "~/gtd/tpl-book.txt") :empty-lines-after 2)

        ("s" "Someday")
        ("ss" "Someday" entry (file+headline "~/gtd/tasks.org" "Someday")
         "* %i%? \n %U")

        ("w" "Waiting")
        ("ww" "Waiting" entry (file+headline "~/gtd/tasks.org" "Waiting")
         (file "~/gtd/tpl-waiting.txt"))))

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

;; Load all non-jupyter languages immediately.
;; ob-jupyter is only available after the jupyter package loads, so adding
;; jupyter here eagerly causes a "no such file" error at startup.
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python     . t)
   (js         . t)
   (ruby       . t)
   (shell      . t)))

;; Once jupyter has loaded, register ob-jupyter with babel.
(with-eval-after-load 'jupyter
  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages '((jupyter . t)))))

(straight-use-package 'org-contrib)

;; Bullets
(straight-use-package 'org-superstar)
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(org-superstar-configure-like-org-bullets)

;; Clip URLs as org links
(straight-use-package 'org-cliplink)
(global-set-key (kbd "C-x p i") 'org-cliplink)

;; Export to Twitter Bootstrap HTML
(straight-use-package 'ox-twbs)

;; Export to reveal.js presentations
(straight-use-package 'org-re-reveal)
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/"
      org-reveal-mathjax t)

;; Web tools (URL → org content)
(use-package org-web-tools :straight t)

;; Open agenda on startup
(add-hook 'after-init-hook 'org-agenda-list)

(defhydra hydra-org (:color blue :timeout 12 :columns 4)
  "Org clock commands"
  ("i" (lambda () (interactive) (org-clock-in '(4))) "Clock in")
  ("o" org-clock-out "Clock out")
  ("q" org-clock-cancel "Cancel clock")
  ("<f10>" org-clock-in-last "Clock in last task")
  ("j" (lambda () (interactive) (org-clock-goto '(4))) "Go to clock"))
(global-set-key (kbd "<f10>") 'hydra-org/body)

(defun my/org-agenda-list-current-buffer ()
  "Run org-agenda scoped to the current buffer only."
  (interactive)
  (let ((org-agenda-files (list (buffer-file-name (current-buffer)))))
    (call-interactively #'org-agenda)))

(defun my/copy-idlink-to-clipboard ()
  "Create an org ID for the current heading and copy the link to the kill ring.
Works in org-mode and org-agenda buffers."
  (interactive)
  (when (eq major-mode 'org-agenda-mode)
    (org-agenda-show)
    (org-agenda-goto))
  (when (eq major-mode 'org-mode)
    (let* ((head (nth 4 (org-heading-components)))
           (id   (funcall 'org-id-get-create))
           (link (format "[[id:%s][%s]]" id head)))
      (kill-new link)
      (message "Copied %s to kill ring" link))))

(defun org-reset-checkbox-state-maybe ()
  "Reset all checkboxes in an entry if RESET_CHECK_BOXES property is set."
  (interactive "∗")
  (when (org-entry-get (point) "RESET_CHECK_BOXES")
    (org-reset-checkbox-state-subtree)))

(defun org-checklist ()
  (when (member org-state org-done-keywords)
    (org-reset-checkbox-state-maybe)))

(add-hook 'org-after-todo-state-change-hook 'org-checklist)

(use-package emacsql-sqlite3 :straight t
  :config (require 'emacsql-sqlite3))

(use-package org-roam :straight t
  :init (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-directory "journal")
  (org-roam-database-connector 'sqlite3)
  (org-roam-capture-templates
   '(("b" "book notes" plain
      "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "project" plain
      "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Project")
      :unnarrowed t)
     ("d" "default" plain "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+date: %U\n")
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%I:%M %p>: %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         ("C-c n p" . my/org-roam-find-project)
         ("C-c n b" . my/org-roam-capture-inbox)
         ("C-c n t" . my/org-roam-capture-task)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap ("C-c n d" . org-roam-dailies-map)
  :config
  (defun org-roam-node-insert-immediate (arg &rest args)
    (interactive "P")
    (let ((args (cons arg args))
          (org-roam-capture-templates
           (list (append (car org-roam-capture-templates) '(:immediate-finish t)))))
      (apply #'org-roam-node-insert args)))
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))

;; Roam helper functions
(defun my/org-roam-filter-by-tag (tag-name)
  (lambda (node) (member tag-name (org-roam-node-tags node))))

(defun my/org-roam-project-finalize-hook ()
  "Add captured project file to `org-agenda-files' on confirmed capture."
  (remove-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  (unless org-note-abort
    (with-current-buffer (org-capture-get :buffer)
      (add-to-list 'org-agenda-files (buffer-file-name)))))

(defun my/org-roam-find-project ()
  (interactive)
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  (org-roam-node-find nil nil (my/org-roam-filter-by-tag "Project")
   :templates
   '(("p" "project" plain "* Goals\n\n%?\n\n* Tasks\n\n** TODO Add initial tasks\n\n* Dates\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+category: ${title}\n#+filetags: Project")
      :unnarrowed t))))

(defun my/org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-create)
                     :templates '(("i" "inbox" plain "* %?"
                                   :if-new (file+head "Inbox.org" "#+title: Inbox\n")))))

(defun my/org-roam-capture-task ()
  (interactive)
  (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)
  (org-roam-capture-
   :node (org-roam-node-read nil (my/org-roam-filter-by-tag "Project"))
   :templates '(("p" "project" plain "** TODO %?"
                 :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
                                        "#+title: ${title}\n#+category: ${title}\n#+filetags: Project"
                                        ("Tasks"))))))

(defun my/org-roam-copy-todo-to-today ()
  (interactive)
  (let ((org-refile-keep t)
        (org-roam-dailies-capture-templates
         '(("t" "tasks" entry "%?"
            :if-new (file+head+olp "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n" ("Tasks")))))
        (org-after-refile-insert-hook #'save-buffer)
        today-file pos)
    (save-window-excursion
      (setq today-file (buffer-file-name))
      (setq pos (point)))
    (unless (equal (file-truename today-file)
                   (file-truename (buffer-file-name)))
      (org-refile nil nil (list "Tasks" today-file nil pos)))))

(add-to-list 'org-after-todo-state-change-hook
             (lambda ()
               (when (equal org-state "DONE")
                 (my/org-roam-copy-todo-to-today))))

(use-package pdf-tools :straight t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :init (pdf-tools-install)
  :config
  (setq pdf-view-auto-refresh-on-file-change t))

(use-package pdf-view-restore :straight t
  :after pdf-tools
  :config (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

(use-package djvu :straight t :config (require 'djvu))
(straight-use-package '(djvu3 :type git :host github :repo "dalanicolai/djvu3"))
(require 'djvu3)

(use-package nov :straight t :config (require 'nov))

(use-package org-pdftools :straight t
  :hook (org-mode . org-pdftools-setup-link))

;; org-noter-pdftools must be declared BEFORE org-noter so it is available
;; when org-noter's config runs.  The :after clause still prevents it from
;; activating until both dependencies are ready.
(use-package org-noter-pdftools :straight t
  :after (org-noter org-pdftools)
  :config
  (defun org-noter-pdftools-insert-precise-note (&optional toggle-no-questions)
    "Insert a precise org-noter note at point in the PDF."
    (interactive "P")
    (org-noter--with-valid-session
     (let ((org-noter-insert-note-no-questions
            (if toggle-no-questions
                (not org-noter-insert-note-no-questions)
              org-noter-insert-note-no-questions))
           (org-pdftools-use-isearch-link t)
           (org-pdftools-use-freepointer-annot t))
       (org-noter-insert-note (org-noter--get-precise-info)))))
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions
              #'org-noter-pdftools-jump-to-note)))

;; org-noter is declared after org-noter-pdftools so straight.el has already
;; registered the pdftools package before this :config block executes.
(use-package org-noter :straight t
  :after (org-pdftools)
  :config
  (setq org-noter-auto-save-last-location t)
  ;; Wire up the pdftools integration now that both packages are present.
  (with-eval-after-load 'org-noter-pdftools
    (require 'org-noter-pdftools)))

(use-package zmq :straight t :config (require 'zmq))

;; :defer t ensures exec-path is fully set before jupyter tries to call
;; the jupyter shell command to retrieve kernelspecs.
(use-package jupyter :straight t :defer t)

(use-package ein :straight t
  :bind ("<f9>" . ein:worksheet-execute-cell-and-goto-next-km))

(straight-use-package
 '(org-timeblock :type git :host github :repo "ichernyshovvv/org-timeblock"))

(defvar yt-iframe-format
  (concat "<iframe width=\"440\""
          " height=\"335\""
          " src=\"https://www.youtube.com/embed/%s\""
          " frameborder=\"0\""
          " allowfullscreen>%s</iframe>"))

(org-add-link-type
 "yt"
 (lambda (handle)
   (browse-url (concat "https://www.youtube.com/embed/" handle)))
 (lambda (path desc backend)
   (cl-case backend
     (html  (format yt-iframe-format path (or desc "")))
     (latex (format "\\href{%s}{%s}" path (or desc "video"))))))

(use-package magit
  :init (use-package transient
          :straight (transient :type git :host github :repo "magit/transient"))
  :bind ("C-x g" . magit-status))

(use-package git-gutter :straight t
  :init (global-git-gutter-mode +1))
(custom-set-variables '(git-gutter:update-interval 2))

(defhydra hydra-git-gutter (:body-pre (git-gutter-mode 1) :hint nil)
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
  ("h" (progn (goto-char (point-min)) (git-gutter:next-hunk 1)))
  ("l" (progn (goto-char (point-min)) (git-gutter:previous-hunk 1)))
  ("s" git-gutter:stage-hunk)
  ("r" git-gutter:revert-hunk)
  ("p" git-gutter:popup-hunk)
  ("R" git-gutter:set-start-revision)
  ("q" nil :color blue)
  ("Q" (progn (git-gutter-mode -1)
              (sit-for 0.1)
              (git-gutter:clear))
   :color blue))

(straight-use-package 'git-timemachine)

(use-package auctex
  :straight (auctex :type git :host nil :repo "https://git.savannah.gnu.org/git/auctex.git")

  :config
  (setq TeX-engine 'xetex
        TeX-view-program-selection '((output-pdf "PDF Tools")))
  (add-hook 'latex-mode-hook #'TeX-fold-mode))

(use-package cdlatex :straight t
  :hook (latex-mode-hook . cdlatex-mode)
  :config
  (define-key cdlatex-mode-map (kbd "TAB")     'cdlatex-tab)
  (define-key cdlatex-mode-map (kbd "C-c C-e") 'cdlatex-environment)
  (define-key cdlatex-mode-map (kbd "C-c C-s") 'cdlatex-sub-sup-mode))

(use-package vterm :straight t
  :commands vterm
  :config (setq vterm-max-scrollback 10000))

(use-package vterm-toggle :straight t
  :after vterm
  :bind (("C-`" . vterm-toggle)
         ("C-M-`" . vterm-toggle-cd))
  :custom
  (vterm-toggle-fullscreen-p nil)
  (vterm-toggle-reset-window-configuration-after-exit t))

(defun efs/configure-shell ()
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)
  (setq eshell-history-size 10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt :straight t)

(use-package eshell :straight t
  :hook (eshell-first-time-mode . efs/configure-shell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t
          eshell-visual-commands '("htop" "zsh" "vim")))
  (eshell-git-prompt-use-theme 'powerline))

(use-package term :straight t
  :config (setq explicit-shell-file-name "zsh"))

(use-package eterm-256color :straight t
  :hook (term-mode . eterm-256color-mode))

(defun my-zsh ()
  "Open a zsh shell in ansi-term."
  (interactive)
  (ansi-term "zsh"))

(defhydra hydra-elfeed ()
  "Elfeed filters"
  ("S" (elfeed-search-set-filter "@6-month-ago +systemcrafters") "System Crafters")
  ("h" (elfeed-search-set-filter "@6-month-ago +hackernews")     "Hacker News")
  ("l" (elfeed-search-set-filter "@6-month-ago +lobsters")       "Lobsters")
  ("m" (elfeed-search-set-filter "@6-month-ago +Math")           "Math")
  ("c" (elfeed-search-set-filter "@6-months-ago +cs")            "CS")
  ("e" (elfeed-search-set-filter "@6-months-ago +emacs")         "Emacs")
  ("B" (elfeed-search-set-filter "@6-months-ago +BSD")           "BSD")
  ("p" (elfeed-search-set-filter "@6-months-ago +programming")   "Programming")
  ("*" (elfeed-search-set-filter "@6-months-ago +star")          "Starred")
  ("M" elfeed-toggle-star "Mark")
  ("A" (elfeed-search-set-filter "@6-months-ago") "All")
  ("T" (elfeed-search-set-filter "@1-day-ago")    "Today")
  ("Q" bjm/elfeed-save-db-and-bury "Quit" :color blue)
  ("q" nil "dismiss" :color blue))

(use-package elfeed :straight t
  :bind (:map elfeed-search-mode-map
              ("q" . bjm/elfeed-save-db-and-bury)
              ("Q" . bjm/elfeed-save-db-and-bury)
              ("m" . elfeed-toggle-star)
              ("M" . elfeed-toggle-star)
              ("j" . hydra-elfeed/body)
              ("J" . hydra-elfeed/body)))

(use-package elfeed-goodies :straight t
  :config (elfeed-goodies/setup))

(use-package elfeed-org :straight t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files '("~/elfeed/elfeed.org")
        elfeed-db-directory "~/elfeed/elfeeddb"))

(defalias 'elfeed-toggle-star
  (elfeed-expose #'elfeed-search-toggle-all 'star))

(defun bjm/elfeed-load-db-and-open ()
  "Load elfeed db from disk and open elfeed."
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

(defun bjm/elfeed-save-db-and-bury ()
  "Save elfeed db to disk and bury the buffer."
  (interactive)
  (elfeed-db-save)
  (quit-window))

(defun elfeed-mark-all-as-read ()
  (interactive)
  (mark-whole-buffer)
  (elfeed-search-untag-all-unread))

(use-package hackernews :straight t)
(use-package hnreader :straight t)

(use-package md4rd :straight t
  :config
  (setq md4rd-subs-active
        '(emacs math freebsd bsd compsci askcomputerscience computerarchitecture
          programming learnprogramming vim learnmath cprog c_language c_programming
          cplusplus python learnpython java javascript ruby rust learnrust lisp
          artificial machinelearning neuralnetworks linearalgebra explainlikeimfive
          css react webdev latex technology)))

(use-package olivetti :straight t)

(use-package define-word :straight t :defer t
  :bind (("C-c d" . define-word-at-point)
         ("C-c D" . define-word))
  :config (setq define-word-default-service 'webster))

(use-package powerthesaurus :straight t)

(use-package denote :straight t
  :config
  (require 'denote)
  (setq denote-directory (expand-file-name "~/denote/notes/")))

(use-package hyperbole :straight t
  :init
  (load "hyperbole-autoloads")
  (load "hyperbole")
  :config
  (require 'hyperbole)
  (setq hbmap:dir-user "~/gtd/hyperbole/"
        hyrolo-file-list '("~/gtd/hyperbole/ideas.org")
        hyrolo-date-format "%Y-%m-%d %H:%M:%S"
        hyrolo-kill-buffers-after-use t)
  :bind* ("<M-return>" . hkey-either))

(use-package greader :straight t)

(use-package calfw :straight t :config (require 'calfw))
(use-package calfw-org :straight t :config (require 'calfw-org))

(straight-use-package 'lorem-ipsum)
(require 'lorem-ipsum)

(use-package erc :straight t
  :config
  (add-to-list 'erc-modules 'notifications)
  (require 'erc-desktop-notifications)
  (erc-update-modules)
  (setq erc-hide-list '("JOIN" "MODE" "NICK" "PART" "QUIT"
                        "324" "329" "332" "333" "353" "477")
        erc-fill-function 'erc-fill-static
        erc-fill-static-center 15
        erc-server-303-functions nil
        erc-prompt (lambda () (concat "[" (buffer-name) "]"))))

(straight-use-package 'erc-scrolltoplace)
(require 'erc-scrolltoplace)
(add-to-list 'erc-modules 'scrolltoplace)
(erc-update-modules)

(use-package erc-hl-nicks :straight t)

(defun my/erc-notify (nickname message)
  "Display a desktop notification for an ERC message."
  (let* ((channel (buffer-name))
         (nick  (erc-hl-nicks-trim-irc-nick nickname))
         (title (if (string-match-p (concat "^" nickname) channel)
                    nick
                  (concat nick " (" channel ")")))
         (msg   (s-trim (s-collapse-whitespace message))))
    (alert (concat nick ": " msg) :title title)))

(straight-use-package 'znc)

(setq user-mail-address "transitive@gmail.com"
      user-full-name    "Robert Cina")

(setq gnus-select-method
      '(nnimap "gmail"
               (nnimap-address "imap.gmail.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)))

(setq auth-sources '("~/.authinfo.gpg" "~/.netrc.gpg")
      auth-source-cache-expiry nil)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server         "smtp.gmail.com"
      smtpmail-smtp-service        587
      gnus-ignored-newsgroups
      "^to\\.\\|^[0-9. ]+\\( \\w\\|$\\)\\|^[\"]\"[#'()]")

(use-package ox-hugo :straight t :after ox)

(use-package simple-httpd :straight t)

(use-package fzf :straight t)

(defun my/toggle-line-numbers-relative ()
  "Toggle between absolute and relative line numbers (native display-line-numbers)."
  (interactive)
  (if (eq display-line-numbers 'relative)
      (setq display-line-numbers t)
    (setq display-line-numbers 'relative)))
(global-set-key (kbd "s-k") #'my/toggle-line-numbers-relative)

(use-package inform :straight t :config (require 'inform))

(setq browse-url-browser-function 'browse-url-firefox)

(use-package w3m :straight t)

(defun wicked/w3m-open-current-page-in-firefox ()
  "Open the current w3m URL in Firefox."
  (interactive)
  (browse-url-firefox w3m-current-url))

(defun wicked/w3m-open-link-or-image-in-firefox ()
  "Open the link or image at point in Firefox."
  (interactive)
  (browse-url-firefox (or (w3m-anchor) (w3m-image))))

(with-eval-after-load 'w3m
  (define-key w3m-mode-map "f" 'wicked/w3m-open-current-page-in-firefox)
  (define-key w3m-mode-map "F" 'wicked/w3m-open-link-or-image-in-firefox))

(defun my-info-copy-current-node-name (arg)
  "Copy a lispy link to the current Info node.
With prefix ARG, copy the URL to the online GNU manual instead."
  (interactive "P")
  (let* ((manual (file-name-sans-extension
                  (file-name-nondirectory Info-current-file)))
         (node Info-current-node)
         (link (if (not arg)
                   (format "(info \"(%s) %s\")" manual node)
                 (format "https://www.gnu.org/software/emacs/manual/html_node/%s/%s.html"
                         manual (if (string= node "Top")
                                    "index"
                                  (replace-regexp-in-string " " "-" node))))))
    (kill-new link)
    (message link)))

(with-eval-after-load 'info
  (define-key Info-mode-map (kbd "c") 'my-info-copy-current-node-name))

(use-package markdown-mode :straight t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
