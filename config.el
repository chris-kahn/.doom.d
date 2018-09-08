(setq display-line-numbers-type nil)

(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

(setq doom-font (font-spec :family "Fira Code" :size 16)
      avy-background nil
      )

(def-package! highlight-indent-guides
    :commands highlight-indent-guides-mode
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character
          highlight-indent-guides-character ?\•
          highlight-indent-guides-delay 0.01
          highlight-indent-guides-responsive 'top
          highlight-indent-guides-auto-enabled t))

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
