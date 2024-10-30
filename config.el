;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq
 ;; Font configuration.
 doom-font (font-spec
            :family "JetBrainsMono NF"
            :size (if (string-equal (system-name) "netbook") 14 13))

 doom-symbol-font (font-spec :family "Noto Color Emoji")
 nerd-icons-font-names '("SymbolsNerdFontMono-Regular.ttf")

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

;; Do not format on save in the following modes.
(after! format
  (setq +format-on-save-disabled-modes
        '(python-mode
          cmake-mode
          yaml-mode)))

(add-hook! 'latex-mode-hook 'turn-on-auto-fill)

(after! magit
  (magit-delta-mode +1))

;; From https://github.com/minad/consult/issues/318#issuecomment-882067919
(defun add-consult-line-to-evil-history (&rest _)
  "Add latest `consult-line' search pattern to the evil search history ring.
   This only works with orderless and for the first component of the search."
  (when (and (bound-and-true-p evil-mode)
             (eq evil-search-module 'evil-search))
    (let ((pattern (car (orderless-pattern-compiler (car consult--line-history)))))
      (add-to-history 'evil-ex-search-history pattern)
      (setq evil-ex-search-pattern (list pattern t t))
      (setq evil-ex-search-direction 'forward)
      (when evil-ex-search-persistent-highlight
        (evil-ex-search-activate-highlight evil-ex-search-pattern)))))
(advice-add #'consult-line :after #'add-consult-line-to-evil-history)

;;; Extra key binds
(map! :leader
      :prefix ("p" . "project")
      :desc "List project todos"
      "t" #'magit-todos-list)

;;; :lang rust
(setq
 lsp-inlay-hint-enable t
 lsp-rust-analyzer-cargo-watch-command "clippy"
 lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial"
 lsp-rust-analyzer-display-chaining-hints t
 lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil
 lsp-rust-analyzer-display-closure-return-type-hints t
 lsp-rust-analyzer-display-parameter-hints nil
 lsp-rust-analyzer-display-reborrow-hints nil
 )

;;; :lang org
(setq +org-roam-auto-backlinks-buffer nil
      org-directory "~/org/"
      org-roam-directory org-directory
      org-roam-dailies-directory "journal/"
      org-roam-db-location (concat org-roam-directory ".org_roam.db")
      org-agenda-files (flatten-list (list org-directory (mapcar (lambda (subdir) (concat org-directory subdir))
                                                                 ["book" "contact"])))
      )

(add-hook! 'org-mode-hook 'turn-on-auto-fill)

(after! org
  (setq org-startup-folded 'showeverything
        org-ellipsis " [...]"
        org-capture-templates
        '(("t" "Todo" entry (file+headline "todo.org" "Unsorted")
           "* TODO %?"
           :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "* %u %?\n%i\n%a"
           :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i\n%a"
           :prepend t)
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a"
           :prepend t)
          ("pn" "Project-local notes" entry
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a"
           :prepend t)
          ("pc" "Project-local changelog" entry
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a"
           :prepend t)
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t))
        ))

(after! org-roam
  (setq
   org-roam-capture-templates
   `(
     ("b" "book" plain
      ,(format "#+title: ${title}\n%%[%s/org_capture_templates/book.org]" doom-user-dir)
      :target (file "book/%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("c" "contact" plain
      ,(format "#+title: ${title}\n%%[%s/org_capture_templates/contact.org]" doom-user-dir)
      :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("d" "default" plain
      ,(format "#+title: ${title}\n%%[%s/org_capture_templates/default.org]" doom-user-dir)
      :target (file "%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("h" "how-to" plain
      ,(format "#+title: ${title}\n%%[%s/org_capture_templates/how_to.org]" doom-user-dir)
      :target (file "how-to/%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     )
   org-roam-dailies-capture-templates
   '(("d" "default" entry
      "* %?"
      :target (file+head "%<%Y-%m-%d>.org" "#+title: %<%B %d, %Y>\n\n")
      :jump-to-captured t)
     )
   )
  )

(load! "+doom-modeline")
