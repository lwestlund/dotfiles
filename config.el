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

(add-hook! 'latex-mode-hook 'turn-on-auto-fill)

(after! magit
  (magit-delta-mode +1))

;;; :lang org
(setq +org-roam-auto-backlinks-buffer t
      org-directory "~/org/"
      org-roam-directory org-directory
      org-roam-dailies-directory "journal/"
      org-roam-db-location (concat org-roam-directory ".org_roam.db")
      org-agenda-files (list org-directory)
      )

(add-hook! 'org-mode-hook 'turn-on-auto-fill)

(after! org
  (setq org-startup-folded 'showeverything
        org-ellipsis " [...]"
        org-capture-templates
        '(("t" "Todo" entry (file+headline "todo.org" "Unsorted")
           "* [ ] %?\n%i\n%a"
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
      ,(format "#+title: ${title}\n%%[%s/template/book.org]" org-roam-directory)
      :target (file "book/%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("c" "contact" plain
      ,(format "#+title: ${title}\n%%[%s/template/contact.org]" org-roam-directory)
      :target (file "contact/%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("d" "default" plain
      ,(format "#+title: ${title}\n%%[%s/template/default.org]" org-roam-directory)
      :target (file "%<%Y%m%d%H%M%S>-${slug}.org")
      :unnarrowed t)
     ("h" "how-to" plain
      ,(format "#+title: ${title}\n%%[%s/template/how_to.org]" org-roam-directory)
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
