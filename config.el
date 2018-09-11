(setq display-line-numbers-type nil)

(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

(setq avy-background nil
      ns-use-proxy-icon nil ;; hide window title icon
      doom-font (font-spec :family "Fira Code" :size 16))

(def-package! highlight-indent-guides
    :commands highlight-indent-guides-mode
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\•
        highlight-indent-guides-delay 0.01
        highlight-indent-guides-responsive 'top
        highlight-indent-guides-auto-enabled t))

(def-package! groovy-mode)

(def-package! evil-surround
  :config
  (global-evil-surround-mode 1))

(after! ace-window
  (set-face-attribute
     'aw-leading-char-face nil
     :foreground "deep sky blue"
     :weight 'bold
     :height 3.0))

(after! avy
  (setq avy-all-windows nil))

(map!
  (:leader
    (:desc "buffer" :prefix "b"
     :desc "Next buffer"           :nvm "n" #'next-buffer
     :desc "Previous buffer"       :nvm "p" #'previous-buffer)

    (:desc "jump" :prefix "j"
     :desc "Jump to char"          :nvm "j" #'avy-goto-char
     :desc "Jump to word"          :nvm "w" #'avy-goto-word-1
     :desc "Jump to subword"       :nvm "s" #'avy-goto-subword-1
     :desc "Jump to line"          :nvm "l" #'avy-goto-line
     :desc "Jump to window"        :nvm "p" #'ace-window
    )

    (:desc "open" :prefix "o"
     :desc "Project sidebar"       :nvm "p" #'treemacs
      )
    ))

(after! magit
    (map! :map with-editor-mode-map
        :localleader
        (:desc "Commit"                 :nvm "c" #'with-editor-finish
         :desc "Abort"                  :nvm "a" #'with-editor-abort)))
