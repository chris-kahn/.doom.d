;; Kahn's private DOOM-Emacs config
;;
;; Author: Chris Kahn <mail@kahn.pro>

;; Use macOS natural titlebar style
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

;; Global configuration before packages are loaded
(setq avy-background nil
      ns-use-proxy-icon nil ;; hide window title icon
      which-key-idle-delay 0.75 ;; delay for the keyboard shortcut helper
      display-line-numbers-type nil
      doom-font (font-spec :family "Fira Code" :size 16))

;; Highlight indentation configuration
(def-package! highlight-indent-guides
    :commands highlight-indent-guides-mode
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\•
        highlight-indent-guides-delay 0.01
        highlight-indent-guides-responsive 'top
        highlight-indent-guides-auto-enabled t))

;; Add groovy/Jenkinsfile support
(def-package! groovy-mode)

;; Adds text surrounding capabilities
(def-package! evil-surround
  :config
  (global-evil-surround-mode 1))

;; Avy configuration (like easymotion)
(after! avy
  (setq avy-all-windows nil))

;; ace-window, like avy but for switching panes
(after! ace-window
  (set-face-attribute
     'aw-leading-char-face nil
     :foreground "deep sky blue"
     :weight 'bold
     :height 3.0))

;; Magit configuration
(after! magit
    (map! :map with-editor-mode-map
        :localleader
        (:desc "Save"                    :nvm "s" #'with-editor-finish
         :desc "Cancel"                  :nvm "c" #'with-editor-cancel)))

;; Global keybindings
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
