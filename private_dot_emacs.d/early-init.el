(setq gc-cons-threshold 100000000) ;;

;; Improve performance with language servers.
(setq read-process-output-max (* 1024 1024)) ;; 1 MB

(setenv "LSP_USE_PLISTS" "true")
(setq lsp-use-plists t)

;; Disable "file-name-handler-alist" than enable it later for speed.
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq file-name-handler-alist startup/file-name-handler-alist)
            (makunbound 'startup/file-name-handler-alist)))
(setq package-quickstart t)

(setq use-package-always-defer t)

(setq initial-major-mode 'fundamental-mode)
