;;; rational-exwm.el --- EXWM configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; Use Emacs as your Windows Manager

;;; Code:

(defgroup rational-exwm '()
  "EXWM related configuration for Rational Emacs."
  :tag "Rational EXWM"
  :group 'rational)
 
;; Customizable configuration variables
(defcustom rational-exwm-workspace-by-class '()
  "Alist specifying which EXWM workspace a particular program should open on. Keys should be strings that contain the xwindows program class name. Values should be integers between 0 and 9, specifying which workspace a class opens on"
  :type '(alist :key-type string :value-type integer)
  :group 'rational-ui)

(defcustom rational-exwm-titles-by-class '()
   "Alist specifying how certain program classes should be named. Keys should be strings that contain the xwindows program class name. Values should be strings specifying how the class should be named."
  :type '(alist :key-type string :value-type string)
  :group 'rational-ui)

(defcustom rational-exwm-starting-workspaces 5
  "Specifies the number of EXWM workspaces on startup."
  :type integer
  :group 'rational-ui)

(defcustom rational-exwm-display-battery nil
  "Specifies whether or not the status of the battery should be displayed."
  :type boolean
  :group 'rational-ui)

;; These keys are sent directly to Emacs rather than an EXWM window when in line mode. 
(customize-set-variable exwm-input-prefix-keys
                      '(?\C-x
			?\C-u
			?\C-g
			?\C-w
			?\C-h
			?\M-x
			?\M-`
			?\M-&
			?\M-:
			?\C-\M-j  
			?\M-\ ))  

;; These keys are sent directly to Emacs rather than an EXWM window in both char mode and line mode. They are also added to the global keymap. 
(customize-set-variable exwm-input-global-keys
			`(([?\s-r] . exwm-reset)
			  ([s-left] . windmove-left)
			  ([s-right] . windmove-right)
			  ([s-up] . windmove-up)
			  ([s-down] . windmove-down)  
			  ([?\s-h] . windmove-left)
		   	  ([?\s-l] . windmove-right)
			  ([?\s-k] . windmove-up)
		          ([?\s-j] . windmove-down)
			  ([?\s-f] . exwm-layout-set-fullscreen)
		          ([?\s-H] . windmove-swap-states-left)
		          ([?\s-L] . windmove-swap-states-right)
		          ([?\s-K] . windmove-swap-states-up)
		          ([?\s-J] . windmove-swap-states-down)
	                  ([?\s-Q] . kill-buffer-and-window)
		          ([?\s-E] . save-buffers-kill-terminal)
                          ([?\s-w] . exwm-workspace-switch)

			  ;; Set s-# to switch or create workspace # (# is 0-9)
			  ,@(mapcar (lambda (i)
				      `(,(kbd (format "%s-%d" i)) . (lambda ()
								      (interactive)
								      (exwm-workspace-switch-create ,i))))
				    (number-sequence 0 9))

			  ;; Set s-S-# to move a program to workspace # (# is 0-9)
			  (let ((shifted-nums-alist '((0 . ?\()
                                                      (1 . ?\!)
						      (2 . ?@)
						      (3 . ?#)
						      (4 . ?$)
						      (5 . ?\%)
						      (6 . ?^)
						      (7 . ?&)
						      (8 . ?\*)
						      (9 . ?\())))
			    ,@(mapcar (lambda (i)
				        `(,(kbd (format "%s-%c" (alist-get i shifted-nums-alist)))
					  (lambda ()
					    (interactive)
					    (exwm-workspace-move-window ,i))))
				      (number-sequence 0 9)))))

(exwm-enable)
