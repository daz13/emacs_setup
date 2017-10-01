(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key "\M-\C-n" 'outline-next-visible-heading)
            (local-set-key "\M-\C-p" 'outline-previous-visible-heading)
            (local-set-key "\M-\C-u" 'outline-up-heading)
            ;; table
            (local-set-key "\M-\C-w" 'org-table-copy-region)
            (local-set-key "\M-\C-y" 'org-table-paste-rectangle)
            (local-set-key "\M-\C-l" 'org-table-sort-lines)
            ;; display images
            (local-set-key "\M-I" 'org-toggle-iimage-in-org)))

(setq org-use-speed-commands t)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~david/Dropbox/org/refile.org")
               "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" )
              ("j" "Journal" entry (file+datetree "~david/Dropbox/org/refile.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~david/Dropbox/org/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

(setq org-todo-keyword-faces
    (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "orange" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("PROJ" :foreground "blue" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))

(setq org-agenda-files (quote ("~david/Dropbox/org")))

(setq org-agenda-custom-commands
  (quote
   (("n" "Agenda and all TODOs"
     ((agenda "" nil)
      (alltodo "" nil))
     nil)
    (" " "Agenda and NEXT Actions"
     ((agenda ""
	      ((org-agenda-overriding-header "Agenda")))
      (todo "NEXT"
	    ((org-agenda-overriding-header "Next Actions"))))
     nil nil)
    ("w" "Refile" tags "REFILE" nil)
    ("r" "Reading List" tags-todo "+CATEGORY=\"Read\"" nil)
    ("P" "Projects list" todo "PROJ"
     ((org-agenda-overriding-header "Projects List"))))))

;; ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)
