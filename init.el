;; Author: Robert Cina
;; Web: http://www.robertcina.com
;; Github URL:https://github.com/rcina
;; Created: 2020-11-29
;; Description: My .emacs configuration file
;;
;;


;; Straight.el package manager bootstrap code
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         ;; FIXED URL: radian-software, not raxod502
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))




;; install use-package macro
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(require 'use-package)


(straight-use-package 'org)
(require 'org)

;; Load org-mode file with rest of my emacs configuration

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
