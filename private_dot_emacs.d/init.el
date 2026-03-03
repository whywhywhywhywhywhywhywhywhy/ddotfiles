

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Tweak UI.
(when (display-graphic-p)
  (tool-bar-mode 0)
  (scroll-bar-mode 0))
(setq inhibit-startup-screen t)
(column-number-mode)

(dolist (hook '(prog-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook 'display-line-numbers-mode))

(setq show-paren-delay 0)
(show-paren-mode)
;;minibuffer config
(context-menu-mode t)

;; themes
(load-theme 'solarized-selenized-light t)
(use-package solarized-theme
  :ensure t) 
;;set binds


(keymap-set minibuffer-local-map "M-A" 'marginalia-cycle)

;; package stuff
(require 'use-package-ensure)
(setq use-package-always-ensure t)


(use-package markdown-mode)
(use-package paredit
  :ensure t)
(use-package rainbow-delimiters
  :ensure t)
(use-package jinx
  :ensure t
  :hook (emacs-startup . global-jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))
(use-package which-key
    :config
    (which-key-mode))
;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  
  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))
;; install orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; Enable Vertico.
(use-package vertico
  :custom
  (vertico-count 20) ;; Show more candidates
  (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :config
  (setq denote-directory (expand-file-name "~/notes/")))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
         :map minibuffer-local-map
         ("C-c C-c" . embark-collect)
         ("C-c C-e" . embark-export)))

(use-package consult
  :ensure t
  :bind (
         ("M-s b" . consult-buffer)
         ("M-s g" . consult-grep)
         ("M-s j" . consult-outline)
         ))

;; avy setup(very important)
(use-package avy)
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "M-j") 'avy-goto-char-timer)
(use-package org-download)
(use-package auctex)
(use-package cdlatex)




;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Display the distance between two tab stops as 4 characters wide.
(setq-default tab-width 4)

;; Indentation setting for various languages.
(setq c-basic-offset 4)
(setq js-indent-level 2)
(setq css-indent-offset 2)



;; Do not move the current file while creating backup.
(setq backup-by-copying t)

;; Disable lockfiles.
(setq create-lockfiles nil)

;; Write auto-saves and backups to separate directory.
(make-directory "~/.tmp/emacs/auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.tmp/emacs/auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.tmp/emacs/backup/")))

;; Write customizations to a separate file instead of this file.
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

;; Add a newline automatically at the end of a file while saving.
(setq require-final-newline t)
;; remembering recent edited files through recentf
(recentf-mode 1)
;; Remember and restore the last cursor location of opened files
(save-place-mode 1)
;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)
;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)
;; Consider a period followed by a single space to be end of sentence.
(setq sentence-end-double-space nil)
;; Save what you enter into minibuffer prompts
(setq history-length 25)
(savehist-mode) 1
;;when opening files, default directory to ~
(setq default-directory "~/")
;; follow symlinks when opening files
  (setq vc-follow-symlinks t)
;; human readable file sizes in dired
(setq-default dired-listing-switches "-alh")
;; set mode for initial scratch buffer and disable the average time to load
(setopt initial-major-mode 'fundamental-mode)
(setopt display-time-default-load-average nil)
;; Enable Paredit on various Lisp modes.
(when (fboundp 'paredit-mode)
  (dolist (hook '(emacs-lisp-mode-hook
                  eval-expression-minibuffer-setup-hook
                  ielm-mode-hook
                  lisp-interaction-mode-hook
                  lisp-mode-hook))
    (add-hook hook 'enable-paredit-mode)))

;; Do not bind RET to paredit-RET which prevents input from being
;; evaluated on RET in M-:, ielm, etc.
(with-eval-after-load 'paredit
  (define-key paredit-mode-map (kbd "RET") nil))
;; rainbow delimiters config
(when (fboundp 'rainbow-delimiters-mode)

  (dolist (hook '(emacs-lisp-mode-hook
                  ielm-mode-hook
                  lisp-interaction-mode-hook
                  lisp-mode-hook))
    (add-hook hook 'rainbow-delimiters-mode)))


;;;; org mode stuff

;; Enable Org mode and configure it.
(use-package org)

;; enable visual-mode line
(with-eval-after-load 'org       
  (add-hook 'org-mode-hook #'visual-line-mode))

;; cdlatex setup 
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)

;;end of init
(provide 'init)
