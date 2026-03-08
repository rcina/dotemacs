;; Author: Robert Cina
;; Web: http://www.robertcina.com
;; Github URL: https://github.com/rcina
;; Created: 2020-11-29
;; Description: My Emacs bootstrap — installs straight.el, use-package, and loads myinit.org
;;

;; Straight.el package manager bootstrap code
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package and enable straight as the default backend
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(require 'use-package)

;; Install the straight-managed org before loading config so org-babel-load-file
;; uses the pinned version rather than Emacs' bundled org.
(straight-use-package 'org)
(require 'org)

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
