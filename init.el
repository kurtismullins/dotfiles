;;
;; Thanks to the Systems Crafters Youtube Channel for
;; guiding the creation of this configuration.
;;

;; TODO: a package named something along the lines "install all the fonts"
;;       may need to be installed (and ran) for new machines. Not sure
;;       how compatible this will be with NixOS?

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
(setq use-package-always-ensure t) ;; auto-fetch any use-package packages

;; ---
;; IVY
;; ---

(use-package swiper :ensure t)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
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

(set-face-attribute 'default nil :font "Fira Code" :height 130) ; font
(load-theme 'leuven-dark t)        ; theme
(setq inhibit-startup-message t) ; do not show help on startup
(scroll-bar-mode -1)             ; disable visible scrollbar
(tool-bar-mode -1)               ; disable toolbar
(tooltip-mode -1)                ; disable tooltips
(set-fringe-mode 10)             ; padding (left and right only?)
(menu-bar-mode -1)               ; disable menu bar
(setq visible-bell t)            ; Use the visible bell instead of the audio

;; ------------------------------------------
;; LINE NUMBERS
;; ------------------------------------------
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook ;; do not show line numbers in these modes
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Show Column Number in the Mode Line
(column-number-mode)

;; Use colors for matching parenethesis ... I think?
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; A nice help menu is shown on C-h, C-x, etc...
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq wihch-key-idle-delay 0.3))

;; Ivy Rich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Counsel Mode seems to show extra information when using key chords
(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)) ;; Don't start searches with ^

;; Helpful
;; Better formatted help screen?
(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))
(use-package doom-themes)

;; Custom Key Bindings
;;(use-package general
;;  (general-define-key
;;  "C-M-j" 'counsel-switch-buffer)
;; (general-create-definer rune/leader-keys
;;   :keymaps '(normal insert visual emacs)
;;   :prefix "SPC"
;;   :global-prefix "C-SPC"
;;   (rune/leader-keys
;;    "t" '(:ignore t :which-key "toggles")
;;    "tt" '(counsel-load-theme :wihch-key "choose theme"))))

;; e-vi-l mode
;;(use-package general
;;  (general-define-

;; (defun rune/evil-hook ()
;;   (dolist (mode '(custom-mode
;; 		  eshell-mode
;; 		  git-rebase-mode
;; 		  erc-mode
;; 		  circe-server-mode
;; 		  circe-chat-mode
;; 		  sauron-mode
;; 		  term-mode))
;;     (add-to-list 'evil-emacs-state-modes mode)))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  ;;:hook (evil-mode . rune/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-chart-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
 "ts" '(hydra-text-scale/body :which-key "scale text"))

;; Below this line is modified by emacs, itself.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("34af44a659b79c9f92db13ac7776b875a8d7e1773448a8301f97c18437a822b6" default))
 '(package-selected-packages
   '(hydra evil-collection evil general doom-themes doom-modeline helpful ivy-rich which-key rainbow-delimiters yaml-mode leuven-theme magit counsel swiper ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
