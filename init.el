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
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; install use-package macro
(straight-use-package 'use-package)
(require 'use-package)

(use-package org
      :config
      (require 'org) )

;; Load org-mode file with rest of my emacs configuration

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
