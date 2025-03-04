;;; package --- Summary
;;; Commentary:
;;; Simple Emacs init file.  Goes in ~/.emacs.d/
;;; Code:

;; Initialize package management
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; Bootstrap use-package if not installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Install and configure packages
(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package company
  :hook (after-init . global-company-mode))

(use-package clang-format
  :bind ("<f8>" . clang-format-region))

(use-package rust-mode)
(use-package cargo-mode)
(use-package flycheck-rust)
(use-package racket-mode)
(use-package slime)

(load-theme 'leuven-dark t)

;; UI Tweaks
(setq inhibit-splash-screen t
      inhibit-default-init t
      frame-title-format (concat "%b - emacs@" (system-name))
      column-number-mode t
      ring-bell-function 'ignore
      make-backup-files nil
      indent-tabs-mode nil
      show-trailing-whitespace t
      word-wrap t)

(tool-bar-mode -1)
(global-auto-revert-mode 1)
(global-visual-line-mode t)

;; Tab visualization
(standard-display-ascii ?\t "--->")

;; Spellcheck in text and LaTeX mode
(dolist (hook '(text-mode-hook latex-mode-hook))
  (add-hook hook #'flyspell-mode))

;; Keybindings
(global-set-key (kbd "<f6>") 'compile)
(global-set-key (kbd "<f7>") 'delete-trailing-whitespace)

;; File associations
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c-mode))

;; Syntax highlighting
(global-font-lock-mode 1)

;; C style
(setq c-default-style '((other . "stroustrup")))
