;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq
 ;; Font configuration.
 doom-font (font-spec :family "JetBrains Mono NL" :size 13)

 ;; Decrease delay until which-key pops up.
 which-key-idle-delay 0.3
 display-line-numbers-type nil

 doom-modeline-buffer-file-name-style 'relative-from-project
 doom-modeline-vcs-max-length 14
 ;; Do not show buffer encoding, most stuff is LF UTF-8 anyway.
 doom-modeline-buffer-encoding 'nil

 ;; Do not continue to comment new lines when o/O from a commented line.
 +evil-want-o/O-to-continue-comments 'nil

 ;; Switch to the new window after splitting.
 evil-split-window-below t
 evil-vsplit-window-right t

 ;; Show only file names in peek view.
 lsp-ui-peek-show-directory 'nil
 ;; Set (default) peek file list width.
 lsp-ui-peek-list-width 50
 )

;; Do not format on save in the following modes (plus the default ones).
(after! format
  (setq +format-on-save-enabled-modes
        (append +format-on-save-enabled-modes
                '(python-mode
                  cmake-mode
                  yaml-mode))))

(after! magit
  (magit-delta-mode +1))

;; My custom C-mode indentation settings.
(defun my-c-mode-common-hook ()
  (setq c-basic-offset 2)
  (c-set-offset 'brace-list-close 0)
  (c-set-offset 'brace-list-entry 0)
  (c-set-offset 'brace-list-intro '+)
  (c-set-offset 'func-decl-cont 0)
  (c-set-offset 'label '+)
  (c-set-offset 'substatement 0)
  (c-set-offset 'topmost-intro 0)
  (c-set-offset 'topmost-intro-cont 0)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(load! "+doom-modeline")
