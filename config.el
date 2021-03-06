;; (defun color-12-to-6 (color-str)
;;   "Convert 12 char color representation to 6 char"
;;   (if (= 7 (length color-str))
;;       color-str
;;     (apply #'color-rgb-to-hex `(,@(color-name-to-rgb color-str) 2))))

;; (defmacro r|set-pair-faces (themes consts faces-alist)
;;   "Macro for pair setting of custom faces.
;; THEMES name the pair (theme-one theme-two). CONSTS sets the variables like
;;   ((sans-font \"Some Sans Font\") ...). FACES-ALIST has the actual faces
;; like:
;;   ((face1 theme-one-attr theme-two-atrr)
;;    (face2 theme-one-attr nil           )
;;    (face3 nil            theme-two-attr)
;;    ...)
;; TODO: Simplify this macro"
;;   (defmacro r||get-proper-faces ()
;;     `(let* (,@consts)
;;        (backquote ,faces-alist)))

;;   `(setq theming-modifications
;;          ',(mapcar (lambda (theme)
;;                      `(,theme ,@(cl-remove-if
;;                                  (lambda (x) (equal x "NA"))
;;                                  (mapcar (lambda (face)
;;                                            (let ((face-name (car face))
;;                                                  (face-attrs (nth (cl-position theme themes) (cdr face))))
;;                                              (if face-attrs
;;                                                  `(,face-name ,@face-attrs)
;;                                                "NA"))) (r||get-proper-faces)))))
;;                    themes)))

;; (r|set-pair-faces
;;  ;; Themes to cycle in
;;  ;; (doom-molokai spacemacs-light

;;  ;; Variables
;;  (;; Palette from desktop color scheme
;;   (dark-1             "#2E3440")
;;   (dark-2             "#3B4252")
;;   (dark-3             "#434C5E")
;;   (dark-4             "#4C566A")
;;   (light-1            "#D8DEE9")
;;   (light-2            "#E5E9F0")
;;   (light-3            "#ECEFF4")
;;   (accent-dark        "#1C2028")
;;   (accent-dark-gray   (color-12-to-6 (color-darken-name accent-dark 1)))
;;   (accent-light       "#8a9899")
;;   (accent-shade-1     "#8FBCBB")
;;   (accent-shade-2     "#88C0D0")
;;   (accent-shade-3     "#81A1C1")
;;   (accent-shade-4     "#5E81AC")
;;   (colors-blue        accent-shade-4)
;;   (colors-blue-2      accent-shade-3)
;;   (colors-red         "#BF616A")
;;   (colors-orange      "#8FBCBB")
;;   (colors-yellow      "#8a9899")
;;   (colors-green       "#A3BE8C")
;;   (colors-purple      "#B48EAD")

;;   ;; For use in levelified faces set
;;   (level-1            colors-blue)
;;   (level-2            colors-blue-2)
;;   (level-3            colors-purple)
;;   (level-4            colors-orange)
;;   (level-5            accent-shade-3)
;;   (level-6            colors-green)
;;   (level-7            accent-shade-2)
;;   (level-8            colors-yellow)
;;   (level-9            accent-shade-1)

;;   ;; Base gray shades
;;   (bg-white           "#FEFFF9")
;;   (bg-dark            accent-dark-gray)
;;   (bg-darker          accent-dark)
;;   (bg-dark-solaire    (color-12-to-6 (color-lighten-name accent-dark 2)))
;;   (fg-white           light-3)
;;   (shade-white        (color-12-to-6 (color-lighten-name light-1 10)))
;;   (highlight          (color-12-to-6 (color-lighten-name accent-dark 4)))
;;   (region-dark        (color-12-to-6 (color-lighten-name accent-dark 2)))
;;   (region             dark-3)
;;   (slate              accent-shade-3)
;;   (gray               (color-12-to-6 (color-lighten-name dark-4 20)))

;;   ;; Programming
;;   (comment            (color-12-to-6 (color-lighten-name dark-4 2)))
;;   (doc                (color-12-to-6 (color-lighten-name dark-4 20)))
;;   (keyword            colors-blue-2)
;;   (builtin            colors-orange)
;;   (variable-name      colors-yellow)
;;   (function-name      accent-shade-2)
;;   (constant           colors-purple)
;;   (type               accent-shade-1)
;;   (string             colors-green)

;;   ;; Fonts
;;   (sans-font          "Source Sans Pro")
;;   (et-font            "EtBembo")
;;   (mono-font          "Iosevka")))

(defvar file-name-handler-alist-old file-name-handler-alist)

(setq ;;package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      auto-window-vscroll nil)

(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; (setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode zenburn-theme json-mode))
;; (when (cl-find-if-not #'package-installed-p package-selected-packages)
;;   (package-refresh-contents)
;;   (mapc #'package-install package-selected-packages))

;; (unless (package-installed-p 'quelpa)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
;;     (eval-buffer)
;;     (quelpa-self-upgrade)))
;; or with use package it

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
	     :defer 10
	     :config
	     ;; Delete residual old versions
	     (setq auto-package-update-delete-old-versions t)
	     ;; Do not bother me when updates have taken place.
	     (setq auto-package-update-hide-results t)
	     ;; Update installed packages at startup if there is an update pending.
	     (auto-package-update-maybe))

;; toggle these in case errors occur
(setq font-lock-verbose nil)
(setq byte-compile-verbose nil)
(setq debug-on-error nil)

;; (setq byte+native-compile t)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;(setq auto-save-default t)
;(setq auto-save-no-message t)
;(setq auto-save-timeout 20
;      auto-save-interval 20)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; pinentry
(setq epa-pinentry-mode 'loopback)

;; limit warning verbosity
(setq native-comp-async-report-warnings-errors nil)
(setq warning-minimum-level :error)

(setq
 visible-bell nil
 scroll-margin 3
 scroll-step 1
 scroll-conservatively 10000
 scroll-preserve-screen-position 1
 create-lockfiles nil
 indent-tabs-mode nil
 tab-width 8
 make-backup-files nil)

(setq 
      create-lockfiles nil) ;; lock files will kill `npm start'

(setenv "PATH" (concat (getenv "PATH") ":/home/rob/.local/bin/"))
(setq exec-path (append exec-path '("/home/rob/.local/bin")))

(use-package quelpa :pin melpa)

;; run all-the-icons-install-fonts
(use-package all-the-icons)

(use-package pretty-mode
  :config
  (global-pretty-mode t)
  (global-prettify-symbols-mode 1))
;; (global-font-lock-mode)
(use-package zenburn-theme
  :ensure t
  :init
  (setq zenburn-use-variable-pitch t)
  (setq zenburn-scale-org-headlines t)
  (setq zenburn-scale-outline-headlines t)
  :config
  (load-theme 'zenburn t))

(set-face-attribute 'default nil
                    :family "Hack"
                    :width 'normal
                    :height 160
                    :weight 'normal
                    :slant 'normal)

;; display glyphs and emojis
(set-fontset-font t nil "Symbola" nil 'prepend)


;; (set-face-attribute 'variable-pitch nil
;; 		    :family "ETBembo"
;; 		    :width 'normal
;; 		    :height 180
;; 		    :weight 'thin)

;; (set-face-attribute 'fixed-pitch nil
;;                     ;;:family "Source Code Pro"
;;                     ;;:family "Hack"
;;                     :family "Fira Code Retina"
;;                     :width 'normal
;;                     :height 180
;;                     :weight 'normal)

(use-package nyan-mode)
;; simplified mode line
(defun mode-line-render (left right)
  (let* ((available-width (- (window-width) (length left) )))
    (format (format "%%s %%%ds" available-width) left right)))

(setq-default mode-line-format
	      '((:eval

		 (mode-line-render
		  (format-mode-line
		   (list
		    (nyan-create)
		    (propertize "???"
				'face
				`(:inherit mode-line-buffer-id)
				'help-echo "Mode(s) menu"
				'mouse-face 'mode-line-highlight
				'local-map   mode-line-major-mode-keymap)
		    ;; buffer name
		    " %b "))
		  (format-mode-line "%4l:%2c  ")))))

;; move modeline to the top of the buffer
;; Not sure if I like this yet..
(setq-default header-line-format mode-line-format)
(setq-default mode-line-format nil)

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

;; (setq-default mode-line-format
;;               (list

               ;; '(:eval (propertize (if (eq 'emacs evil-state) " ??? " " ??? ")
               ;;                     'face (cogent/evil-state-face)))
               ;; " "

               ;; mode-line-misc-info ; for eyebrowse

               ;; '(:eval (when-let (vc vc-mode)
               ;;           (list " "
               ;;                 (propertize (substring vc 5)
               ;;                             'face 'font-lock-comment-face)
               ;;                 " ")))

               ;; ;; value of `mode-name'
               ;; "%m: "
               ;; ;; value of current buffer name
               ;; "buffer %b, "
               ;; ;; value of current line number

               ;; relative position in file
               ;; '(:eval (list (nyan-create))) ;; from the nyan-mode package
               ;; (propertize "%p" 'face 'font-lock-constant-face)

               ;; spaces to align right
               ;; '(:eval (propertize
               ;;          " " 'display
               ;;          `((space :align-to (- (+ right right-fringe right-margin)
               ;;                                ,(+ 3 (string-width mode-name)))))))

               ;; the current major mode
              ;; (propertize " %m " 'face 'font-lock-string-face)

               ;; "line %l "

               ;; '(:eval (list
               ;;          ;; the buffer name; the file name as a tool tip
               ;;          (propertize " %b" 'face 'font-lock-type-face
               ;;                      'help-echo (buffer-file-name))

               ;; (when (buffer-modified-p)
               ;;   (propertize
               ;;    " ???"
               ;;    'face (if (cogent-line-selected-window-active-p)
               ;;              'cogent-line-modified-face
               ;;            'cogent-line-modified-face-inactive)))

               ;; (when buffer-read-only
               ;;   (propertize
               ;;    "???"
               ;;    'face (if (cogent-line-selected-window-active-p)
               ;;              'cogent-line-read-only-face
               ;;            'cogent-line-read-only-face-inactive)))

               ;; " "))


(use-package mixed-pitch
  :config
  (add-hook 'text-mode-hook (lambda ()(mixed-pitch-mode))))

(set-language-environment "English")
(setq sentence-end-double-space nil)
  
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq system-time-locale "C") ;; org-mode weekdays in English

(setq
 ;; debug-on-error t
 user-full-name "Robert Sheynin"
 user-mail-address "robert.sheynin@gmail.com"

 ;; Ensure custom values are saved to an ignored file.
 ;; custom-file (locate-user-emacs-file "custom.el")
 custom-file (expand-file-name "custom.el" user-emacs-directory)

 ;; Don't warn on redefinition
 ad-redefinition-action 'accept

 ;; Don't attempt to load `default.el'
 ;; inhibit-default-init t

 ;; Disable welcome screen.
 inhibit-startup-message t

 ;; Activate character folding in searches i.e. searching for 'a' matches '??' as well
 search-default-mode 'char-fold-to-regexp

 underline-minimum-offset 0)

;; Use y and n instead of yes and no.
(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight the current line
(global-hl-line-mode +1)

(setq split-height-threshold nil)
(setq split-width-threshold 160)

(setq make-backup-files t)
(setq version-control t)
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-old-versions 3)
(setq kept-new-versions 4)
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; saveplace remembers your location in a file when saving files
(require 'saveplace)
;; (setq save-place-file (expand-file-name "saveplace" emacs-d))
;; activate it for all buffers
(setq-default save-place t)

(require 'recentf)
;; recentf
(setq
 recentf-save-file       "~/.emacs.d/var/recentf"
 recentf-max-saved-items 100
 recentf-exclude         '("/tmp/" "/ssh:" "/sudo:"))
(setq no-littering-var-directory "~/.emacs.d/var"
      no-littering-etc-directory "~/.emacs.d/etc")
(add-to-list 'recentf-exclude no-littering-var-directory)
(add-to-list 'recentf-exclude no-littering-etc-directory)
(recentf-mode 1)

(use-package no-littering
:init
(setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
)

(require 'autorevert)
(global-auto-revert-mode 1)

(setq revert-without-query '("\\.pdf" "\\.png"))

(defun vertico--backward-updir ()
  "Delete word before or go up directory, like `ido-mode'."
  (interactive)
  (if (eq (char-before) ?/)
      (save-excursion
	(goto-char (1- (point)))
	(when (search-backward "/" (point-min) t)
	  (delete-region (1+ (point)) (point-max))))
    (call-interactively 'backward-kill-word)))

(defun zz-scroll-half-page (direction)
  "Scrolls half page up if `direction' is non-nil, otherwise will scroll half page down."
  (let ((opos (cdr (nth 6 (posn-at-point)))))
    ;; opos = original position line relative to window
    (move-to-window-line nil)  ;; Move cursor to middle line
    (if direction
        (recenter-top-bottom -1)  ;; Current line becomes last
      (recenter-top-bottom 0))  ;; Current line becomes first
    (move-to-window-line opos)))  ;; Restore cursor/point position

(defun zz-scroll-half-page-down ()
  "Scrolls exactly half page down keeping cursor/point position."
  (interactive)
  (zz-scroll-half-page nil))

(defun zz-scroll-half-page-up ()
  "Scrolls exactly half page up keeping cursor/point position."
  (interactive)
  (zz-scroll-half-page t))


(use-package evil
  :init
  (setq
   evil-overriding-maps nil
   evil-intercept-maps nil
   evil-insert-state-bindings nil

   evil-undo-system 'undo-redo ;; requires emacs 28
   ;; must be set before loading evil no matter what
   evil-want-keybinding nil
   ;; required for gn
   evil-search-module 'evil-search
   evil-ex-search-persistent-highlight nil
   ;; Y like D
   evil-want-Y-yank-to-eol t
   ;; evil-want-minibuffer t
   )


  ;; (setq evil-normal-state-modes
  ;;       (append evil-emacs-state-modes
  ;;               evil-insert-state-modes
  ;;               evil-normal-state-modes
  ;;               evil-motion-state-modes))

  ;; (setq evil-emacs-state-modes nil)
  ;; (setq evil-insert-state-modes nil) ; not sure
  ;; (setq evil-motion-state-modes nil)

  :config
  ;; (evil-set-leader nil (kbd "SPC"))
  (evil-mode)


  (define-key evil-emacs-state-map [escape] 'evil-normal-state)

  (defun r:edit-config ()
    "edit configuration"
    (interactive)
    (find-file
     "~/.emacs.d/config.org"))

  (defun r:reload-config ()
    "edit configuration"
    (interactive)
    (load-file  "~/.emacs.d/init.el"))

  (defun rename-file-and-buffer ()
    "Rename the current buffer and file it is visiting."
    (interactive)
    (let ((filename (buffer-file-name)))
      (if (not (and filename (file-exists-p filename)))
	  (message "Buffer is not visiting a file!")
	(let ((new-name (read-file-name "New name: " filename)))
	  (cond
	   ((vc-backend filename) (vc-rename-file filename new-name))
	   (t
	    (rename-file filename new-name t)
	    (rename-buffer new-name)
	    (set-visited-file-name new-name)
	    (set-buffer-modified-p nil)))))))

  (defun set-selective-display-dlw (&optional level)
    "Fold text indented same of more than the cursor.
If level is set, set the indent level to LEVEL.
If 'selective-display' is already set to LEVEL, clicking
F5 again will unset 'selective-display' by setting it to 0."
    (interactive "P")
    (if (eq selective-display (1+ (current-column)))
	(set-selective-display 0)
      (set-selective-display (or level (1+ (current-column))))))

  (defun r:comment-eclipse ()
    "replacement for comment-dwim built-in - 
if no region is marked the line is commented instead"
    (interactive)
    (let ((start (line-beginning-position)) (end (line-end-position)))
      (when (or (not transient-mark-mode) (region-active-p))
	(setq start (save-excursion (goto-char (region-beginning)) (beginning-of-line) (point))
	      end (save-excursion
		    (goto-char (region-end))
		    (end-of-line)
		    (point)))
	)(comment-or-uncomment-region start end)))

  (defun r:indent-buffer () (interactive) (save-excursion (indent-region (point-min) (point-max) nil)))
  (defun r:comment-box (b e)
    "Draw a box comment around the region but arrange for the region to extend to at least the fill column. Place the point after the comment box."

    (interactive)

    (let ((e (copy-marker e t)))
      (goto-char b)
      (end-of-line)
      (insert-char ?  (- fill-column (current-column)))
      (comment-box b e 1)
      (goto-char e)
      (set-marker e nil)))


  (defun endless/forward-paragraph (&optional n)
    "Advance just past next blank line."
    (interactive "p")
    (let ((m (use-region-p))
	  (para-commands
	   '(endless/forward-paragraph endless/backward-paragraph)))
      ;; Only push mark if it's not active and we're not repeating.
      (or m
	 (not (member this-command para-commands))
	 (member last-command para-commands)
	 (push-mark))
      ;; The actual movement.
      (dotimes (_ (abs n))
	(if (> n 0)
	    (skip-chars-forward "\n[:blank:]")
	  (skip-chars-backward "\n[:blank:]"))
	(if (search-forward-regexp
	     "\n[[:blank:]]*\n[[:blank:]]*" nil t (cl-signum n))
	    (goto-char (match-end 0))
	  (goto-char (if (> n 0) (point-max) (point-min)))))
      ;; If mark wasn't active, I like to indent the line too.
      (unless m
	(indent-according-to-mode)
	;; This looks redundant, but it's surprisingly necessary.
	(back-to-indentation))))

  (defun endless/backward-paragraph (&optional n)
    "Go back up to previous blank line."
    (interactive "p")
    (endless/forward-paragraph (- n)))


  ;; ;; M-a and M-e should take us to the next blank line
  ;; (bind-key "M-a" 'endless/backward-paragraph)
  ;; (bind-key "M-e" 'endless/forward-paragraph)


  ;; evil minibuffer
  ;; (evil-define-key '(normal visual) minibuffer-local-map
  ;;   (kbd "C-j") 'next-line
  ;;   (kbd "C-k") 'previous-line
  ;;   (kbd "C-h") 'vertico--backward-updir)

  ;; (evil-define-key '(normal visual) minibuffer-local-ns-map
  ;;   (kbd "C-j") 'next-line
  ;;   (kbd "C-k") 'previous-line
  ;;   (kbd "C-h") 'vertico--backward-updir)


  ;; (evil-define-key '(normal visual) minibuffer-local-completion-map
  ;;   (kbd "C-j") 'next-line
  ;;   (kbd "C-k") 'previous-line)

  ;; (evil-define-key '(normal visual) minibuffer-local-must-match-map
  ;;   (kbd "C-j") 'next-line
  ;;   (kbd "C-k") 'previous-line)

  ;; (evil-define-key '(normal visual) minibuffer-local-isearch-map
  ;;   (kbd "C-j") 'next-line
  ;;   (kbd "C-k") 'previous-line)


  ;; document navigation bindings
  (evil-define-key '(normal visual) global-map
    ;; (kbd "l") 'backward-evil-symbol
    ;; (kbd "h") 'forward-evil-symbol
    (kbd "j") 'evil-next-line
    (kbd "k") 'evil-previous-line
    ;; (kbd "J") 'end-of-defun
    ;; (kbd "K") 'beginning-of-defun
    (kbd "K") 'endless/backward-paragraph
    (kbd "J") 'endless/forward-paragraph

    (kbd "U U") 'zz-scroll-half-page-up
    (kbd "D D") 'zz-scroll-half-page-down

    ;; (kbd "0") 'beginning-of-line-text
    ;; (kbd ",") '
    ;; (kbd ";") '
    ;; (kbd "m") 'mark-active
    ;; (kbd ";") 'avy-goto-char-timer
    )

  ;; code specific bindings
  ;; (evil-define-key 'normal prog-mode-map
  ;;   "<" 'lispy-barf
  ;;   ">" 'lispy-slurp
  ;;   ;; "F" 'lispy-ace-symbol
  ;;   "M" 'lispy-mark
  ;;   ;; (kbd "M-;") 'lispy-comment
  ;;   "J" 'beginning-of-defun
  ;;   "K" 'end-of-defun
  ;;   )

  (defvar r-intercept-mode-map (make-sparse-keymap)
    "Main precedence keymap")

  (define-minor-mode r-intercept-mode
    "Global minor mode for higher precedence evil keybindings"
    :global t)

  (r-intercept-mode)

  (dolist (state '(normal visual insert))
    (evil-make-intercept-map
     (evil-get-auxiliary-keymap r-intercept-mode-map state t t)
     state))

  (evil-define-key 'normal r-intercept-mode-map
    (kbd "f") 'avy-goto-char-in-line
    (kbd "F") 'avy-goto-char-2

    ;; helpful commands
    (kbd "C-SPC h c") 'helpful-callable
    (kbd "C-SPC h p") 'helpful-at-point
    (kbd "C-SPC h f") 'helpful-function
    (kbd "C-SPC h v") 'helpful-variable
    (kbd "C-SPC h k") 'helpful-key
    (kbd "C-SPC h m") 'describe-mode

    ;; dired 
    (kbd "C-SPC d") 'dired-other-window
    (kbd ", d") 'dired-other-window
    
    ;; file navigation
    (kbd "SPC f r") 'rencentf-open-files
    (kbd "SPC f f") 'find-file
    (kbd "SPC r f") 'rename-file-and-buffer

    ;; magit commands
    (kbd "SPC m s") 'magit-status

    ;; imenu
    ;; (kbd "SPC i i") 'imenu
    (kbd "SPC i i") 'idomenu

    ;; split/join lines
    (kbd "SPC l j") 'evil-join

    ;; (kbd "SPC J") 'dumb-jump-go
    (kbd "SPC x f") 'xref-find-definitions

    (kbd "SPC , i") 'r:edit-config
    (kbd "SPC R R") 'r:reload-config
    
    ;; expand region
    (kbd "SPC e r") 'er/expand-region
    ;; (global-set-key (kbd "C-c e r") 'er/expand-region)

    (kbd "SPC c c") 'r:comment-eclipse
    (kbd "SPC c l") 'lispy-comment
    (kbd "SPC o c") 'occur
    (kbd "SPC c f") 'set-selective-display
    ;; (kbd "SPC r b") 'r:indent-buffer

    ;; never quit emacs
    (kbd "C-c C-x") 'delete-frame

    ;; navigate windows/frames
    (kbd "SPC w h") 'evil-window-left
    (kbd "SPC w l") 'evil-window-right
    (kbd "SPC w k") 'evil-window-up
    (kbd "SPC w j") 'evil-window-down
    (kbd "SPC w v") 'split-window-vertically

    ;; texSPC t-scale adjust
    (kbd "SPC f =") 'text-scale-increase
    (kbd "SPC f -") 'text-scale-decrease

    ;; dumb jump
    (kbd "SPC d j g") 'dumb-jump-go
    (kbd "SPC d j j") 'dumb-jump


    ;; amx binding
    ;; (kbd "M-x") 'amx

;;; browse kill ring
    (kbd "SPC k r") 'browse-kill-ring

    ;; grep
    ;; (kbd "SPC r g") 'rg
    ;; (kbd  "SPC r p") ???rg-project
    (kbd "SPC r g") 'rg-dwim ;; context-sensitive grep
    (kbd "SPC r m") 'rg-menu ;; add flags before executing a grep
    ;; buffers
    (kbd ", b") 'consult-buffer

    ;; eshell
    (kbd "SPC ; ;") 'eshell

    ;; org commands
    (kbd ", o") 'org-capture
    (kbd ", a") 'org-capture

    ;; spell check
    (kbd ", s") 'flyspell-buffer
    )

  ;; rg results buffer navigation
  (evil-define-key 'normal rg-mode-map
    (kbd "j") 'compilation-next-error
    (kbd "k") 'compilation-previous-error
    (kbd "o") 'compilation-goto-error
    (kbd "d") 'rg-rerun-change-dir
    (kbd "t") 'rg-rerun-change-literal
    (kbd "t") 'rg-rerun-change-regexp
    (kbd "m") 'rg-menu
    ;; edit results with wgrep
    (kbd "e") 'wgrep-change-to-wgrep-mode
    )

  ;; dired bindings
  (evil-define-key '(normal visual) dired-mode-map
    (kbd "j") 'dired-next-line
    (kbd "k") 'dired-previous-line
    (kbd "o") 'dired-find-file
    (kbd "O") 'dired-find-file-other-window
    (kbd "J") 'dired-next-subdir
    (kbd "K") 'dired-prev-subdir
    (kbd "H") 'dired-up-directory

    (kbd "D") 'dired-do-delete
    (kbd "R") 'dired-do-rename
    (kbd "C") 'dired-do-copy

    (kbd "m") 'dired-mark
    (kbd "u") 'dired-unmark

    (kbd "% r") 'dired-mark-files-regexp
    (kbd "C-r") 'dired-undo

    (kbd "+") 'dired-create-directory
    (kbd "t") 'dired-create-empty-file

    (kbd "d o") 'dired-do-chown
    (kbd "d m") 'dired-do-chmod)


  (evil-define-key 'normal prog-mode-map
    ;; (kbd "M-;") 'r:comment-eclipse
    (kbd "M-;") 'comment-dwim
    ;; (kbd "M-;") 'comment-normalize-vars
    (kbd "M-:") 'r:comment-box
    ;; dumb jump
    (kbd ", f g") 'dumb-jump-go
    (kbd ", f b") 'dumb-jump-back
    (kbd ", f q") 'dumb-jump-quick-look
    (kbd ", f a") 'xref-find-apropos

    (kbd ", i i") 'imenu
    )

  ;; (evil-define-key nil evil-insert-state-map
  ;;   "C-x C-p" evil-complete-previous-line
  ;;   "C-x C-n" evil-complete-next-line)

  (evil-define-key 'normal org-mode-map
    (kbd "SPC o v") 'org-latex-preview)

  ;; org-mode bindings
  (evil-define-key 'normal org-mode-map
    (kbd ";") 'org-goto
    (kbd "h") 'org-metaleft
    (kbd "l") 'org-metaright
    (kbd "J") 'org-next-visible-heading
    (kbd "K") 'org-previous-visible-heading

    (kbd "RET") 'org-meta-return
    (kbd "O") 'org-meta-return

    ;; insert org structures
    (kbd "SPC o i t") 'org-insert-structure-template
    (kbd "SPC o i h") 'org-insert-heading
    (kbd "SPC o i s") 'org-insert-subheading
    (kbd "SPC o i i") 'org-insert-item

    (kbd ", i t") 'org-insert-structure-template
    (kbd ", i h") 'org-insert-heading
    (kbd ", i s") 'org-insert-subheading
    (kbd ", i i") 'org-insert-item

    ;; capture
    (kbd "SPC o c") 'org-capture
    ;; agenda
    ;; (kbd "SPC o a") 'org-agenda
    )

  (evil-define-key 'normal org-mode-map
    (kbd "TAB") 'org-cycle
    ">" 'org-shiftmetaright
    "<" 'org-shiftmetaleft
    )

  (evil-define-key 'normal org-mode-map
    (kbd "SPC '") 'org-edit-special)

  ;; you can do this, but the key won't work immediately
  ;; (evil-define-key 'normal org-src-mode-map
  ;;   (kbd "SPC '") 'org-edit-src-exit)

  (setq org-super-agenda-header-map (make-sparse-keymap))

  (evil-define-key 'normal org-agenda-mode-map
    (kbd "ESC") 'evil-window-delete
    (kbd "j") 'org-agenda-next-line
    (kbd "k") 'org-agenda-previous-line
    (kbd "TAB") 'org-agenda-todo
    (kbd "r") 'org-agenda-refile
    (kbd "d") 'org-agenda-kill
    (kbd "SPC") nil)

  ;; python bindings
  (evil-define-key 'normal python-mode-map
    (kbd "SPC t p") 'python-pytest-popup
    (kbd "SPC t t") 'python-pytest
    (kbd "SPC t l") 'python-pytest-last-failed
    (kbd "SPC t f") 'python-pytest-function)

  ;; this is a potential workaround
  (defun my-setup-org-edit-src-exit ()
    (evil-local-set-key 'normal (kbd "SPC '") 'org-edit-src-exit))

  (add-hook 'org-src-mode-hook #'my-setup-org-edit-src-exit)

  ;; LSP
  (evil-define-key 'normal lsp-mode-map
    (kbd "SPC l r") 'lsp-rename
    (kbd "SPC l c a") 'lsp-execute-code-action)

  (evil-define-key 'normal eglot-mode-map
    (kbd ", e r") 'eglot-rename
    (kbd ", e o") 'eglot-code-action-organize-imports
    (kbd ", f") 'xref-find-defintions)

  ;; Company
  ;; (evil-define-key '(normal insert) company-active-map
  ;;   (kbd "C-j") 'company-select-next
  ;;   (kbd "C-k") 'company-select-previous)

  ;; Python
  (evil-define-key 'normal python-mode-map
    (kbd "K" ) 'python-nav-backward-defun
    (kbd "J" ) 'python-nav-forward-defun)

  ;; pdf-tools bindings
  (evil-define-key 'normal pdf-view-mode-map
    "g"   'pdf-view-first-page
    "G"   'pdf-view-last-page
    "l"   'image-forward-hscroll
    "h"   'image-backward-hscroll
    "j"   'pdf-view-next-page
    "k"   'pdf-view-previous-page
    "e"   'pdf-view-goto-page
    "u"   'pdf-view-revert-buffer
    "al"  'pdf-annot-list-annotations
    "ad"  'pdf-annot-delete
    "aa"  'pdf-annot-attachment-dired
    "am"  'pdf-annot-add-markup-annotation
    "at"  'pdf-annot-add-text-annotation
    "y"   'pdf-view-kill-ring-save
    "i"   'pdf-misc-display-metadata
    "s"   'pdf-occur
    "b"   'pdf-view-set-slice-from-bounding-box
    "r"  'pdf-view-reset-slice
    (kbd "SPC") nil
    (kbd "C-w") nil
    (kbd "C-c") nil
    (kbd "D") 'pdf-annot-delete
    (kbd "t") 'pdf-annot-add-text-annotation
    (kbd "h") 'pdf-annot-add-highlight-markup-annotation
    )
  )


;; (evil-define-key 'normal 'global
;;   ;; select the previously pasted text
;;   "gp" "`[v`]"
;;   ;; run the macro in the q register
;;   "Q" "@q")
;; 
;; (evil-define-key 'visual 'global
;;   ;; run macro in the q register on all selected lines
;;   "Q" (kbd ":norm @q RET")
;;   ;; repeat on all selected lines
;;   "." (kbd ":norm . RET"))
;; 
;; ;; alternative command version
;; (defun my-norm@q ()
;;   "Apply macro in q register on selected lines."
;;   (interactive)
;;   (evil-ex-normal (region-beginning) (region-end) "@q"))
;; 
;; (evil-define-key 'visual 'global "Q" #'my-norm@q)

;; (evil-define-key 'normal browse-kill-ring-mode-map
;;   (kbd "j") 'browse-kill-ring-)



(use-package evil-surround
  :hook ((after-init . global-evil-surround-mode)))
;; (use-package evil-cleverparens)

(use-package evil-nerd-commenter
  :config
  (evil-define-key '(normal visual) prog-mode-map
    (kbd "c c") 'evilnc-comment-or-uncomment-lines))

(use-package google-translate)
;; (require 'google-translate)
(require 'google-translate-default-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
( global-set-key "\C-cT" 'google-translate-query-translate )

(setq flyspell-sort-corrections nil)
(setq flyspell-issue-message-flag nil)
(with-eval-after-load "ispell"
  ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
  ;; dictionary' even though multiple dictionaries will be configured
  ;; in next line.
  (setenv "LANG" "en_US.UTF-8")
  (setq ispell-program-name "hunspell")
  ;; Configure German, Swiss German, and two variants of English.
  (setq ispell-dictionary "en_US,ru_RU,de_DE,fr-moderne")
  ;; ispell-set-spellchecker-params has to be called
  ;; before ispell-hunspell-add-multi-dic will work
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,ru_RU,de_DE,fr-moderne")
  ;; For saving words to the personal dictionary, don't infer it from
  ;; the locale, otherwise it would save to ~/.hunspell_de_DE.
  (setq ispell-personal-dictionary "~/.hunspell_personal"))

;; The personal dictionary file has to exist, otherwise hunspell will
;; silently not use it.
(unless (file-exists-p ispell-personal-dictionary)
  (write-region "" nil ispell-personal-dictionary nil 0))


;; use hunspell
;; (setq ispell-program-name "hunspell")
;; reset the hunspell so it STOPS querying locale!
;; (setq ispell-local-dictionary "myhunspell")
					; "myhunspell" is key to lookup in `ispell-local-dictionary-alist`
;; two dictionaries "en_US" and "zh_CN" are used. Feel free to remove "zh_CN"
;; (setq ispell-local-dictionary-alist
;;       '(("myhunspell" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US" "zh_CN") nil utf-8)))
;; new variable `ispell-hunspell-dictionary-alist' is defined in Emacs
;; If it's nil, Emacs tries to automatically set up the dictionaries.
;; (when (boundp 'ispell-hunspell-dictionary-alist)
;;       (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist))
;; (setq ispell-program-name "aspell")
;; You could add extra option "--camel-case" for since Aspell 0.60.8 
;; @see https://github.com/redguardtoo/emacs.d/issues/796
;; (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US" "--run-together" "--run-together-limit=16"))


;; support spell checking of camel cased words
(use-package wucuo
  :config
(add-hook 'prog-mode-hook #'wucuo-start)
(add-hook 'text-mode-hook #'wucuo-start)


;; don???t spell check when these modes are active
(setq wucuo-spell-check-buffer-predicate
      (lambda ()
        (not (memq major-mode
                   '(dired-mode
                     log-edit-mode
                     compilation-mode
                     help-mode
                     profiler-report-mode
                     speedbar-mode
                     gud-mode
                     calc-mode
                     Info-mode)))))

(setq wucuo-personal-font-faces-to-check '(font-lock-comment-face))

  )

(use-package direnv
  :config
  (direnv-mode))

;; collection of really useful Xtensions for emacs
(use-package crux
  :config
  (crux-reopen-as-root-mode t))

(use-package vertico
;;  :preface

  ;; (defun vertico--backward-updir ()
  ;;   "Delete char before or go up directory for file cagetory completions."
  ;;   (interactive)
  ;;   (let ((metadata (completion-metadata (minibuffer-contents)
  ;; 					 minibuffer-completion-table
  ;; 					 minibuffer-completion-predicate)))
  ;;     (if (and (eq (char-before) ?/)
  ;;            (eq (completion-metadata-get metadata 'category) 'file))
  ;;         (let ((new-path (minibuffer-contents)))
  ;;           (delete-region (minibuffer-prompt-end) (point-max))
  ;;           (insert (abbreviate-file-name
  ;;                    (file-name-directory
  ;;                     (directory-file-name
  ;;                      (expand-file-name new-path))))))
  ;; 	(call-interactively 'backward-delete-char))))

  :init
  (vertico-mode)

  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)

  ;; (add-hook 'vertico-mode-hook (lambda ()
  ;; 				 (setq completion-in-region-function
  ;;                                      (if vertico-mode
  ;;                                          #'consult-completion-in-region
  ;; 					 #'completion--in-region))))

  (advice-add #'completing-read-multiple
              :override #'consult-completing-read-multiple)
  )

;; Use the `orderless' completion style.
;; Enable `partial-completion' for files to allow path expansion.
;; You may prefer to use `initials' instead of `partial-completion'.
(use-package orderless
  :init
  (setq completion-styles '(orderless)
	completion-category-defaults nil
	completion-category-overrides '((file (styles partial-completion)))))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package embark
  :bind (("C-S-a" . embark-act)
         :map minibuffer-local-map
         ("C-d" . embark-act))
  :config

  ;; Show Embark actions via which-key
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Returns the parent directory containing a .project.el file, if any,
;; to override the standard project.el detection logic when needed.
(defun r-project-override (dir)
  (let ((override (locate-dominating-file dir ".project.el")))
    (if override
	(cons 'vc override)
      nil)))

(use-package project
  ;; Cannot use :hook because 'project-find-functions does not end in -hook
  ;; Cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
  :config
  (add-hook 'project-find-functions #'r-project-override))

(use-package corfu
  :bind (:map corfu-map
              ("C-j" . corfu-next)
              ("C-k" . corfu-previous)
              ("C-f" . corfu-insert))
  :custom
  (corfu-cycle t)
  (corfu-auto t)             ;; Enable auto completion
  (corfu-quit-at-boundary t) ;; Automatically quit at word boundary
  (corfu-quit-no-match t)    ;; Automatically quit if there is no match
  :hook
  (after-init . corfu-global-mode)
  :config
  (corfu-global-mode))

(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand)))
;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package auth-source
  :no-require t
  :config
  (setq auth-sources '(password-store "~/.authinfo")))

(use-package auth-source-pass
  :config
  (auth-source-pass-enable))

(use-package pass)

(use-package password-store)

(setq TeX-parse-self t); Enable parse on load.
(setq TeX-auto-save t); Enable parse on save.
(setq-default TeX-master nil)

(setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)

(add-hook 'TeX-mode-hook 'flyspell-mode); Enable Flyspell mode for TeX modes such as AUCTeX. Highlights all misspelled words.
(add-hook 'emacs-lisp-mode-hook 'flyspell-prog-mode); Enable Flyspell program mode for emacs lisp mode, which highlights all misspelled words in comments and strings.
(setq ispell-dictionary "english"); Default dictionary. To change do M-x ispell-change-dictionary RET.
(add-hook 'TeX-mode-hook (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
(setq LaTeX-babel-hyphen nil); Disable language-specific hyphen insertion.

;; " expands into csquotes macros (for this to work babel must be loaded after csquotes).
(setq LaTeX-csquotes-close-quote "}"
      LaTeX-csquotes-open-quote "\\enquote{")

;; LaTeX-math-mode http://www.gnu.org/s/auctex/manual/auctex/Mathematics.html
(add-hook 'TeX-mode-hook 'LaTeX-math-mode)

;;; RefTeX
;; Turn on RefTeX for AUCTeX http://www.gnu.org/s/auctex/manual/reftex/reftex_5.html
(add-hook 'TeX-mode-hook 'turn-on-reftex)

(eval-after-load 'reftex-vars; Is this construct really needed?
  '(progn
     (setq reftex-cite-prompt-optional-args t); Prompt for empty optional arguments in cite macros.
     ;; Make RefTeX interact with AUCTeX, http://www.gnu.org/s/auctex/manual/reftex/AUCTeX_002dRefTeX-Interface.html
     (setq reftex-plug-into-AUCTeX t)
     ;; So that RefTeX also recognizes \addbibresource. Note that you
     ;; can't use $HOME in path for \addbibresource but that "~"
     ;; works.
     (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
;     (setq reftex-default-bibliography '("UNCOMMENT LINE AND INSERT PATH TO YOUR BIBLIOGRAPHY HERE")); So that RefTeX in Org-mode knows bibliography
     (setcdr (assoc 'caption reftex-default-context-regexps) "\\\\\\(rot\\|sub\\)?caption\\*?[[{]"); Recognize \subcaptions, e.g. reftex-citation
     (setq reftex-cite-format; Get ReTeX with biblatex, see https://tex.stackexchange.com/questions/31966/setting-up-reftex-with-biblatex-citation-commands/31992#31992
           '((?t . "\\textcite[]{%l}")
             (?a . "\\autocite[]{%l}")
             (?c . "\\cite[]{%l}")
             (?s . "\\smartcite[]{%l}")
             (?f . "\\footcite[]{%l}")
             (?n . "\\nocite{%l}")
             (?b . "\\blockcquote[]{%l}{}")))))

;; Fontification (remove unnecessary entries as you notice them) http://lists.gnu.org/archive/html/emacs-orgmode/2009-05/msg00236.html http://www.gnu.org/software/auctex/manual/auctex/Fontification-of-macros.html
(setq font-latex-match-reference-keywords
      '(
        ;; biblatex
        ("printbibliography" "[{")
        ("addbibresource" "[{")
        ;; Standard commands
        ;; ("cite" "[{")
        ("Cite" "[{")
        ("parencite" "[{")
        ("Parencite" "[{")
        ("footcite" "[{")
        ("footcitetext" "[{")
        ;; ;; Style-specific commands
        ("textcite" "[{")
        ("Textcite" "[{")
        ("smartcite" "[{")
        ("Smartcite" "[{")
        ("cite*" "[{")
        ("parencite*" "[{")
        ("supercite" "[{")
        ; Qualified citation lists
        ("cites" "[{")
        ("Cites" "[{")
        ("parencites" "[{")
        ("Parencites" "[{")
        ("footcites" "[{")
        ("footcitetexts" "[{")
        ("smartcites" "[{")
        ("Smartcites" "[{")
        ("textcites" "[{")
        ("Textcites" "[{")
        ("supercites" "[{")
        ;; Style-independent commands
        ("autocite" "[{")
        ("Autocite" "[{")
        ("autocite*" "[{")
        ("Autocite*" "[{")
        ("autocites" "[{")
        ("Autocites" "[{")
        ;; Text commands
        ("citeauthor" "[{")
        ("Citeauthor" "[{")
        ("citetitle" "[{")
        ("citetitle*" "[{")
        ("citeyear" "[{")
        ("citedate" "[{")
        ("citeurl" "[{")
        ;; Special commands
        ("fullcite" "[{")))

(setq font-latex-match-textual-keywords
      '(
        ;; biblatex brackets
        ("parentext" "{")
        ("brackettext" "{")
        ("hybridblockquote" "[{")
        ;; Auxiliary Commands
        ("textelp" "{")
        ("textelp*" "{")
        ("textins" "{")
        ("textins*" "{")
        ;; supcaption
        ("subcaption" "[{")))

(setq font-latex-match-variable-keywords
      '(
        ;; amsmath
        ("numberwithin" "{")
        ;; enumitem
        ("setlist" "[{")
        ("setlist*" "[{")
        ("newlist" "{")
        ("renewlist" "{")
        ("setlistdepth" "{")
        ("restartlist" "{")))

(require 'eshell)
(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-!") 'eshell-here)

    (defun eshell/x ()
      (insert "exit")
      (eshell-send-input)
      (delete-window))

;;; TODO
;; (setenv "PATH"
;;         (concat
;;          "/usr/local/bin:/usr/local/sbin:"
;;          (getenv "PATH")))

;; If any program wants to pass the output through the $PAGER variable
(setenv "PAGER" "cat")
(use-package eshell
  :init
  (setq ;; eshell-buffer-shorthand t ...  Can't see Bug#19391
        eshell-scroll-to-bottom-on-input 'all
        eshell-error-if-no-glob t
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-prefer-lisp-functions nil
        eshell-destroy-buffer-when-process-dies t))

(use-package eshell
  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "ssh")
              (add-to-list 'eshell-visual-commands "tail")
              (add-to-list 'eshell-visual-commands "top"))))

(add-hook 'eshell-mode-hook (lambda ()
    (eshell/alias "e" "find-file $1")
    (eshell/alias "ff" "find-file $1")
    (eshell/alias "emacs" "find-file $1")
    (eshell/alias "ee" "find-file-other-window $1")

    (eshell/alias "gd" "magit-diff-unstaged")
    (eshell/alias "gds" "magit-diff-staged")
    (eshell/alias "d" "dired $1")

    ;; The 'ls' executable requires the Gnu version on the Mac
    (let ((ls (if (file-exists-p "/usr/local/bin/gls")
                  "/usr/local/bin/gls"
                "/bin/ls")))
      (eshell/alias "ll" (concat ls " -AlohG --color=always")))))

;; (defun eshell/gst (&rest args)
;;     (magit-status (pop args) nil)
;;     (eshell/echo))   ;; The echo command suppresses output

;; customizing the eshell prompt
;; https://blog.liangzan.net/blog/2012/12/12/customizing-your-emacs-eshell-prompt/
;; (defun curr-dir-git-branch-string (pwd)
;;   "Returns current git branch as a string, or the empty string if
;; PWD is not in a git repo (or the git command is not found)."
;;   (interactive)
;;   (when (and (not (file-remote-p pwd))
;;              (eshell-search-path "git")
;;              (locate-dominating-file pwd ".git"))
;;     (let* ((git-url (shell-command-to-string "git config --get remote.origin.url"))
;;            (git-repo (file-name-base (s-trim git-url)))
;;            (git-output (shell-command-to-string (concat "git rev-parse --abbrev-ref HEAD")))
;;            (git-branch (s-trim git-output))
;;            (git-icon  "\xe0a0")
;;            (git-icon2 (propertize "\xf020" 'face `(:family "octicons"))))
;;       (concat git-repo " " git-icon2 " " git-branch))))

(setq eshell-history-size 1024)
(setq eshell-prompt-regexp "^[^#$]*[#$] ")

(load "em-hist")           ; So the history vars are defined
(if (boundp 'eshell-save-history-on-exit)
    (setq eshell-save-history-on-exit t)) ; Don't ask, just save
;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)
(if (boundp 'eshell-ask-to-save-history)
    (setq eshell-ask-to-save-history 'always)) ; For older(?) version
;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)

(defun eshell/ef (fname-regexp &rest dir) (ef fname-regexp default-directory))


;;; ---- path manipulation

(defun pwd-repl-home (pwd)
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
   (home-len (length home)))
    (if (and
   (>= (length pwd) home-len)
   (equal home (substring pwd 0 home-len)))
  (concat "~" (substring pwd home-len))
      pwd)))

(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let ((git-output (shell-command-to-string (concat "cd " pwd " && git branch | grep '\\*' | sed -e 's/^\\* //'"))))
      (propertize (concat "["
              (if (> (length git-output) 0)
                  (substring git-output 0 -1)
                "(no branch)")
              "]") 'face `(:foreground "green"))
      )))

(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize ((lambda (p-lst)
            (if (> (length p-lst) 3)
                (concat
                 (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                            (substring elm 0 1)))
                            (butlast p-lst 3)
                            "/")
                 "/"
                 (mapconcat (lambda (elm) elm)
                            (last p-lst 3)
                            "/"))
              (mapconcat (lambda (elm) elm)
                         p-lst
                         "/")))
          (split-string (pwd-repl-home (eshell/pwd)) "/")) 'face `(:foreground "yellow"))
         (or (curr-dir-git-branch-string (eshell/pwd)))
         (propertize "# " 'face 'default))))


;; (defun eshell/eshell-local-prompt-function ()
;;   "A prompt for eshell that works locally (in that is assumes
;; that it could run certain commands) in order to make a prettier,
;; more-helpful local prompt."
;;   (interactive)
;;   (let* ((pwd        (eshell/pwd))
;;          (directory (split-directory-prompt
;;                      (pwd-shorten-dirs
;;                       (pwd-replace-home pwd))))
;;          (parent (car directory))
;;          (name   (cadr directory))
;;          (branch (curr-dir-git-branch-string pwd))
;;          (ruby   (when (not (file-remote-p pwd)) (ruby-prompt)))
;;          (python (when (not (file-remote-p pwd)) (python-prompt)))

;;          (dark-env (eq 'dark (frame-parameter nil 'background-mode)))
;;          (for-bars                 `(:weight bold))
;;          (for-parent  (if dark-env `(:foreground "dark orange") `(:foreground "blue")))
;;          (for-dir     (if dark-env `(:foreground "orange" :weight bold)
;;                         `(:foreground "blue" :weight bold)))
;;          (for-git                  `(:foreground "green"))
;;          (for-ruby                 `(:foreground "red"))
;;          (for-python               `(:foreground "#5555FF")))

;;     (concat
;;      (propertize "?????? "    'face for-bars)
;;      (propertize parent   'face for-parent)
;;      (propertize name     'face for-dir)
;;      (when branch
;;        (concat (propertize " ?????? "    'face for-bars)
;;                (propertize branch   'face for-git)))
;;      (when ruby
;;        (concat (propertize " ?????? " 'face for-bars)
;;                (propertize ruby   'face for-ruby)))
;;      (when python
;;        (concat (propertize " ?????? " 'face for-bars)
;;                (propertize python 'face for-python)))
;;      (propertize "\n"     'face for-bars)
;;      (propertize (if (= (user-uid) 0) " #" " $") 'face `(:weight ultra-bold))
;;      ;; (propertize " ??????" 'face (if (= (user-uid) 0) `(:weight ultra-bold :foreground "red") `(:weight ultra-bold)))
;;      (propertize " "    'face `(:weight bold)))))

;; (setq-default eshell-prompt-function #'eshell/eshell-local-prompt-function)


(setq eshell-highlight-prompt nil)

;; (defun read-file (file-path)
;;   (with-temp-buffer
;;     (insert-file-contents file-path)
;;     (buffer-string)))

;; (defun dw/get-current-package-version ()
;;   (interactive)
;;   (let ((package-json-file (concat (eshell/pwd) "/package.json")))
;;     (when (file-exists-p package-json-file)
;;       (let* ((package-json-contents (read-file package-json-file))
;;              (package-json (ignore-errors (json-parse-string package-json-contents))))
;;         (when package-json
;;           (ignore-errors (gethash "version" package-json)))))))

;; (defun dw/map-line-to-status-char (line)
;;   (cond ((string-match "^?\\? " line) "?")))

;; (defun dw/get-git-status-prompt ()
;;   (let ((status-lines (cdr (process-lines "git" "status" "--porcelain" "-b"))))
;;     (seq-uniq (seq-filter 'identity (mapcar 'dw/map-line-to-status-char status-lines)))))

;; (defun dw/get-prompt-path ()
;;   (let* ((current-path (eshell/pwd))
;;          (git-output (shell-command-to-string "git rev-parse --show-toplevel"))
;;          (has-path (not (string-match "^fatal" git-output))))
;;     (if (not has-path)
;; 	(abbreviate-file-name current-path)
;;       (string-remove-prefix (file-name-directory git-output) current-path))))

;; ;; This prompt function mostly replicates my custom zsh prompt setup
;; ;; that is powered by github.com/denysdovhan/spaceship-prompt.
;; (defun dw/eshell-prompt ()
;;   (let ((current-branch (magit-get-current-branch))
;;         (package-version (dw/get-current-package-version)))
;;     (concat
;;      "\n"
;;      (propertize (system-name) 'face `(:foreground "#62aeed"))
;;      (propertize " ??? " 'face `(:foreground "white"))
;;      (propertize (dw/get-prompt-path) 'face `(:foreground "#82cfd3"))
;;      (when current-branch
;;        (concat
;;         (propertize " ??? " 'face `(:foreground "white"))
;;         (propertize (concat "??? " current-branch) 'face `(:foreground "#c475f0"))))
;;      (when package-version
;;        (concat
;;         (propertize " @ " 'face `(:foreground "white"))
;;         (propertize package-version 'face `(:foreground "#e8a206"))))
;;      (propertize " ??? " 'face `(:foreground "white"))
;;      (propertize (format-time-string "%I:%M:%S %p") 'face `(:foreground "#5a5b7f"))
;;      (if (= (user-uid) 0)
;;          (propertize "\n#" 'face `(:foreground "red2"))
;;        (propertize "\n??" 'face `(:foreground "#aece4a")))
;;      (propertize " " 'face `(:foreground "white")))))

;; (unless dw/is-termux
;;   (add-hook 'eshell-banner-load-hook
;;             (lambda ()
;;               (setq eshell-banner-message
;;                     (concat "\n" (propertize " " 'display (create-image "~/.dotfiles/.emacs.d/images/flux_banner.png" 'png nil :scale 0.2 :align-to "center")) "\n\n")))))

;; (defun dw/eshell-configure ()
;;   (require 'evil-collection-eshell)
;;   (evil-collection-eshell-setup)

;;   (use-package xterm-color)

;;   (push 'eshell-tramp eshell-modules-list)
;;   (push 'xterm-color-filter eshell-preoutput-filter-functions)
;;   (delq 'eshell-handle-ansi-color eshell-output-filter-functions)

;;   ;; Save command history when commands are entered
;;   (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

;;   (add-hook 'eshell-before-prompt-hook
;;             (lambda ()
;;               (setq xterm-color-preserve-properties t)))

;;   ;; Truncate buffer for performance
;;   (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

;;   ;; We want to use xterm-256color when running interactive commands
;;   ;; in eshell but not during other times when we might be launching
;;   ;; a shell command to gather its output.
;;   (add-hook 'eshell-pre-command-hook
;;             (lambda () (setenv "TERM" "xterm-256color")))
;;   (add-hook 'eshell-post-command-hook
;;             (lambda () (setenv "TERM" "dumb")))

;;   ;; Use completion-at-point to provide completions in eshell
;;   (define-key eshell-mode-map (kbd "<tab>") 'completion-at-point)

;;   ;; Initialize the shell history
;;   (eshell-hist-initialize)

;;   (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'consult-history)
;;   (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
;;   (evil-normalize-keymaps)

;;   (setenv "PAGER" "cat")

;;   (setq eshell-prompt-function      'dw/eshell-prompt
;;         eshell-prompt-regexp        "^?? "
;;         eshell-history-size         10000
;;         eshell-buffer-maximum-lines 10000
;;         eshell-hist-ignoredups t
;;         eshell-highlight-prompt t
;;         eshell-scroll-to-bottom-on-input t
;;         eshell-prefer-lisp-functions nil))

;; (use-package eshell
;;   :hook (eshell-first-time-mode . dw/eshell-configure)
;;   :init
;;   (setq eshell-directory-name "~/.dotfiles/.emacs.d/eshell/"
;;         eshell-aliases-file (expand-file-name "~/.dotfiles/.emacs.d/eshell/alias")))

;; (use-package eshell-z
;;   :hook ((eshell-mode . (lambda () (require 'eshell-z)))
;;          (eshell-z-change-dir .  (lambda () (eshell/pushd (eshell/pwd))))))

;; (use-package exec-path-from-shell
;;   :init
;;   (setq exec-path-from-shell-check-startup-files nil)
;;   :config
;;   (when (memq window-system '(mac ns x))
;;     (exec-path-from-shell-initialize)))

;; (dw/leader-key-def
;;  "SPC" 'eshell)

(require 'dired)

(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq delete-by-moving-to-trash nil)
(setq dired-listing-switches "-AFhlv --group-directories-first")
(setq dired-dwim-target t)
;; :hook ((dired-mode . dired-hide-details-mode)
;;        (dired-mode . hl-line-mode))

;; always delete and copy recursively
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(setq dired-guess-shell-alist-user '(("\\.pdf\\'" "zathura")
                                     ("\\.mkv\\'" "vlc")
                                     ("\\.mp4\\'" "vlc")
                                     ("\\.avi\\'" "vlc")
                                     ))

(use-package async
  :after (dired)
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

(with-eval-after-load "dired"
  (add-hook
   'dired-mode-hook
   (lambda () (dired-async-mode))))

(use-package dired-hacks-utils
  :after (dired)
  :config
  (add-hook
   'dired-mode-hook
   (lambda ()
     (dired-utils-format-information-line))))

(use-package dired-filter
  :after (dired)
  :init
  (setq dired-filter-group-saved-groups
	'(("default"
	   ("PDF"
	    (extension . "pdf"))
	   ("LaTeX"
	    (extension "tex" "bib"))
	   ("Org"
	    (extension . "org"))
	   ;; ("Audio"
	   ;;  (extension . "mp3" "ogg"))
	   ;; ("Video"
	   ;;  (extension . "mkv" "mp4" "avi"))
	   ("Archives"
	    (extension "zip" "rar" "gz" "bz2" "tar"))))) 
  :config
  (add-hook 'dired-mode-hook (lambda () (dired-filter-group-mode t))))

(use-package dired-rainbow
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    ))

(use-package org
  :preface
  (defun my-align-all-tables ()
    "Align all tables in an org document"
    (interactive)
    (org-table-map-tables 'org-table-align 'quietly))

  (defun ded/org-show-next-heading-tidily ()
    "Show next entry, keeping other entries closed."
    (if (save-excursion (end-of-line) (outline-invisible-p))
	(progn (org-show-entry) (show-children))
      (outline-next-heading)
      (unless (and (bolp) (org-on-heading-p))
	(org-up-heading-safe)
	(hide-subtree)
	(error "Boundary reached"))
      (org-overview)
      (org-reveal t)
      (org-show-entry)
      (show-children)))

  (defun ded/org-show-previous-heading-tidily ()
    "Show previous entry, keeping other entries closed."
    (let ((pos (point)))
      (outline-previous-heading)
      (unless (and (< (point) pos) (bolp) (org-on-heading-p))
	(goto-char pos)
	(hide-subtree)
	(error "Boundary reached"))
      (org-overview)
      (org-reveal t)
      (org-show-entry)
      (show-children)))


  (define-skeleton org-skeleton
    "Header info for a emacs-org file."
    "Title: "
    "#+TITLE:" str " \n"
    "#+AUTHOR: Your Name\n"
    "#+email: rob@oblomovite.com\n"
    "#+INFOJS_OPT: \n"
    "#+BABEL: :session *R* :cache yes :results output graphics :exports both :tangle yes \n"
    "-----"
    )

;; (defun my/org-font ()
;;   (face-remap-add-relative 'default :family "Alef"))
;; (add-hook 'org-mode-hook 'my/org-font)

  :init
  (setq org-html-htmlize-output-type 'css)

  (setq org-directory "~/org/")
  (setq org-agenda-start-on-weekday nil)

  (setq
   org-src-fontify-natively t
   org-src-tab-acts-natively t
   org-src-preserve-indentation nil
   org-src-window-setup 'current-window
   org-src-fontify-natively t
   org-edit-src-content-indentation 0

   org-refile-allow-creating-parent-nodes 'confirm
   org-refile-use-cache t)

  (setq
   org-hide-emphasis-markers t
   org-hide-leading-stars t

   org-fontify-done-headline t
   org-pretty-entities t)

  (setq org-refile-use-outline-path 'file
	org-outline-path-complete-in-steps nil)

  (setq org-emphasis-alist
	'(
	  ("*" (bold :foreground "orange" ))
	  ("/" italic)
	  ("=" org-verbatim verbatim)

	  ("*!" (bold :foreground "orange" ))
	  ("*/" italic)
	  ("*=" org-verbatim verbatim)
	  ("*_" underline)
	  ;; ("=" (:background "maroon" :foreground "white"))
	  ;; ("~" (:background "deep sky blue" :foreground "MidnightBlue"))
	  ;; ("+" (:strike-through t))
	  ))

  (setq org-startup-folded 'fold)
  ;; (setq org-hide-block-startup t)
  (setq org-startup-indented t
	;; org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
	org-ellipsis " ??? " ;; folding symbol
	org-pretty-entities t
	;; show actually italicized text instead of /italicized text/
	org-fontify-whole-heading-line t
	org-fontify-done-headline t
	org-fontify-quote-and-verse-blocks t)

  (setq-default
   prettify-symbols-alist '(("#+BEGIN_SRC" . "???")
			    ("#+END_SRC" . "???")
			    ("#+begin_src" . "???")
			    ("#+end_src" . "???")))


;;; Show bullets instead of a dash
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([-]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "???"))))))
  (font-lock-add-keywords 'org-mode
			  '(("^ *\\([+]\\) "
			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "???"))))))


  ;;; Automatically change list bullets
  (setq org-list-demote-modify-bullet
	(quote (("+" . "-")
		("-" . "+")
		("*" . "-")
		("1." . "-"))))
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      ;; (variable-pitch-mode 1)
	      visual-line-mode))
;;; automatically insert line break at 80 characters
  (add-hook 'org-mode-hook (lambda () (setq fill-column 80)))
  (add-hook 'org-mode-hook 'auto-fill-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)

  (setq prettify-symbols-unprettify-at-point 'right-edge)
  (add-hook 'org-mode-hook 'prettify-symbols-mode))

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (
;;                        :family "Source Sans Pro"
;;                        :height 120
;;                        :weight light))))
;;  '(fixed-pitch ((t (
;;                     family "Hack"
;;                     :slant normal
;;                     :weight normal
;;                     :height 0.9
;;                     :width normal)))))


;; (let* ((variable-tuple
;;         (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
;;               ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;;               ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
;;               ((x-list-fonts "Verdana")         '(:font "Verdana"))
;;               ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;        (base-font-color     (face-foreground 'default nil 'default))
;;        (headline           `(:inherit default :weight bold :foreground ,base-font-color))
;;        )

;;   (custom-theme-set-faces
;;    'user
;;    `(org-level-8 ((t (,@headline ,@variable-tuple :height 1.20))))
;;    `(org-level-7 ((t (,@headline ,@variable-tuple :height 1.20))))
;;    `(org-level-6 ((t (,@headline ,@variable-tuple :height 1.20))))
;;    `(org-level-5 ((t (,@headline ,@variable-tuple :height 1.20))))
;;    `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.20))))
;;    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.30))))
;;    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.40))))
;;    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.50))))
;;    `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil)))))) 

;; (custom-theme-set-faces
;;  'user
;;  '(variable-pitch ((t (:family "ETBembo" :height 180 :weight thin))))
;;  '(fixed-pitch ((t ( :family "Fira Code Retina" :height 160)))))

;; (custom-theme-set-faces
;;  'user
;;  '(org-block ((t (:inherit fixed-pitch))))
;;  '(org-code ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-document-info ((t (:foreground "dark orange"))))
;;  '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;;  '(org-link ((t (:foreground "royal blue" :underline t))))
;;  '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-property-value ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
;;  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
;;  '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))

;; (custom-theme-set-faces
;;  'user
;;  '(org-block
;;    ((t (:inherit fixed-pitch))))
;;  '(org-document-info-keyword
;;    ((t (:inherit (shadow fixed-pitch)))))
;;  '(org-property-value
;;    ((t (:inherit fixed-pitch))) t)
;;  '(org-special-keyword
;;    ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;;  '(org-tag
;;    ((t (:inherit (shadow fixed-pitch) :weight bold))))
;;  '(org-verbatim
;;    ((t (:inherit (shadow fixed-pitch))))))


;; org id
(setq org-id-link-to-org-use-id
      'create-if-interactive-and-no-custom-id)

(setq org-export-html-style
      "<style type=\"text/css\">
    <!--/*--><![CDATA[/*><!--*/
      .src             { background-color: #F5FFF5; position: relative; overflow: visible; }
      .src:before      { position: absolute; top: -15px; background: #ffffff; padding: 1px; border: 1px solid #000000; font-size: small; }
      .src-sh:before   { content: 'sh'; }
      .src-bash:before { content: 'sh'; }
      .src-R:before    { content: 'R'; }
      .src-perl:before { content: 'Perl'; }
      .src-sql:before  { content: 'SQL'; }
      .example         { background-color: #FFF5F5; }
    /*]]>*/-->
 </style>")

;; Download some themes 
;; https://github.com/fniessen/org-html-themes

(require 'ob-js)

(add-to-list 'org-babel-load-languages '(js . t))
;(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
(add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))

(setq org-babel-default-header-args:js
      '(
	(:session . "\"*JS REPL*\"") 	;indium
	;; (:session . "\"*Javascript REPL*\"") ;js-comint
	(:cache . "no") 
	(:hlines . "no")))

(require 'ob-python)

(add-to-list 'org-babel-load-languages '(python . t))
;(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)
(add-to-list 'org-babel-tangle-lang-exts '("python" . "python"))

(setq org-babel-default-header-args:python
      '((:session . "default")
	(:cache . "no") 
	(:hlines . "no")))


;; (setq org-babel-default-header-args
;;       '((:session . "default")
;; 	(:results . "silent")
;; 	(:exports . "code")
;; 	(:cache . "no")
;; 	(:noweb . "no")
;; 	(:hlines . "no")
;; 	(:tangle . "no")))

(use-package ob-go
  :config
  (add-to-list 'org-babel-load-languages  '(go . t))
  (add-to-list 'org-babel-tangle-lang-exts '("go" . "go"))
  (setq org-babel-default-header-args:go
	'((:session . "default")
	  ;; (:imports . "\???\(\"fmt\" \"time\"\)\")
	  ;; (:cache . "no") 
	  ;(:hlines . "no")
	  ))
  )

(use-package ob-dart
  :config
  (add-to-list 'org-babel-load-languages  '(dart . t)))

(use-package ob-translate)

(use-package ob-async)

(require 'ob)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (R . t)
					;   (python . t)
   (C . t)
   (octave . t)
   (ditaa . t)
   (octave . t)
   (shell . t)
   (gnuplot . t)
   (dot . t)
   (ditaa . t)
   (haskell . t)
   (ledger . t)
   (octave . t)
   (processing . t)
   (latex . t)
   (lisp . t)
   (awk . t)
   (sed .  t)
   (clojure .  t)
   (processing . t )
   (plantuml . t)))


(add-to-list 'org-structure-template-alist
	     '(("pp" . "src python :session default")
	       ("sh" . "src sh")
	       ("el" . "src emacs-lisp")
	       ("ts" . "src typescript")
	       ("gg" . "src go")
	       ("rr" . "src R")))

(setq org-confirm-babel-evaluate nil
      org-confirm-shell-link-function nil
      org-confirm-elisp-link-function nil)


(org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages)

(setq org-latex-pdf-process
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))

;; use =xelatex=. Required for documents where I want to use ttf fonts.
;; (setq org-latex-pdf-process
;;       '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))



  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))

  (add-to-list 'org-latex-classes
	       '("ethz"
		 "\\documentclass[a4paper,11pt,titlepage]{memoir}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
		 ("\\chapter{%s}" . "\\chapter*{%s}")
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  
  (add-to-list 'org-latex-classes
	       '("article"
		 "\\documentclass[11pt,a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")))

  
  (add-to-list 'org-latex-classes '("ebook"
				    "\\documentclass[11pt, oneside]{memoir}
\\setstocksize{9in}{6in}
\\settrimmedsize{\\stockheight}{\\stockwidth}{*}
\\setlrmarginsandblock{2cm}{2cm}{*} % Left and right margin
\\setulmarginsandblock{2cm}{2cm}{*} % Upper and lower margin
\\checkandfixthelayout
% Much more laTeX code omitted
"
				    ("\\chapter{%s}" . "\\chapter*{%s}")
				    ("\\section{%s}" . "\\section*{%s}")
				    ("\\subsection{%s}" . "\\subsection*{%s}")))

  

  (add-to-list 'org-latex-classes
	       '("moderncv"
		 "\\documentclass[11pt,a4paper]{moderncv}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage{rotating}
\\usepackage[normalem]{ulem}
\\usepackage{amsmath}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{amssymb}
\\usepackage{hyperref}
\\usepackage{mathpazo}
\\usepackage{color}
\\usepackage{enumerate}
\\definecolor{bg}{rgb}{0.95,0.95,0.95}
\\tolerance=1000
      [NO-DEFAULT-PACKAGES]
      [PACKAGES]
      [EXTRA]
\\linespread{1.1}
\\hypersetup{pdfborder=0 0 0}"
		 ;; These map to org-header levels 
		 ("\\subsection{%s}" . "\\subsection*{%s}") ;; *
		 ("\\subsection{%s}" . "\\subsection*{%s}") ;; **
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ;; *** etc
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")))


  (define-key org-src-mode-map "\C-c\C-x\C-l" 'org-edit-preview-latex-fragment)

  (defun org-edit-preview-latex-fragment ()
    "Write latex fragment from source to parent buffer and preview it."
    (interactive)
    (org-src-in-org-buffer (org-preview-latex-fragment)))

(use-package org-download
  :custom
  (org-download-method 'directory)
  (org-download-timestamp "%Y%m%d-%H%M%S_")
  (org-image-actual-width 300)
  (org-download-screenshot-method
   "flameshot gui --raw > %s")
  ;; :bind
  ;; ("C-M-y" . org-download-screenshot)
  :config
  (setq-default org-download-image-dir "~/org/images")
  (add-hook 'dired-mode-hook 'org-download-enable))

(use-package org-noter)

(require 'org-capture)
(require 'org-protocol)

(defadvice org-capture
    (after make-full-window-frame activate)
  "Advise capture to be the only window when used as a popup"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-frame)))

;; align tags as far right as possible
(setq org-tags-column -100) 		;default is -77

;; apply id to capture
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

;;; Org Capture Templates

  ;; (setq org-capture-templates '(
  ;;                               ("w" "Weekly" item
  ;;                                (file+olp+datetree
  ;;                                 (concat org-directory "weekly.org"))
  ;;                                "* %?" :tree-type week)

  ;;                               ("r" "A Reminder (tickler)." entry
  ;;                                (file "~/org/reminders.org")
  ;;                                "* %?\nSCHEDULED: %^t"
  ;;                                :empty-lines 1)

  ;;                               ("e" "Errand" entry
  ;;                                (file+headline "~/org/inbox.org" "Work")
  ;;                                "* TODO %^{task name}\n%u\n%a\n"
  ;;                                :clock-in t :clock-resume t)

  ;;                               ("m" "Snippet" entry
  ;;                                (file+headline "~/org/inbox.org" "Research")
  ;;                                "* %^{Title} %?\n %^C")

  ;;                               ("t" "todo" entry (file org-default-notes-file)
  ;;                                "* TODO %?\n" :clock-in t :clock-resume t)

  ;;                               ("T" "todo with interactive selection of kill/clip"
  ;;                                entry (file org-default-notes-file)
  ;;                                "* TODO %?\n%^C\n" :clock-in t :clock-resume t)

  ;;                               ("x" "todo" entry (file org-default-notes-file)
  ;;                                "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)

  ;;                               ("y" "respond" entry (file org-default-notes-file)
  ;;                                "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n"
  ;;                                :clock-in t :clock-resume t :immediate-finish t)

  ;;                               ("m" "Meeting" entry (file org-default-notes-file)
  ;;                                "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
  
  (setq org-capture-templates nil)

  ;; Template for Scheduled Tasks
  ;; (add-to-list 'org-capture-templates (list "r" "REMINDER"
  ;;                                           'entry
  ;;                                           (list 'file+headline
  ;;                                                 (expand-file-name "refile.org" org-directory)
  ;;                                                 "[scheduled]")
  ;;                                           "* %i%? \n %U"
  ;;                                           :empty-lines-after 2))

  ;; capturing todos
  (add-to-list 'org-capture-templates (list "t" "TODO"
					    'entry
					    (list 'file+headline
						  (expand-file-name "refile.org" org-directory)
						  "[inbox]")
					    "* TODO %? %^G\n\n"
					    :empty-lines-after 1))

  ;; capturing links
  (add-to-list 'org-capture-templates (list "l"
					    "READING"
					    'entry
					    (list 'file+headline
						  (expand-file-name "refile.org" org-directory)
						  "To read")
					    "* UNREAD %? %^g\n %x\n\n"
					    :empty-lines-after 1))

;; ;; capture Habits
;; (add-to-list 'org-capture-templates (list "h" 
;;                                           "Habit" 
;;                                           'entry 
;;                                           (list 'file 
;;                                                 (expand-file-name "habits.org" org-directory))
;;                                           "* TODO %?\n SCHEDULED: <%<%Y-%m-%d .+1d/2d>>\n :PROPERTIES:\n :STYLE: habit\n :REPEAT_TO_STATE: NEXT\n :END:\n"
;; 					  :empty-lines-after 1))


  ;; ;; Template for capturing habit
  ;; (add-to-list 'org-capture-templates
  ;;              (list "G" "Habit" 'entry
  ;;                    (list 'file (expand-file-name "habits.org" org-directory))
  ;;                    "* TODO %?\n SCHEDULED: <%<%Y-%m-%d .+1d/2d>>\n :PROPERTIES:\n :STYLE: habit\n :REPEAT_TO_STATE: NEXT\n :END:\n"))


  ;; Template for capturing notes
  ;; (add-to-list 'org-capture-templates (list "n"
  ;;                                           "Note"
  ;;                                           'entry
  ;;                                           (list 'file+headline
  ;;                                                 (expand-file-name "refile.org" org-directory)
  ;;                                                 "Unfiled")
  ;;                                           "* %? %^G\n\n"
  ;;                                           :empty-lines-after 2))

  ;; Template for capturing appointments
  ;; (add-to-list 'org-capture-templates
  ;;              (list "S" "Appointment" 'plain
  ;;                    (list 'file
  ;;                          (expand-file-name "appt.org" org-directory))
  ;;                    "* TODO %? %^g\n  SCHEDULED: <%(org-read-date)>"))


  ;; Template to capture an expense
  ;; (add-to-list 'org-capture-templates
  ;;              (list
  ;;               "Z" "Record a expense in the current ledger file"
  ;;               'plain (list 'function #'--get-current-ledger-file)
  ;;               "\n%(format-time-string \"%Y/%m/%d\") %^{Purpose of the expense?}\n    %?"))

(require 'org-agenda)
(defun jump-to-org-agenda ()
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*"))
	wind)
    (if buf
	(if (setq wind (get-buffer-window buf))
	    (select-window wind)
	  (if (called-interactively-p)
	      (progn
		(select-window (display-buffer buf t t))
		(org-fit-window-to-buffer)
		;; (org-agenda-redo)
		)
	    (with-selected-window (display-buffer buf)
	      (org-fit-window-to-buffer)
	      ;; (org-agenda-redo)
	      )))
      (call-interactively 'org-agenda-list)))
  ;;(let ((buf (get-buffer "*Calendar*")))
  ;;  (unless (get-buffer-window buf)
  ;;    (org-agenda-goto-calendar)))
  )

(run-with-idle-timer 300 t 'jump-to-org-agenda)


(setq org-completion-use-ido t)
(setq org-refile-use-outline-path nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
;; The last line enables the creation of nodes on the fly.
(setq org-agenda-block-separator "" )
	
(setq org-agenda-files
      (mapcar (lambda (d) (concat org-directory d ".org"))
	      '("refile"
		"inbox"
		"someday"
		"habits")))


(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 4))))

(defun my/verify-refile-target ()
  "Exclude todo keywords with a DONE state from refile targets"
  (or (not (member (nth 2 (org-heading-components)) org-done-keywords)))
  (save-excursion (org-goto-first-child)))
(setq org-refile-target-verify-function 'my/verify-refile-target)


(setq org-agenda-custom-commands
      '(("h" "Daily habits" 
         ((agenda ""))
         ((org-agenda-show-log t)
          (org-agenda-ndays 7)
          (org-agenda-log-mode-items '(state))
          (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
        ;; other commands here
        ))


(setq org-todo-keywords
    (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
	    (sequence "UNREAD(u!)" "READING(r!)" "|" "READ(f@/!)"))))

  ;; Colors for TODO keywords
  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "#ecbcbc" :weight bold)
		("NEXT" :foreground "#799080" :weight bold)
		("DONE" :foreground "#ffcfaf" :weight bold)
		("WAITING" :foreground "#ffcfaf" :weight bold)
		("HOLD" :foreground "#bca3a3" :weight bold)
		("CANCELLED" :foreground "#ffcfaf" :weight bold)
		("UNREAD" :foreground "#ecbcbc" :weight bold)
		("READING" :foreground "#799080" :weight bold)
		("READ" :foreground "#ffcfaf" :weight bold))))

  ;; Custom task priorities
  (setq org-default-priority ?E)
  (setq org-lowest-priority ?E)

  (setq org-reverse-note-order t)

(use-package ox-hugo
  :after ox
  :config
  (setq org-hugo-date-format "\"%Y-%m-%d\""))

(use-package pcsv
  :preface
  (defun yf/lisp-table-to-org-table (table &optional function)
    "Convert a lisp table to `org-mode' syntax, applying FUNCTION to each of its elements.
The elements should not have any more newlines in them after
applying FUNCTION ; the default converts them to spaces. Return
value is a string containg the unaligned `org-mode' table."
    (unless (functionp function)
      (setq function (lambda (x) (replace-regexp-in-string "\n" " " x))))
    (mapconcat (lambda (x)			; x is a line.
		 (concat "| " (mapconcat function x " | ") " |"))
	       table "\n"))
  :config
  (defun yf/csv-to-table (beg end)
    "Convert a csv file to an `org-mode' table."
    (interactive "r")
    (require 'pcsv)
    (insert (yf/lisp-table-to-org-table (pcsv-parse-region beg end)))
    (delete-region beg end)
    (org-table-align))

  )

(use-package org-journal
  :defer t
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j ")
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-date-format "%A, %d %B %Y"))

(use-package org-bullets)

(quelpa
  '(org-fc
   :fetcher git :url "https://git.sr.ht/~l3kn/org-fc"
   :files (:defaults "awk" "demo.org")))

(require 'org-fc)
(require 'org-fc-hydra)

(evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-flip-mode
  (kbd "RET") 'org-fc-review-flip
  (kbd "n") 'org-fc-review-flip
  (kbd "s") 'org-fc-review-suspend-card
  (kbd "q") 'org-fc-review-quit)

(evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-rate-mode
  (kbd "a") 'org-fc-review-rate-again
  (kbd "h") 'org-fc-review-rate-hard
  (kbd "g") 'org-fc-review-rate-good
  (kbd "e") 'org-fc-review-rate-easy
  (kbd "s") 'org-fc-review-suspend-card
  (kbd "q") 'org-fc-review-quit)

(setq org-fc-directories '("~/org/"))

;; (use-package dash) 
;; (use-package s) 
;; (use-package f) 
;; (use-package emacssql) 
;; (use-package emacssql-sqlite3) 

;; (use-package org-roam
;;   :hook
;;   (after-init . org-roam-mode)
;;   :custom
;;   (org-roam-directory (concat (getenv "HOME") "/org/"))
;;   :bind (:map org-roam-mode-map
;;               (("C-c n l" . org-roam)
;;                ("C-c n f" . org-roam-find-file)
;;                ("C-c n g" . org-roam-graph))
;;               :map org-mode-map
;;               (("C-c n i" . org-roam-insert)))
;;   :config
;;   (setq org-roam-capture-templates
;; 	'(("d" "default" plain 
;;            (function org-roam--capture-get-point)
;;            "%?"
;;            :file-name "${slug}"
;;            :head "#+title: ${title}\n#+date: %U\n#+roam_alias: \n#+roam_tags: \n\n"
;;            :unnarrowed t))))

;; For the usual org-capture behavior you can call M-x org-roam-capture instead of M-x org-roam-find-file.

;; Org-roam makes it easy to create notes, and link them together. To link notes together, we call M-x org-roam-insert. This brings up a prompt with a list of title for existing notes. Selecting an existing entry will create and insert a link to the current file. Entering a non-existent title will create a new note with that title. Good usage of Org-roam requires liberally linking files: this facilitates building up a dense graph of inter-connected notes.
;; Org-roam provides an interface to view backlinks. It shows backlinks for the currently active Org-roam note, along with some surrounding context. To toggle the visibility of this buffer, call M-x org-roam.

;; For a visual representation of the notes and their connections, Org-roam also provides graphing capabilities, using Graphviz. It generates graphs with notes as nodes, and links between them as edges. The generated graph can be used to navigate to the files, but this requires some additional setup (see Roam Protocol).


;; (use-package org-roam
;;       :ensure t
;;       :hook
;;       (after-init . org-roam-mode)
;;       :custom
;;       (org-roam-directory "~/.org-roam/")
;;       (org-roam-dailies-directory "~/.org-roam/daily/")
;;       (set org-roam-dailies-capture-templates
;;            '(("t" "todo" entry
;;               #'org-roam-capture--get-point
;;               "* %?"
;;               :file-name "daily/%<%Y-%m-%d>"
;;               :head "#+title: %<%Y-%m-%d>\n"
;;               :olp ("Todo"))

;;              ("j" "journal" entry
;;               #'org-roam-capture--get-point
;;               "* %?"
;;               :file-name "daily/%<%Y-%m-%d>"
;;               :head "#+title: %<%Y-%m-%d>\n"
;;               :olp ("Journal"))))
;;       (org-roam-graph-viewer "open")
;;       ;; :bind (:map org-roam-mode-map
;;       ;;         (("C-c n l" . org-roam)
;;       ;;          ("C-c n f" . org-roam-find-file)
;;       ;;          ("C-c n g" . org-roam-graph)
;;       ;;          ("C-c n j" . org-roam-dailies-capture-today)
;;       ;;          ("C-c n t" . org-roam-dailies-capture-tomorrow))
;;       ;;         :map org-mode-map
;;       ;;         (("C-c n i" . org-roam-insert))
;;       ;;         (("C-c n I" . org-roam-insert-immediate)))
;;       )

(use-package calendar
  :config
  (setq calendar-mark-diary-entries-flag t)
  (setq calendar-time-display-form
        '(24-hours ":" minutes
                   (when time-zone
                     (concat " (" time-zone ")"))))
  (setq calendar-week-start-day 1)      ; Monday
  (setq calendar-date-style 'iso)
  (setq calendar-christian-all-holidays-flag nil)
  (setq calendar-holidays
        (append ;;holiday-local-holidays
         holiday-solar-holidays)))

(use-package helpful)

(use-package magit)

(use-package avy
  ;; :bind
  ;; (("C-;" . avy-goto-char-timer))
  :config
  (setq avy-background t)
  (setq avy-style 'at-full)
  (setq avy-timeout-seconds 0.3))

(use-package goto-chg
  ;; :bind (("C-c \\" . goto-last-change)
  ;;        ("C-c |" . goto-last-change-reverse))
  )

(use-package pdf-tools

  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install)

  ;; make pdf-tools the default viewer
  ;; (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
  ;; 	TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
  ;; 	TeX-source-correlate-start-server t)

  ;; (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  ;; (setq-default pdf-view-display-size 'fit-page)
  ;; ;; automatically annotate highlights
  ;; (setq pdf-annot-activate-created-annotations t)
  ;; ;; use normal isearch
  ;; (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  ;; ;; turn off cua so copy works
  ;; (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
  ;; more fine-grained zooming
  (setq pdf-view-resize-factor 1.1)
  )

(use-package browse-kill-ring
  :defer 5
  :commands browse-kill-ring
  :config
  (browse-kill-ring-default-keybindings)
  (global-set-key (kbd "M-B") 'browse-kill-ring))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(require 'tramp)
(setq tramp-verbose 10)                                                  
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-method-alist
             '("\\`localhost\\'" "\\`root\\'" "su"))

(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
         (org-mode . rainbow-mode)))
(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode-enable)
  ;; :hook
  ;; ((cider-repl-mode
  ;;   clojure-mode
  ;;   clojurescript-mode
  ;;   emacs-lisp-mode
  ;;   lisp-mode
  ;;   racket-mode
  ;;   scheme-mode) . rainbow-delimiters-mode)
  )

(use-package paren
  :config
  (setq show-paren-style 'parenthesis)
  (setq show-paren-when-point-in-periphery t)
  (setq show-paren-when-point-inside-paren nil)
  ;; :hook (after-init . show-paren-mode)
  )

(use-package highlight-parentheses
  :init (setq hl-paren-highlight-adjacent t)
  :hook ((after-init . global-highlight-parentheses-mode)))

(use-package which-key
  :config (which-key-mode))

(use-package xref :pin gnu)

(use-package hydra)

(use-package dumb-jump
  :preface
  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))
  :init
  ;; Preserve jump list in evil
  (defun evil-set-jump-args (&rest ns) (evil-set-jump))
  (advice-add 'dumb-jump-goto-file-line :before #'evil-set-jump-args)

;; use rg
  (setq dumb-jump-prefer-searcher 'rg)
;; pass flags to git-grep
  (setq dumb-jump-git-grep-search-args "")
;; pass args to rg
  (setq dumb-jump-rg-search-args "--pcre2")
  :config
  ;; enable xref backend
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  ;; requires xref 1.1.0 or emacs 28.1
  (setq xref-show-definitions-function #'xref-show-definitions-completing-read))

(use-package rg
:init
(setq rg-align-position-numbers t)
(setq rg-align-line-number-field-length 3)
(setq rg-align-column-number-field-length 3)
(setq rg-align-line-column-separator "#")
(setq rg-align-position-content-separator "|")

(rg-define-search search-everything-at-home
  "Search files including hidden in home directory"
  :query ask
  :format literal
  :files "everything"
  :flags ("--hidden")
  :dir (getenv "HOME")
  :menu ("Search" "h" "Home"))

  :config
  (rg-enable-default-bindings)
  (rg-enable-menu)

)

;; not sure I need both..
(use-package deadgrep
  :config
  (global-set-key (kbd "<f5>") #'deadgrep))

(use-package embrace)

(use-package shell
  :commands shell-command
  :config
  (setq ansi-color-for-comint-mode t)
  (setq shell-command-prompt-show-cwd t) ; Emacs 27.1
  :bind (("<s-S-return>" . shell)))

(require 'comint)
(setq comint-buffer-maximum-size 8192)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (require 'shell-mode)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

(define-skeleton html-redirect-page
      "Inserts an Web page that can redirect to STR."
      "URL: "
      "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n"
      "\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
      "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n"
      "<head>\n"
      "<meta http-equiv=\"Refresh\" content=\"1;url=" str "\" />\n" 
      "<title>Redirecting to " (setq v1 (skeleton-read "Title: ")) "</title>\n"
      "</head>\n"
      "<body>\n"
      "<p>Redirecting to\n"
      "<a href=\"" str "\">" v1 "</a>.\n"
      "&hellip;</p>\n"
      "</body>\n"
      "</html>")

;;  TODO
;; (define-skeleton ob-python-graphic-plot

;; #+name: savefig
;; #+begin_src python :var figname="plot.svg" width=5 height=5 :exports none
;;   return f"""plt.savefig('{figname}', width={width}, height={height})
;;   '{figname}'"""
;; #+end_src

;; #+header: :noweb strip-export
;; #+begin_src python :results value file :session :exports both
;;   import matplotlib, numpy
;;   import matplotlib.pyplot as plt
;;   fig=plt.figure(figsize=(4,2))
;;   x=numpy.linspace(-15,15)
;;   plt.plot(numpy.sin(x)/x)
;;   fig.tight_layout()
;;   <<savefig(figname="plot.png", width=10, height=5)>>
;; #+end_src
;; or
;; #+begin_src python :results file
;; import matplotlib, numpy
;; matplotlib.use('Agg')
;; import matplotlib.pyplot as plt
;; fig=plt.figure(figsize=(4,2))
;; x=numpy.linspace(-15,15)
;; plt.plot(numpy.sin(x)/x)
;; fig.tight_layout()
;; plt.savefig('images/python-matplot-fig.png')
;; return 'images/python-matplot-fig.png' # return filename to org-mode
;; #+end_src
;;   )

;; TODO pandas dataframe to org table
;; #+name: pd2org
;; #+begin_src python :var df="df" :exports none
;;   return f"return tabulate({df}, headers={df}.columns, tablefmt='orgtbl')"
;; #+end_src

;; #+header: :prologue from tabulate import tabulate
;; #+header: :noweb strip-export
;; #+begin_src python :results value raw :exports both
;;   import pandas as pd
;;   df = pd.DataFrame({
;;       "a": [1,2,3],
;;       "b": [4,5,6]
;;   })
;;   <<pd2org("df")>>
;; #+end_src

(use-package autoinsert
  :ensure nil
  :init
  ;; Don't want to be prompted before insertion:
  (setq auto-insert-query nil)

  (setq auto-insert-directory (locate-user-emacs-file "templates/files"))
  (add-hook 'find-file-hook 'auto-insert)
  (auto-insert-mode 1)

  :config
  (define-auto-insert "\\.html?$" "default-html.html")
)

(use-package yasnippet
  :hook (((org-mode git-commit-mode) . yas-minor-mode))
  :config
  (setq yas-snippet-dirs
	'("/home/rob/.emacs.d/snippets"
	  "/home/rob/.emacs.d/etc/yasnippet/snippets/"))
  (progn
    (yas-reload-all)))
(use-package yasnippet-snippets)

(use-package re-builder
  :config
  (setq reb-re-syntax 'read))

;; Operate on the results of grep
(use-package wgrep
  :config
  (setq wgrep-auto-save-buffer t)
  (setq wgrep-change-readonly-file t))

(use-package expand-region
  :config
  (global-set-key (kbd "C-c e r") 'er/expand-region))

(use-package flycheck
  :disabled
  :config
  (setq flycheck-indication-mode 'right-fringe)
  (setq flycheck-check-syntax-automatically '(save
                                              idle-change
                                              mode-enabled))
  (setq flycheck-idle-change-delay 2.0)
  (set-face-attribute 'flycheck-warning nil
                      :background "#b58900"
                      :foreground "#262626"
                      :underline nil)

  (set-face-attribute 'flycheck-error nil
                      :background "#dc322f"
                      :foreground "#262626"
                      :underline nil)

  (evil-define-key 'normal prog-mode-map
    ;(kbd ", e l") 'flycheck-list-errors
    (kbd ", e e") 'consult-flycheck
    ;(kbd ", e n") 'flycheck-next-error
    ;(kbd ", e p") 'flycheck-previous-error
    ;(kbd ", e x") 'flycheck-explain-error-at-point
    )

  (add-hook 'after-init-hook #'global-flycheck-mode))
(use-package consult-flycheck :disabled)


(use-package flymake
  :config
  (setq flymake-indication-mode 'right-fringe)
  (setq flymake-check-syntax-automatically '(save
					     idle-change
					     mode-enabled))
  (setq flymake-idle-change-delay 2.0)
  (set-face-attribute 'flymake-warning nil
                      :background "#b58900"
                      :foreground "#262626"
                      :underline nil)

  (set-face-attribute 'flymake-error nil
                      :background "#dc322f"
                      :foreground "#262626"
                      :underline nil)

  (evil-define-key 'normal prog-mode-map
    (kbd ", e e") 'consult-flymake
    ;(kbd ", e n") 'flymake-next-error
    ;(kbd ", e p") 'flymake-previous-error
    ;(kbd ", e x") 'flymake-explain-error-at-point
    )

  (add-hook 'after-init-hook 'flymake-mode))

(use-package skeletor
  :init
  (setq
   skeletor-project-directory "~/projects"
   skeletor-user-directory "~/.emacs.d/templates/projects/")
  :config
  (skeletor-define-template "java"
    :title "Java"
    :requires-executables '(("direnv" . "https://direnv.net/"))
    :after-creation
    (lambda (dir)
      (skeletor-async-shell-command "direnv allow")))
  (skeletor-define-template "python-flask"
    :title "Python Flask Application"
    :requires-executables '(("direnv" . "https://direnv.net/"))
    :after-creation
    (lambda (dir)
      (skeletor-async-shell-command "direnv allow"))))

;; your custom face to color secondary comments blue
(defface my-second-comment-face '((t (:foreground "blue"))) "its a face")

(define-derived-mode testy-mode fundamental-mode
  "test"
  (modify-syntax-entry ?/ "<1")
  (modify-syntax-entry ?/ "<2")
  (modify-syntax-entry 10 ">")
  (font-lock-add-keywords
   'testy-mode
   ;; this highlights || followed by anything to the end of the line as long as there is
   ;; a // before it on the same line.
   ;; the 2 means only highlight the second regexp group, and the t means highlight it
   ;; even if it has been highlighted already, which is should have been.
   '(("\\(//.*\\)\\(||.*$\\)" 2 'my-second-comment-face t))))

(defun prelude-font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.
	This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook #'prelude-font-lock-comment-annotations)

(use-package elec-pair
  :if (>= emacs-major-version 25)
  :hook
  ((prog-mode . electric-pair-local-mode)
;;   (smartparens-mode . (lambda () (electric-pair-local-mode -1)))
))
;; (electric-pair-mode 1)
(require 'eldoc)
(global-eldoc-mode t)
(use-package electric
  :hook ((prog-mode . electric-quote-local-mode)
         (text-mode . electric-quote-local-mode)
         (org-mode . electric-quote-local-mode)
         (message-mode . electric-quote-local-mode)
         (prog-mode . electric-indent-local-mode)
         (prog-mode . electric-layout-mode)
         (haskell-mode . (lambda () (electric-indent-local-mode -1)))
         (nix-mode . (lambda () (electric-indent-local-mode -1)))))

(use-package paredit
  :ensure nil
  :diminish
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode)
  :bind (:map paredit-mode-map
              ("[")
              ("M-k"   . paredit-raise-sexp)
              ("M-I"   . paredit-splice-sexp)
              ("C-M-l" . paredit-recentre-on-sexp)
              ("C-c ( n"   . paredit-add-to-next-list)
              ("C-c ( p"   . paredit-add-to-previous-list)
              ("C-c ( j"   . paredit-join-with-next-list)
              ("C-c ( J"   . paredit-join-with-previous-list))
  :bind (:map lisp-mode-map       ("<return>" . paredit-newline))
  :bind (:map emacs-lisp-mode-map ("<return>" . paredit-newline))
  :hook (paredit-mode
         . (lambda ()
             (unbind-key "M-r" paredit-mode-map)
             (unbind-key "M-s" paredit-mode-map)))
  :config
  (require 'eldoc)
  (eldoc-add-command 'paredit-backward-delete
                     'paredit-close-round))

;; (use-package paredit-ext
;;   :ensure nil
;;   :after paredit)

;; (use-package lispyville
;;   :init
;;   (add-hook 'lispy-mode-hook #'lispyville-mode)
;;   (add-hook 'emacs-lisp-mode-hook #'lispyville-mode)
;;   :config
;;   (lispyville-set-key-theme '(operators c-w additional)))

;; (use-package lispy
;;   :commands (lispy-mode)
;;   :config
;;   (add-hook
;;    'emacs-lisp-mode-hook
;;    (lambda () (lispy-mode 1))))

;; (use-package lsp-mode
;;   :commands lsp
;;   :hook ((typescript-mode js2-mode web-mode) . lsp)
;;   :bind (:map lsp-mode-map
;;               ("TAB" . completion-at-point))
;;   :custom (lsp-headerline-breadcrumb-enable nil))

;; (dw/leader-key-def
;;  "l"  '(:ignore t :which-key "lsp")
;;  "ld" 'xref-find-definitions
;;  "lr" 'xref-find-references
;;  "ln" 'lsp-ui-find-next-reference
;;  "lp" 'lsp-ui-find-prev-reference
;;  "ls" 'counsel-imenu
;;  "le" 'lsp-ui-flycheck-list
;;  "lS" 'lsp-ui-sideline-mode
;;  "lX" 'lsp-execute-code-action)

;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :config
;;   (setq lsp-ui-sideline-enable t)
;;   (setq lsp-ui-sideline-show-hover nil)
;;   (setq lsp-ui-doc-position 'bottom)
;;   (lsp-ui-doc-show))

(use-package lsp-ui
  :disabled
  :config
  (setq
   lsp-ui-peek-always-show t
   lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-enable t
	;; disable flycheck setup so default linter isn't trampled
	lsp-ui-flycheck-enable nil
	lsp-ui-sideline-show-symbol nil
	lsp-ui-sideline-show-hover nil
	lsp-ui-sideline-show-code-actions nil
	lsp-ui-peek-enable nil
	lsp-ui-imenu-enable nil
	lsp-ui-doc-enable nil))

(use-package lsp-mode
  :commands lsp
  :init
  (setq
   lsp-auto-configure t
   lsp-enable-dap-auto-configure nil ; Don't try to auto-enable dap: this creates a lot of binding clashes
   lsp-before-save-edits t
   lsp-eldoc-enable-hover t
   lsp-eldoc-render-all t
   lsp-completion-enable t
   lsp-completion-show-detail t
   lsp-completion-show-kind t
   lsp-enable-file-watchers t
   lsp-enable-folding t
   lsp-enable-imenu t
   lsp-enable-indentation t
   lsp-enable-links t
   lsp-clients-python-library-directories `("/usr/" ,(expand-file-name "~/.virtualenvs")) ; This seems appropriate
   lsp-enable-on-type-formatting nil
   lsp-enable-snippet nil ;; Not supported by company capf, which is the recommended company backend
   lsp-enable-symbol-highlighting nil
   lsp-enable-text-document-color nil
   lsp-enable-xref t
   lsp-flycheck-live-reporting nil
   lsp-idle-delay 0.5
   lsp-imenu-show-container-name t
   lsp-imenu-sort-methods '(position kind name)
   lsp-pyls-plugins-flake8-enabled t
   lsp-signature-auto-activate t
   lsp-signature-render-documentation t
   lsp-signature-doc-lines 10
   lsp-enable-symbol-highlighting t
   ;; don't set flymake or lsp-ui so the default linter doesn't get trampled
   ;;lsp-diagnostic-package :none
   )

  ;; :hook
  ;; (((js2-mode rjsx-mode) . lsp)
  ;;  ((python-mode . lsp)
  ;;   ;; (lsp-mode . lsp-enable-imenu)
  ;;   (lsp-mode . lsp-enable-which-key-integration)))
  :config
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)
     ;; Disable these as they're duplicated by flake8
     ("pyls.plugins.pycodestyle.enabled" nil t)
     ("pyls.plugins.mccabe.enabled" nil t)
     ("pyls.plugins.pyflakes.enabled" nil t)))

  ;; make sure we have lsp-imenu everywhere we have LSP
  ;; (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)  
  ;; (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
		    :major-modes '(nix-mode)
		    :server-id 'nix))
  )

(use-package consult-lsp
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'consult-lsp-symbols))

(use-package dap-mode
  :custom
  (lsp-enable-dap-auto-configure nil)
  :config
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (require 'dap-node)
  (dap-node-setup))

;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))



;; (use-package dap-mode
;;   ;; :bind (:map dap-server-log-mode-map
;;   ;;             :map dap-mode-map
;;   ;;             ([f9] . dap-continue)
;;   ;;             ([S-f9] . dap-disconnect)
;;   ;;             ([f10] . dap-next)
;;   ;;             ([f11] . dap-step-in)
;;   ;;             ([S-f11] . dap-step-out)
;;   ;;             ([f12] . dap-hide/show-ui))
;;   :config
;;   (dap-mode t)
;;   (dap-ui-mode t))

;; (use-package slime
;;   :config
;;   (setq inferior-lisp-program "sbcl"))

(use-package
    elisp-format
  :bind (:map emacs-lisp-mode-map
              ("C-c f" . 'my-elisp-format-buffer))
  :config (add-hook 'lisp-mode-hook (lambda ()
                                      (lsp-mode nil)))
  (defun my-elisp-format-buffer ()
    (interactive)
    (elisp-format-buffer)
    (whitespace-cleanup))
  :custom (elisp-format-column 80))

(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook (lambda ()
                               (if (file-exists-p (concat buffer-file-name "c"))
                                   (delete-file (concat buffer-file-name "c"))))
            nil t))

(add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save)

(use-package aggressive-indent
  :diminish
  :hook (emacs-lisp-mode . aggressive-indent-mode))

(use-package eglot
  :after (direnv)
  :commands eglot
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("rnix-lsp")))
  (add-hook 'nix-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  ;; (add-hook 'dart-mode-hook 'eglot-ensure)
  (setq eglot-server-programs
	`((dart-mode .
		     ("dart"
		      ,(expand-file-name "snapshots/analysis_server.dart.snapshot"
                                         (file-name-directory
                                          (file-truename
                                           (executable-find "dart"))))
		      "--lsp"))))

  )

(use-package lsp-dart
					; :config
					;(add-hook 'dart-mode #'lsp)
  )

;; (defun set-flutter-sdk-dir ()
;;   (direnv-update-environment)
;;   (setq lsp-dart-flutter-sdk-dir
;;         (string-trim-right (shell-command-to-string "echo $FLUTTER_SDK"))))

(use-package dart-mode
  :init
  ;; (add-hook 'dart-mode-hook 'set-flutter-sdk-dir)
  (setq dart-format-on-save t))

(use-package hover) ;; run app from desktop without emulator

(use-package emmet-mode
  :diminish
  :hook (css-mode sgml-mode web-mode typescript-mode js2-mode)
  :config
  ;; :bind (:map emmet-mode-keymap
  ;;             ;; (e)mmet (e)xpand
  ;;             ("C-c e e" . emmet-expand-line))
  )

(use-package affe
  :after orderless
  :config
  ;; Configure Orderless
  (setq affe-regexp-function #'orderless-pattern-compiler
        affe-highlight-function #'orderless--highlight)

  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key (kbd "M-.")))

(require 'eww)
(setq
 browse-url-browser-function 'eww-browse-url ; Use eww as the default browser
 shr-use-fonts  nil                          ; No special fonts
 shr-use-colors nil                          ; No colours
 shr-indentation 2                           ; Left-side margin
 shr-width 70                                ; Fold text to 70 columns
 eww-search-prefix "https://wiby.me/?q=")    ; Use another engine for searching

(use-package eww-lnum
  :config
  (eval-after-load "eww"
    '(progn (define-key eww-mode-map "f" 'eww-lnum-follow)
	    (define-key eww-mode-map "F" 'eww-lnum-universal)))
  )

(use-package lsp-java
  :init
  
  ;; (setq lsp-java-configuration-runtimes '[
  ;; 					  ;; (:name "JavaSE-1.8"
  ;; 					  ;; 	 :path "/home/kyoncho/jdk1.8.0_201.jdk/")
  ;; 					  (:name "JavaSE-11"
  ;; 						 :path "/home/kyoncho/jdk-11.0.1.jdk/"
  ;; 						 :default t)])

  ;; vscode defaults
(setq lsp-java-vmargs '("-XX:+UseParallelGC" "-XX:GCTimeRatio=4" "-XX:AdaptiveSizePolicyWeight=90" "-Dsun.zip.disableMemoryMapping=true" "-Xmx2G" "-Xms100m"))
  :config (add-hook 'java-mode-hook 'lsp))

(use-package dap-java :ensure nil)

(require 'lsp-java-boot)

;; to enable the lenses
(add-hook 'lsp-mode-hook #'lsp-lens-mode)
(add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

(use-package js-comint)

;;; latex
(use-package auctex
  :mode ("\\.tex'" . LaTeX-mode)

  :init
  (setq TeX-auto-save t) 
  (setq TeX-parse-self t) 
  (setq TeX-save-query nil)
  (setq TeX-PDF-mode t)

  (if system-type 'gnu/linux
    (setq TeX-view-program-list '(("zathura" "zathura %o"))
          TeX-view-program-selection '((output-pdf "zathura"))))

  (setq TeX-view-program-selection '((output-pdf "zathura")))

  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'orgtbl-mode)
  ;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  ;; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
  (setq reftex-plug-into-AUCTeX t))

;;; prog mode hooks
(use-package which-func
  :config (which-function-mode 1))

(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :diminish rainbow-delimiters-mode)

(defun prelude-font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

        This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):\\)"
          1 font-lock-warning-face t))))


(add-hook 'prog-mode-hook #'prelude-font-lock-comment-annotations)

;; web
(add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-hook 'web-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)
  (emmet-mode)))
(custom-set-variables '(coffee-tab-width 2))

(global-font-lock-mode t)
;; dired
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

(use-package nix-mode
  :no-require t)

(defun nix-shell-context (orig-func &rest args)
  "Set a temporary environment with the correct paths to wrap default 
commands"
  (let* ((nix-path
	  (condition-case nil
	      (nix-exec-path 
	       (nix-find-sandbox
		(or  (file-name-directory
		     (or  buffer-file-name "")) 
		    "/")))
	    (error nil)))
	 (exec-path (or nix-path exec-path)))
    (apply orig-func args)))

;; Functions which need to have their context potentially changed
(advice-add 'executable-find :around #'nix-shell-context)

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . lsp)
  :config
  (remove-hook 'before-save-hook #'nix-mode-format))

;; (use-package company-jedi)
;; ;; (add-hook 'python-mode-hook (lambda () ('lsp)))
;; (require 'python)
;; (defun my/python-mode-hook ()
;;   (add-to-list 'company-backends 'company-jedi))
;; (add-hook 'python-mode-hook 'my/python-mode-hook)
;; ;; (setq python-shell-interpreter "ipython"
;; ;;        python-shell-interpreter-args "-i")

;; Syntax highlighting for requirements.txt files
(use-package pip-requirements)

(use-package blacken
  ;; :hook (python-mode . blacken-mode)
  :defer t
  :config
  ;; Skips temporary sanity checks
  (setq blacken-fast-unsafe t)
  ;; Use fill-column line-length
  (setq blacken-line-length 'fill))

(use-package python-pytest
  :after python
  :custom
  (python-pytest-arguments
   '("--color"          ;; colored output in the buffer
     "--failed-first"   ;; run the previous failed tests first
     "--maxfail=5"))    ;; exit in 5 continuous failures in a run
  )

(use-package web-mode
  :mode ("\\.html\\'")
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-engines-alist
        '(("django" . "focus/.*\\.html\\'")
          ("ctemplate" . "realtimecrm/.*\\.html\\'"))))

(use-package web-beautify
  :bind (:map web-mode-map
              ("C-c b" . web-beautify-html)
              :map js2-mode-map
              ("C-c b" . web-beautify-js)))

;; (use-package web-mode
;; ;  :mode "(\\.\\(html?\\|ejs\\|tsx\\|jsx\\)\\'"
;;   :config
;;   (setq-default web-mode-code-indent-offset 2)
;;   (setq-default web-mode-markup-indent-offset 2)
;;   (setq-default web-mode-attribute-indent-offset 2))

;; 1. Start the server with `httpd-start'
;; 2. Use `impatient-mode' on any buffer
(use-package impatient-mode)

(use-package skewer-mode)

;; (use-package rjsx-mode
;;   :mode ("\\.js\\'"
;; 	 "\\.jsx\\'")
;;   :config
;;   (setq js2-mode-show-parse-errors nil
;; 	js2-mode-show-strict-warnings nil
;; 	js2-basic-offset 2
;; 	js-indent-level 2)
;;   )

;; (defun enable-minor-mode (my-pair)
;;   "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
;;   (if (buffer-file-name)
;;       (if (string-match (car my-pair) buffer-file-name)
;; 	  (funcall (cdr my-pair)))))


(eval-after-load 'web-mode
  '(progn
     (add-hook 'web-mode-hook #'prettier-js-mode)))

(setq js-comint-program-command "node")

;; (defvar inferior-js-minor-mode-map (make-sparse-keymap))
;; (define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
;; (define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)

;; (define-minor-mode inferior-js-keys-mode
;;   "Bindings for communicating with an inferior js interpreter."
;;   :init-value nil :lighter " InfJS" :keymap inferior-js-minor-mode-map)

;; (dolist (hook '(js2-mode-hook js-mode-hook))
;;   (add-hook hook 'inferior-js-keys-mode))

(use-package js2-mode)
(use-package dash)
(use-package s)
(use-package multiple-cursors)

(use-package prettier-js
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode))

(use-package xref-js2
  :config
  (add-hook 'js2-mode-hook
	    (lambda ()
	      (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
  (setq xref-js2-search-program 'rg)
  )
(use-package js2-refactor
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode))




(use-package indium
  :config
  (setq indium-chrome-executable "chromium"))

(use-package typescript-mode
             :mode ("\\.ts[x]?\\'" "\\.js[x]?\\'")
             :hook (typescript-mode . lsp-deferred)
             :config
             (setq typescript-indent-level 2))

;; (use-package irony
;;   :config
;;   (progn
;;     ;; If irony server was never installed, install it.
;;     (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

;;     (add-hook 'c++-mode-hook 'irony-mode)
;;     (add-hook 'c-mode-hook 'irony-mode)

;;     ;; Use compilation database first, clang_complete as fallback.
;;     (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
;;                                                     irony-cdb-clang-complete))

;;     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;     ))

;; ;; I use irony with company to get code completion.
;; (use-package company-irony
;;   :after company irony
;;   :config
;;   (progn
;;     (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; ;; I use irony with flycheck to get real-time syntax checking.
;; (use-package flycheck-irony
;;   :after flycheck irony
;;   :config
;;   (progn
;;     (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; ;; Eldoc shows argument list of the function you are currently writing in the echo area.
;; (use-package irony-eldoc
;;   :after eldoc irony
;;   :config
;;   (progn
;;     (add-hook 'irony-mode-hook #'irony-eldoc)))

;; (use-package rtags
;;   :config
;;   (progn
;;     (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
;;     (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

;;     (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
;;     (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
;;     (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
;;     (rtags-enable-standard-keybindings)

;;     (setq rtags-use-helm t)

;;     ;; Shutdown rdm when leaving emacs.
;;     (add-hook 'kill-emacs-hook 'rtags-quit-rdm)
;;     ))


;; (use-package rtags-xref
;;   :ensure nil
;;   :after (rtags)
;;   :config
;;   (add-hook 'c-mode-common-hook #'rtags-xref-enable))

;; ;; Use rtags for auto-completion.
;; (use-package company-rtags
;;   :ensure nil
;;   :after company rtags
;;   :config
;;   (progn
;;     (setq rtags-autostart-diagnostics t)
;;     (rtags-diagnostics)
;;     (setq rtags-completions-enabled t)
;;     (push 'company-rtags company-backends)
;;     ))

;; (use-package flycheck-rtags
;;   :ensure nil
;;   :after flycheck rtags
;;   :config
;;   (progn
;;     ;; ensure that we use only rtags checking
;;     ;; https://github.com/Andersbakken/rtags#optional-1
;;     (defun setup-flycheck-rtags ()
;;       (flycheck-select-checker 'rtags)
;;       (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;;       (setq-local flycheck-check-syntax-automatically nil)
;;       (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
;;       )
;;     (add-hook 'c-mode-hook #'setup-flycheck-rtags)
;;     (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
;;     ))

;; (use-package gdscript-mode
;;     :straight (gdscript-mode
;;                :type git
;;                :host github
;;                :repo "godotengine/emacs-gdscript-mode"))

(quelpa '(gdscript-mode :fetcher github :repo "godotengine/emacs-gdscript-mode"))

(require 'gdscript-mode)
;;(setq gdscript-godot-executable "/run/current-system/sw/bin/godot")
(setq gdscript-godot-executable "/home/rob/.nix-profile/bin/godot")
(setq gdscript-use-tab-indents t) ;; If true, use tabs for indents. Default: t
(setq gdscript-indent-offset 4) ;; Controls the width of tab-based indents
;; Use this executable instead of 'godot' to open the Godot editor.
(setq gdscript-gdformat-save-and-format t) ;; Save all buffers and format them with gdformat anytime Godot executable is run.
(setq gdscript-docs-local-path "/home/rob/docs/godot-docs/index.rst")
(add-hook 'gdscript-mode-hook #'lsp)

(use-package processing-mode
  :config 
  (setq processing-location "/run/current-system/bin/processing")
  )

(use-package web-mode
  :mode ("\\.[tj]sx?\\'"))

(use-package css-mode
  :mode ("\\.css\\'"
         "\\.rasi\\'"))

(use-package json-mode
  :mode ("\\.json\\'"))

(use-package groovy-mode)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  ;; :mode (("README\\.md\\'" . gfm-mode)
  ;;        ("\\.md\\'" . markdown-mode)
  ;;        ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown")
  :config
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'outline-minor-mode)
  (add-hook 'markdown-mode-hook 'visual-line-mode)
  )

(use-package yaml-mode
  :defer t
  :mode (("\\.yaml\\'" . yaml-mode)))

;; prettier formatting
(use-package prettier-js
  :defer t
  :diminish prettier-js-mode
  :custom
  (prettier-js-args '("--trailing-comma" "none"
                      "--bracket-spacing" "true"
                      "--single-quote" "true"
                      "--no-semi" "true"
                      "--jsx-single-quote" "true"
                      "--jsx-bracket-same-line" "true"
                      "--print-width" "100")))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ;; ("C-c b" . consult-bookmark)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-project-imenu)
         ;; M-s bindings (search-map)
         ("M-s f" . consult-find)
         ("M-s L" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch)
         :map isearch-mode-map
         ("M-e" . consult-isearch)                 ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch)               ;; orig. isearch-edit-string
         ("M-s l" . consult-line))                 ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer.
  ;; This is relevant when you use the default completion UI,
  ;; and not necessary for Selectrum, Vertico etc.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-file consult--source-project-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; Optionally configure a function which returns the project root directory.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (project-roots)
  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project)))))
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-root-function #'projectile-project-root)
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-root-function #'vc-root-dir)
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-root-function (lambda () (locate-dominating-file "." ".git")))
)

(use-package speed-type :defer t)
(use-package spray
  :config
  (global-set-key (kbd "<f9>") 'spray-mode)
  (defun toggle-night ()
    (interactive)
    (if (equal (car custom-enabled-themes) 'naquadah)
        (override-theme 'leuven)
      (override-theme 'naquadah)))
  (add-hook 'spray-mode-hook 'toggle-night))

(use-package edebug)
(use-package rmsbolt)

(use-package scad-mode
  ;; :config
  ;; (add-to-list 'org-babel-load-languages '(scad . t))
  )

(use-package etags
  ;; :bind ("M-T" . tags-search)           ;
  )

(use-package deft
  :bind ("<f8>" . deft)
  :commands (deft)
  :config
  (setq
   deft-directory "~/org"
   deft-extensions '("md" "txt" "org")
   deft-recursive t
   ;; deft-use-filename-as-title t
   deft-use-filter-string-for-filename t
   deft-text-mode 'org-mode
   deft-org-mode-title-prefix t
   )
  ;; replace slashes and spaces with hyphens
  ;; and enforce lowercasing
  (setq deft-file-naming-rules
	'((noslash . "-")
          (nospace . "-")
          (case-fn . downcase)))
  ;; (global-set-key (kbd "C-c d") 'deft)
  (evil-define-key 'normal global-map
    ;; open deft
    (kbd "SPC 0") 'deft 		
    ;; find notes
    (kbd "SPC f d") 'deft-find-file 			
    )
  )

(quelpa '(notmuch :url "https://git.notmuchmail.org/git/notmuch" :fetcher git))
(require 'notmuch)

(use-package exec-path-from-shell
  :init
  (when (daemonp)
    (exec-path-from-shell-initialize)))

(use-package journalctl-mode)

;; escape quits
(global-set-key [escape] 'keyboard-escape-quit)         
(bind-key "<escape>" 'isearch-cancel isearch-mode-map)
(define-key minibuffer-local-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-ns-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-completion-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-must-match-map (kbd "ESC") 'abort-recursive-edit)
(define-key minibuffer-local-isearch-map (kbd "ESC") 'abort-recursive-edit)

(define-key minibuffer-local-map (kbd "C-h") 'vertico--backward-updir)
(define-key minibuffer-local-ns-map (kbd "C-h") 'vertico--backward-updir)


(define-key minibuffer-local-map (kbd "C-j") 'next-line-or-history-element)
(define-key minibuffer-local-ns-map (kbd "C-j") 'next-line-or-history-element)
(define-key minibuffer-local-completion-map (kbd "C-j") 'next-line-or-history-element)
(define-key minibuffer-local-must-match-map (kbd "C-j") 'next-line-or-history-element)
(define-key minibuffer-local-isearch-map (kbd "C-j") 'next-line-or-history-element)

(define-key minibuffer-local-map (kbd "C-k") 'previous-line-or-history-element)
(define-key minibuffer-local-ns-map (kbd "C-k") 'previous-line-or-history-element)
(define-key minibuffer-local-completion-map (kbd "C-k") 'previous-line-or-history-element)

(define-key minibuffer-local-must-match-map (kbd "C-k") 'previous-line-or-history-element)
(define-key minibuffer-local-isearch-map (kbd "C-k") 'previous-line)

(require 'server)
(unless (server-running-p)
  (server-start))

(use-package eval-expr
  ;; :bind ("M-:" . eval-expr)
  ;; :config
  ;; (defun eval-expr-minibuffer-setup ()
  ;;   (local-set-key (kbd "<tab>") #'lisp-complete-symbol)
  ;;   (set-syntax-table emacs-lisp-mode-syntax-table)
  ;;   (paredit-mode))
  )
