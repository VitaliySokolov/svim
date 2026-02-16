;; +++ Initial configuration +++
;;

(setq inhibit-startup-message t)

(defun set-exec-path-from-zsh-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (let ((path-from-shell
         (replace-regexp-in-string
          "[ \t\n]*$" "" (shell-command-to-string
                          "$SHELL --login -c 'source ~/.zshrc && echo $PATH'"
                          ))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-zsh-PATH)

(fset 'yes-or-no-p 'y-or-n-p)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 10 1000 1000))

;; No sound bell
(setq visible-bell t)

;; window only
(when (display-graphic-p)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (tooltip-mode -1))

;; terminal only
(unless (display-graphic-p)
  ;; mouse support in terminal
  (xterm-mouse-mode 1))

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
  (which-key-enable-god-mode-support)
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

(use-package undo-tree
  :config
  (global-undo-tree-mode)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree)
  )

(setq select-enable-clipboard t) ;; Sync kill-ring and system clipboard
(setq select-active-regions t)
(use-package xclip
  :ensure t
  :config
  (xclip-mode 1))

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


(use-package god-mode
  :after evil
  ;; x SPC r t -> C-x r t
  ;; x SPC r SPC g w -> C-x r M-w
  ;; g x -> M-x
  ;; G x -> C-M-x
  ;; g f . . -> M-f M-f M-f ;; repeat
  ;; u c o -> C-u C-c C-o
  ;; 1 2 f -> M-12 C-f
  )
(use-package general
    :after evil god-mode
    :config
    (general-evil-setup)
    (general-create-definer my-leader-def
      ;; :keymaps 'override
      :prefix "SPC"
      ;; :global-prefix "C-c SPC"
      )
    ;; (general-nmap "SPC" (general-key "C-c"))
    ;; (general-nmap "C-c SPC" (general-key "C-x")) ; => SPC-SPC
    ;; (general-nmap "SPC SPC" 'god-execute-with-current-bindings) ; => SPC-SPC

    (my-leader-def
     :keymaps 'normal
     "oa" 'org-agenda
     "oc" 'org-capture
     "wo" 'other-window
     "w1" 'delete-other-windows
     "SPC" 'god-execute-with-current-bindings
     "hf" 'counsel-describe-function
     "hv" 'counsel-describe-variable
     "ho" 'counsel-describe-symbol
     "hl" 'counsel-find-library
     "hi" 'counsel-info-lookup-symbol
     "hu" 'counsel-unicode-char
     "b" 'ivy-switch-buffer
     "B" 'buffer-menu
     "ff" 'counsel-fzf
     "f/" 'counsel-rg
     )
    (evil-ex-define-cmd "gx" 'counsel-M-x)
    (evil-ex-define-cmd "god" 'god-execute-with-current-bindings)
    (evil-ex-define-cmd "bm" 'buffer-menu)
    (evil-ex-define-cmd "bs" 'ivy-switch-buffer)
    ;; always
    ;; (define-key key-translation-map (kbd "SPC") 'event-apply-control-modifier)
    )

;; org-mode
(setq local-org-path (getenv "ORG_AGENDA_PATH"))
(when (stringp local-org-path)
  (setq org-agenda-files (list local-org-path)))

(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer nil) ;; State, notes, clock in LOGBOOK
(setq org-todo-keywords
      '((sequence "BACKLOG(b!)" "TODO(t!)" "IN PROGRESS(i!)" "REVIEW(r!)"
                  "|" "DONE(d!)" "CANCELED(c@/!)")
        (sequence "PROPOSAL" "WATCHING" "READING" "|" "SEEN")
      ))

(use-package diminish)

;; C-c o
(use-package command-log-mode
  :diminish
  :config
  (global-command-log-mode))

;; Ivy, a generic completion mechanism for Emacs.
(use-package ivy
  :diminish
  :demand t
  :config (ivy-mode)
  )

;; Swiper, an Ivy-enhanced alternative to Isearch.
(use-package swiper
  :commands (swiper)
  :config
  (setq swiper-goto-start-of-match t))

;; Counsel, a collection of Ivy-enhanced versions of common Emacs commands.
(use-package counsel
  :commands (counsel-git-grep counsel-switch-buffer)
  :config
  (keymap-global-set "M-x" #'counsel-M-x)
  (keymap-global-set "C-s" #'swiper-isearch)
  (keymap-global-set "C-x C-f" #'counsel-find-file)
  (setq counsel-fzf-cmd
	"rg --files --hidden -g '!.git' | fzf -f \"%s\"")
  )

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

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
