(starter-kit-install-if-needed 'golden-ratio)
(require 'golden-ratio)
(golden-ratio-mode 1)

(starter-kit-install-if-needed 'undo-tree)
(global-undo-tree-mode)

(starter-kit-install-if-needed 'neotree)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(starter-kit-install-if-needed 'helm)

(require 'helm)
(require 'helm-config)


;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)


(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(helm-autoresize-mode t)

;; (defun pl/helm-alive-p ()
;;   (if (boundp 'helm-alive-p)
;;       (symbol-value 'helm-alive-p)))

;; (add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

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

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
