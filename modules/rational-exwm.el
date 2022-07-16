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
			?\C-\M-j  ;; Buffer list
			?\M-\ ))  ;; Ctrl+Space

 
