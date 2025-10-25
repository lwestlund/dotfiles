;;; ~/.doom.d/+doom-modeline.el -*- lexical-binding: t; -*-

(after! doom-modeline
  ;; Overload doom-modeline-update-vcs-text to show custom vcs branch name.
  (defun doom-modeline-update-vcs-text (&rest _)
    "Update text of vcs state in mode-line."
    (setq doom-modeline--vcs-text
          (when (and vc-mode buffer-file-name)
            (let* ((backend (vc-backend buffer-file-name))
                   (state (vc-state buffer-file-name backend))
                   (str (if vc-display-status
                            (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2))
                          "")))
              (propertize (if (> (length str) doom-modeline-vcs-max-length)
                              (if (string= (substring str 0 8) "feature/")
                                  (concat "f" (substring str (length "feature")))
                                (if (string= (substring str 0 8) "nomerge/")
                                    (concat "nm" (substring str (length "nomerge")))
                                  str
                                  ))
                            str)
                          ;; (concat
                          ;;  (substring str 0 (- doom-modeline-vcs-max-length 3))
                          ;;  "...")
                          ;; str)
                          'mouse-face 'mode-line-highlight
                          'face (cond ((eq state 'needs-update)
                                       'doom-modeline-warning)
                                      ((memq state '(removed conflict unregistered))
                                       'doom-modeline-urgent)
                                      (t 'doom-modeline-info)))))))
  )
