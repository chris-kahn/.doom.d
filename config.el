;; Kahn's private DOOM-Emacs config
;;
;; Author: Chris Kahn <mail@kahn.pro>

;; Use macOS natural titlebar style
(add-to-list 'default-frame-alist
             '(ns-transparent-titlebar . t))

(setq auto-mode-alist (append '(("\\.rest$" . restclient-mode))
      auto-mode-alist))

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

;; taken from spacemacs & adjusted for my own needs
(defun kankurisu/ediff-dotfile-and-template ()
  "ediff the current `dotfile' with the template"
  (interactive)
  (ediff-files
   "~/.doom.d/init.el"
   "~/.emacs.d/init.example.el"))

(def-package! lsp-mode
  :after (:any cc-mode
               c-mode
               c++-mode
               objc-mode
               python
               haskell-mode
               rust-mode
               caml-mode
               vue-mode
               rjsx-mode
               js2-mode
               web-mode
               css-mode
               scss-mode
               sass-mode
               less-mode
               stylus-mode)
  :config
  (setq lsp-enable-eldoc t
        lsp-eldoc-render-all t
        lsp-hover-text-function 'lsp--text-document-signature-help
        lsp-enable-completion-at-point t))

(def-package! lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-sideline-enable nil))

;; (def-package! lsp-typescript
;;   :after lsp-mode
;;   :config
;;   (add-hook 'js-mode-hook #'lsp-typescript-enable)
;;   (add-hook 'js2-mode-hook #'lsp-typescript-enable) ;; for js2-mode support
;;   (add-hook 'rjsx-mode #'lsp-typescript-enable))

(def-package! lsp-javascript-typescript
  :after lsp-mode
  :config
  (add-hook 'js-mode-hook #'lsp-javascript-typescript-enable)
  (add-hook 'typescript-mode-hook #'lsp-javascript-typescript-enable) ;; for typescript support
  (add-hook 'js2-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
  (add-hook 'js3-mode-hook #'lsp-javascript-typescript-enable) ;; for js3-mode support
  (add-hook 'rjsx-mode #'lsp-javascript-typescript-enable))

(def-package! company-posframe
  :config
  (company-posframe-mode 1))

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

    (:desc "Diff private config"   :nvm "hu" #'kankurisu/ediff-dotfile-and-template)

    (:prefix "c"
     :desc "Describe at point"     :nvm "c"  #'lsp-describe-thing-at-point
     :desc "Imenu"                 :nvm "i"  #'helm-semantic-or-imenu
     :desc "Imenu Anywhere"        :nvm "I"  #'helm-imenu-anywhere
     :desc "Peek references"       :nvm "pr" #'lsp-ui-peek-find-references
     :desc "Peek definitions"      :nvm "pd" #'lsp-ui-peek-find-definitions
     :desc "Peek references"       :nvm "pi" #'lsp-ui-peek-find-implementation
     :desc "(Un)comment selection" :nvm "/"  #'comment-or-uncomment-region
     :desc "(Un)comment line"      :nvm "l"  #'comment-line
      )

    (:desc "open" :prefix "f"
     :desc "Safe file"       :nvm "s" #'save-buffer
      )

    (:desc "open" :prefix "o"
     :desc "Project sidebar"       :nvm "p" #'treemacs
      )
    ))
