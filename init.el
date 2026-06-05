;; +++ Initial configuration +++


;;; Init

(setq inhibit-startup-message t)

(add-hook
 'emacs-startup-hook
 (lambda ()
   (run-with-idle-timer
    1             ;; second
    nil           ;; do not repeat
    (lambda ()
      (message
       "Emacs loaded in %s with %d garbage collections."
       (emacs-init-time)
       gcs-done)))))

(defun get-env-from-shell (env-name)
  (replace-regexp-in-string
   "[ \t\n]*$" ""
   (shell-command-to-string
    (format "$SHELL --login -c 'source ~/.zshrc && echo $%s'" env-name)
    )))

(defun set-exec-path-from-zsh-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
that used by the user's shell.

This is particularly useful under Mac OS X and macOS, where GUI
apps are not started from a shell."
  (let ((path-from-shell
         (get-env-from-shell "PATH")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-zsh-PATH)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default c-basic-offset 2)
(setq-default js-indent-level 2)
(setq-default python-indent-offset 4)

;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 10 1000 1000))

;; No sound bell
(setq visible-bell t)

(menu-bar-mode -1)
;; window only
(when window-system
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)

  (when (eq system-type 'darwin)
    (setq mac-option-key-is-meta nil
          mac-command-key-is-meta nil
          mac-command-modifier 'meta
          mac-option-modifier 'none))
  )

;; terminal only
(unless (display-graphic-p)
  ;; mouse support in terminal
  (xterm-mouse-mode 1))

(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'visual)
(setopt display-line-numbers-width-start t)
(global-hl-line-mode +1)

(add-hook 'emacs-lisp-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'org-mode-hook (lambda () (setq indent-tabs-mode nil)))
(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'diff-mode-hook 'outline-minor-mode)
(setq outline-minor-mode-cycle t)

(load-theme
 ;; 'deeper-blue
 ;; 'leuven-dark
 'modus-vivendi
 )

(setq auto-save-default nil) ;; #file.txt#
;; (make-directory "~/.emacs.d/auto-saves/" t)
;; (setq auto-save-file-name-transforms
;;       `((".*" ,(expand-file-name "~/.emacs.d/auto-saves/") t)))

(setq make-backup-files nil) ;; file.txt~
;; (setq backup-directory-alist `(("." . "~/.saves")))

(savehist-mode 1)
(recentf-mode 1)


;;; Packaging

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
;; https://www.gnu.org/software/emacs/manual/html_mono/use-package.html
;; (use-package foo  ;; This declaration is equivalent to using require
;;   :init
;;   (setq foo-variable t) ;; before foo loaded
;;   :config
;;   (foo-mode 1) ;; after foo loaded
;;   :defer t
;;   )

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


;;; Evil
(use-package evil-collection
  :after evil
  :diminish evil-collection-unimpaired-mode
  :config
  (evil-collection-init))

(use-package evil-commentary
  :after evil
  :diminish
  :config
  (evil-commentary-mode))

(setq evil-cross-lines t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-respect-visual-line-mode t)
  (setq evil-kill-on-visual-paste nil) ;; keymap("v", "p", '"_dP')

  :config
  (evil-mode 1)
  ;; (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  ;; (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  ;; (evil-global-set-key 'motion "j" 'evil-next-visual-line) ;; -> "gj"
  ;; (evil-global-set-key 'motion "k" 'evil-previous-visual-line) ;; -> "gk"

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; (define-key evil-insert-state-map "jk" 'evil-normal-state)
  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (or (display-graphic-p)
                  (send-string-to-terminal "\033[5 q"))))
  (add-hook 'evil-insert-state-exit-hook
            (lambda ()
              (or (display-graphic-p)
                  (send-string-to-terminal "\033[2 q"))))
  )

(use-package evil-org
  :after org
  :hook (org-mode . (lambda () evil-org-mode))
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;;; Undo, xclip, god mode
(use-package undo-tree
  :diminish
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

;;; Helper funcitons
(defun vitaliy/find-rg-selection (start end)
  "Run counsel rg with selected text"
  (interactive "r")
  (let ((region (buffer-substring-no-properties start end)))
    (evil-normal-state)
    (cond
     ((not vitaliy/ivy-disabled) (counsel-rg region))
     ((not vitaliy/vertico-disabled) (consult-ripgrep nil region))
     ((project-find-regexp region)))
    ))

(defun vitaliy/find-rg-word ()
  "Run counsel rg with word at pointer as initial value"
  (interactive)
  (let ((selected-word (thing-at-point 'word t)))
    (cond
     ((not vitaliy/ivy-disabled) (counsel-rg selected-word))
     ((not vitaliy/vertico-disabled) (consult-ripgrep nil selected-word))
     ((project-find-regexp selected-word)))
    ))

(defun vitaliy/open-config-dir ()
  (interactive)
  ;; (counsel-fzf nil user-emacs-directory)
  (dired-jump t user-emacs-directory)
  )

(defun vitaliy/open-org-dir ()
  (interactive)
  (dired-jump t local-org-path)
  )

(defun vitaliy/evil-shift-left-visual ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun vitaliy/evil-shift-right-visual ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore))

(defun vitaliy/describe-function ()
  (interactive)
  (cond
   ((not vitaliy/ivy-disabled) (counsel-describe-function))
   ((call-interactively 'describe-function))
   )
  )
(defun vitaliy/describe-variable ()
  (interactive)
  (cond
   ((not vitaliy/ivy-disabled) (counsel-describe-variable))
   ((call-interactively 'describe-variable))
   )
  )
(defun vitaliy/describe-symbol ()
  (interactive)
  (counsel-describe-symbol)
  )
(defun vitaliy/find-library ()
  (interactive)
  (counsel-find-library)
  )
(defun vitaliy/info-lookup-symbol ()
  (interactive)
  (counsel-info-lookup-symbol)
  )
(defun vitaliy/unicode-char ()
  (interactive)
  (counsel-unicode-char)
  )
(defun vitaliy/M-x ()
  (interactive)
  (cond
   ((not vitaliy/ivy-disabled) (counsel-M-x))
   ((call-interactively 'execute-extended-command))
   )
  )

(defun vitaliy/switch-buffer ()
  (interactive)
  (cond
   ((not vitaliy/ivy-disabled) (ivy-switch-buffer))
   ((not vitaliy/vertico-disabled) (consult-buffer))
   ((call-interactively 'switch-to-buffer))
   )
  )
;;; General
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
    :keymaps '(normal visual)

    "o" '(:ignore t :wk "org")
    "oa" 'org-agenda
    "oc" 'org-capture
    "o/" 'obsidian-jump
    "od." 'obsidian-daily-note
    "oo" 'obsidian-hydra/body

    "w" '(:ignore t :wk "window")
    "wo" 'other-window
    "w1" 'delete-other-windows
    "SPC" '(god-execute-with-current-bindings :wk "god")

    "h" '(:ignore t :wk "help")
    "hh" 'help
    "hf" '(vitaliy/describe-function :wk "describe function")
    "hv" 'vitaliy/describe-variable
    "ho" 'vitaliy/describe-symbol
    "hl" 'vitaliy/find-library
    "hi" 'vitaliy/info-lookup-symbol
    "hu" 'vitaliy/unicode-char

    "b" '(:ignore t :wk "buffer")
    "bb" 'vitaliy/switch-buffer
    "bB" 'buffer-menu

    "f" '(:ignore t :wk "file")
    "ff" 'consult-git-grep ; 'counsel-fzf
    "f/" 'vitaliy/find-rg-word
    "fo" 'dired-jump
    "fC" 'vitaliy/open-config-dir
    "fO" 'vitaliy/open-org-dir

    "g" '(:ignore t :which-key "git")
    "g'" 'diff-hl-flydiff-mode
    "gd" 'vc-diff

    "u" '(:ignore t :which-key "undo")
    "uu" 'undo
    "ur" 'redo
    "ul" 'undo-tree-visualize

    ":" 'vitaliy/M-x

    "p" '(:ignore t :wk "project")
    "pp" 'project-switch-project
    "pb" 'consult-project-buffer ; 'project-switch-to-buffer
    "p!" 'project-shell-command
    "p&" 'project-async-shell-command
    "po" 'project-dired
    "pe" 'project-eshell
    "pg" 'project-vc-dir
    "pf" 'project-find-file
    )

  (my-leader-def
    :keymaps 'visual
    "f/" 'vitaliy/find-rg-selection
    )

  (evil-ex-define-cmd "gx" 'vitaliy/M-x)
  (evil-ex-define-cmd "god" 'god-execute-with-current-bindings)
  (evil-ex-define-cmd "bm" 'buffer-menu) ; the same as :ls !!!
  (evil-ex-define-cmd "l" 'vitaliy/switch-buffer)
  (evil-ex-define-cmd "h" 'help)

  (general-define-key
   :states 'motion
   :keymaps 'org-agenda-mode-map
   "go" 'org-agenda-open-link
   )

  ;; (general-define-key
  ;;  :states '(normal visual)
  ;;  :keymaps 'eglot-mode-map
  ;;  :prefix "gr"
  ;;  ;; "gr" '(:ignore t :wk "code actions")
  ;;  "n" 'eglot-rename) ;; Add F2
  ;; g r -> xref-find-references (M-?)
  ;; g d -> evil-goto-definition
  ;; (evil-goto-definition-imenu evil-goto-definition-semantic
  ;;                        evil-goto-definition-xref
  ;;                        evil-goto-definition-search)

  (general-define-key
   :states '(normal visual)
   :prefix "["
   "c" 'diff-hl-previous-hunk
   "C" 'diff-hl-show-hunk-previous
   )

  (general-define-key
   :states '(normal visual)
   :prefix "]"
   "c" 'diff-hl-next-hunk
   "C" 'diff-hl-show-hunk-next
   )

  (general-define-key
   :states '(visual)
   ">" 'vitaliy/evil-shift-right-visual ;; keymap("v", "<", "<gv")
   "<" 'vitaliy/evil-shift-left-visual  ;; keymap("v", ">", ">gv")
   )

  (general-define-key
   "C-;" 'god-execute-with-current-bindings) ;; alt god-mode

  ;; always
  ;; (define-key key-translation-map (kbd "SPC") 'event-apply-control-modifier)
  )

;; org-mode
;;; Org
(use-package org
  :ensure nil
  :init
  (setq local-org-path (get-env-from-shell "ORG_AGENDA_PATH"))
  (when (stringp local-org-path)
    (setq org-agenda-files (list local-org-path)))

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t) ;; State, notes, clock in LOGBOOK
  (setq org-startup-folded 'content)
  (setq org-M-RET-may-split-line '((default . nil)))
  (setq org-insert-heading-respect-content t)
  )

(use-package org-tempo
  :ensure nil
  :after org
  :config
  (dolist
      (template
       '(
         ("el" . "src emacs-lisp")
         ("sh" . "src shell")
         ("py" . "src python")
         ("js" . "src js")
         ))
    (add-to-list
     'org-structure-template-alist
     template))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (js . t)
     (shell . t)
     (python . t)))
  ;; (setq org-confirm-babel-evaluate nil) ;; auto confirm
  )

;;; Ivy, a generic completion mechanism for Emacs, swiper, counsel
(setq vitaliy/ivy-disabled t)
(use-package ivy
  :if (not vitaliy/ivy-disabled)
  :diminish
  :demand t
  :config (ivy-mode 1)
  )

(use-package amx ;; command history list in counsel-m-x
  :if (not vitaliy/ivy-disabled)
)

;; Swiper, an Ivy-enhanced alternative to Isearch.
(use-package swiper
  :if (not vitaliy/ivy-disabled)
  :commands (swiper)
  :config
  (setq swiper-goto-start-of-match t))

;; Counsel, a collection of Ivy-enhanced versions of common Emacs commands.
(use-package counsel
  :if (not vitaliy/ivy-disabled)
  :diminish
  :commands (counsel-git-grep counsel-switch-buffer)
  :config
  (keymap-global-set "M-x" #'counsel-M-x)
  (keymap-global-set "C-s" #'swiper-isearch)
  (keymap-global-set "C-x C-f" #'counsel-find-file)
  (setq counsel-fzf-cmd
        "rg --files --hidden -g '!.git' | fzf -f \"%s\"")
  )

(use-package ivy-rich
  :if (not vitaliy/ivy-disabled)
  :init
  (ivy-rich-mode 1))

(use-package hydra
  :if (not vitaliy/ivy-disabled)
  )
(use-package ivy-hydra
  :if (not vitaliy/ivy-disabled)
  )

;;; Vertico, Consult, Margenalia
(setq vitaliy/vertico-disabled nil)

(use-package vertico
  :if (not vitaliy/vertico-disabled)
  :init
  (vertico-mode)
  )

(use-package orderless
  :if (not vitaliy/vertico-disabled)
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package marginalia
  :if (not vitaliy/vertico-disabled)
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode)
  )

(use-package consult
  :if (not vitaliy/vertico-disabled)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :bind
  (;; C-c bindings in `mode-specific-map'
   ("C-c M-x" . consult-mode-command)
   ("C-c h" . consult-history)
   ("C-c k" . consult-kmacro)
   ("C-c m" . consult-man)
   ("C-c i" . consult-info)
   ([remap Info-search] . consult-info)
   ;; C-x bindings in `ctl-x-map'
   ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
   ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
   ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
   ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
   ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
   ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
   ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
   ;; Custom M-# bindings for fast register access
   ("M-#" . consult-register-load)
   ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
   ("C-M-#" . consult-register)
   ;; Other custom bindings
   ("M-y" . consult-yank-pop)                ;; orig. yank-pop
   ;; M-g bindings in `goto-map'
   ("M-g e" . consult-compile-error)
   ("M-g r" . consult-grep-match)
   ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
   ("M-g g" . consult-goto-line)             ;; orig. goto-line
   ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
   ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
   ("M-g m" . consult-mark)
   ("M-g k" . consult-global-mark)
   ("M-g i" . consult-imenu)
   ("M-g I" . consult-imenu-multi)
   ;; M-s bindings in `search-map'
   ("M-s d" . consult-find)                  ;; Alternative: consult-fd
   ("M-s c" . consult-locate)
   ("M-s g" . consult-grep)
   ("M-s G" . consult-git-grep)
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line)
   ("C-s" . consult-line)
   ("M-s L" . consult-line-multi)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ;; Isearch integration
   ("M-s e" . consult-isearch-history)
   :map isearch-mode-map
   ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
   ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
   ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
   ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
   ;; Minibuffer history
   :map minibuffer-local-map
   ("M-s" . consult-history)                 ;; orig. next-matching-history-element
   ("M-r" . consult-history))                ;; orig. previous-matching-history-element
  )

;;; Other

(use-package diminish)

;; C-c o
(use-package command-log-mode
  :diminish
  :config
  (global-command-log-mode))

(use-package hideshow
  :diminish hs-minor-mode
  :hook (prog-mode . hs-minor-mode))

(use-package eldoc :diminish)

(use-package markdown-mode
  :init
  ;; (setq markdown-hide-urls t)
  )

;; https://github.com/laishulu/emacs-tmux-pane
;; package is outdated with outdated dependencies: names, s
;; mkdir <emack dir>/lisp
;; cp tmux-pane.el <emack dir>/lisp # modified
;; package-remove tmux-pane && pacakge-autoremove
(use-package tmux-pane
  :load-path "lisp/"
  :ensure nil
  :config
  (tmux-pane-mode))

(use-package obsidian
  :config
  (setq obsidian-links-use-vault-path t) ;; it does not help
  (global-obsidian-mode t)
  (obsidian-update)
  ;; (obsidian-backlinks-mode t)
  :custom
  (obsidian-directory (get-env-from-shell "OBSIDIAN_VAULT_PATH"))
  (obsidian-daily-notes-directory "notes/dailies")
  (markdown-enable-wiki-links t)
  :bind
  (
   :map
   obsidian-mode-map
   ;; Create note
   ("C-c C-n" . obsidian-capture)
   ;; If you prefer you can use `obsidian-insert-wikilink'
   ("C-c C-l" . obsidian-insert-wikilink)
   ;; Open file pointed to by link at point
   ("C-c C-o" . obsidian-follow-link-at-point)
   ;; Open a different note from vault
   ("C-c C-p" . obsidian-jump)
   ;; Follow a backlink for the current file
   ("C-c C-b" . obsidian-backlink-jump))
  )

(use-package diff-hl
  :init
  (global-diff-hl-mode)
  :hook ((diff-hl-mode . diff-hl-flydiff-mode)
         (diff-hl-mode . diff-hl-margin-mode)
         (dired-mode . diff-hl-dired-mode))
  )

(use-package company
  :diminish
  :after (prog-mode text-mode)
  :hook ((prog-mode text-mode) . company-mode)
  :bind
  (:map
   company-active-map
   ("<tab>" . company-complete-selection)
   ("TAB" . company-complete-selection)
   ("<return>" . nil)
   ("RET" . nil)
   )
  ;; :config
  ;; (define-key company-active-map (kbd "RET") nil)
  ;; (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  :custom
  (company-minimum-prefix-length 3)
  (company-idle-delay 0.0)
  ;; :config
  ;; (add-to-list 'company-backends 'company-yasnippet)
  )

(use-package project
  :ensure nil
  :config
  (setq project-mode-line t))

(use-package yasnippet
  :diminish yas-minor-mode
  :init
  ;; (setq yas-snippet-dirs (list <other path>))
  (yas-global-mode 1)
  )
(use-package yasnippet-snippets)

(with-eval-after-load 'eglot
  (setq eglot-autoshutdown t)              ;; Shutdown server when last buffer closes
  )

;;; Dynamic part

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

(put 'narrow-to-region 'disabled nil)

;;; Personal
(use-package local-config
  :load-path "lisp/"
  :if (locate-library "local-config")
  :ensure nil)
