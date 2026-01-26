;; +++ Initial configuration +++
;;

(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 10 1000 1000))

;; No sound bell
(setq visible-bell t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)
(global-hl-line-mode +1)

(load-theme 'deeper-blue)

(setq auto-save-default nil) ;; #file.txt#
;; (make-directory "~/.emacs.d/auto-saves/" t)
;; (setq auto-save-file-name-transforms
;;       `((".*" ,(expand-file-name "~/.emacs.d/auto-saves/") t)))

(setq make-backup-files nil) ;; file.txt~
;; (setq backup-directory-alist `(("." . "~/.saves")))


;; +++ Packaging +++
;;

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
	("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)
(setq use-package-compute-statistics t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 28)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

;; +++ UI +++
;;


(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

;; +++ Evil +++
;;


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(setq evil-cross-lines t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; (define-key evil-insert-state-map "jk" 'evil-normal-state)
  (add-hook 'evil-insert-state-entry-hook
	    (lambda () (or (display-graphic-p)
			   (send-string-to-terminal "\033[5 q"))))
  (add-hook 'evil-insert-state-exit-hook
	    (lambda () (or (display-graphic-p)
			   (send-string-to-terminal "\033[2 q"))))
  )

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; (use-package undo-tree
;;   :config
;;   (global-undo-tree-mode)
;;   (setq undo-tree-visualizer-diff t)
;;   (setq undo-tree-visualizer-timestamps t)
;;   (setq undo-tree-auto-save-history nil)
;;   (evil-set-undo-system 'undo-tree)
;;   )

;; +++ Keys +++
;;

(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key (kbd "<escape>") 'keyboard-quit)

(global-set-key "\C-cz" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)


(setq select-enable-clipboard t) ;; Sync kill-ring and system clipboard
(setq select-active-regions t)
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1)
  )

;; --- Customizations ---
;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
