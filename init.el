;; -------------------------------------
;; PACKAGE MANAGEMENT
;; -------------------------------------

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpha/")
			 ("elpa" . "https://elpa.gnu.org/packages")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ---
;; IVY
;; ---

(use-package swiper :ensure t)
(use-package counsel)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-net-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; ------------
;; KEY BINDINGS
;; ------------

(global-set-key (kbd "<escape>") 'keyboard-escape-quit) ; make ESC quit prompts

;; ---------------------
;; APPEARANCE
;; ---------------------

(set-face-attribute 'default nil :font "Fira Code Retina" :height 140) ; font
(load-theme 'leuven-dark)        ; theme
(setq inhibit-startup-message t) ; do not show help on startup
(scroll-bar-mode -1)             ; disable visible scrollbar
(tool-bar-mode -1)               ; disable toolbar
(tooltip-mode -1)                ; disable tooltips
(set-fringe-mode 10)             ; padding (left and right only?)
(menu-bar-mode -1)               ; disable menu bar
(setq visible-bell t)            ; Use the visible bell instead of the audio

;; Below this line is modified by emacs, itself.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(counsel swiper ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
