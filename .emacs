;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'use-package)

(package-initialize)

(global-auto-revert-mode t) ;; reload files when changed

;; makes debugging easier. josh suggests
(add-hook 'after-init-hook '(lambda () (setq debug-on-error t)))

;; kill-region should have no effect if the region is not active
(defvar mark-even-if-inactive nil)

;; Semantic Synchrony
(progn
  ;; where is the server?
  ;; (defvar smsn-server-host "fortytwo.net") ;; online
  (defvar smsn-server-host "127.0.0.1") ;; local

  (defvar smsn-server-port 8182)
  (defvar smsn-server-protocol "websocket") ;; websocket is default
  (defvar smsn-default-vcs-file "/mnt/smsn-data/vcs") ;; ought to be default
  (let ((default-directory "~/.emacs.d/elisp/")) ;; Weird scope!
    (normal-top-level-add-subdirs-to-load-path))
  (require 'smsn-mode)
  )
