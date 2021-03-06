(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-mode t nil (ido))
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(js-switch-indent-offset 2)
 '(org-confirm-babel-evaluate nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; https://github.com/purcell/exec-path-from-shell
;; only use exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
;;(when (memq window-system '(mac ns))
;;  (exec-path-from-shell-initialize))

(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2)
            (setq indent-tabs-mode nil)))


(add-hook 'js-mode-hook
          (lambda()
           (setq js-indent-level 2)
           (setq indent-tabs-mode nil)
	    (setq-local comment-auto-fill-only-comments t)
	    (auto-fill-mode 1)
	    ))

(put 'downcase-region 'disabled nil)

(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
(put 'upcase-region 'disabled nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(setq org-log-done 'time)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((sh . t)))

(setq org-html-doctype "html5")


(setq org-html-html5-fancy t)

;; web mode
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.react.js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . web-mode))

(setq web-mode-engines-alist
      '(
        ("django"    . "\\.html\\'")
        )
)

(setq web-mode-content-types-alist
      '(
        ("jsx"  . ".*\\.react.js\\'")
        ("jsx"  . ".*\\.js\\'")
	)
      )


(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
	ad-do-it)
    ad-do-it))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2)
  ;; doesn't work as only inserts single leading '/' :(
;;  (setq-local comment-auto-fill-only-comments t)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'web-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
	    (setq-local comment-auto-fill-only-comments t)
	    (auto-fill-mode 1)
	    ))


;; From http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html#customizing_indent
;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		          '(json-jsonlist)))

;; https://github.com/justjake/eslint-project-relative
(setq flycheck-javascript-eslint-executable "eslint-project-relative")
;; --------------------------------------------------

(global-set-key (kbd "C-x f") 'find-file-in-repository)

(load-theme 'atom-dark t)

(setq org-publish-project-alist
      '(("org"
	 :base-directory "~/marvel/prototype-viewer"
	 :publishing-directory "~/public_html"
	 ))
      )

(require 'editorconfig)
(editorconfig-mode 1)

(dumb-jump-mode)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-.") 'helm-imenu-anywhere)

;; (add-hook 'flycheck-mode-hook 'flycheck-list-errors)
