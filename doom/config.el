;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;; 设置默认字体为 Monaspace Krypton
(setq doom-font (font-spec :family "Monaspace Krypton" :size 18 :weight 'regular))

;; 设置 Unicode 字符使用 Nerd Font
(setq doom-unicode-font (font-spec :family "Nerd Font" :size 18 ))

;; 如果需要，可变宽字体设置为 Monaspace Krypton
(setq doom-variable-pitch-font (font-spec :family "Monaspace Krypton" :size 18 ))

;; 设置大字体模式为 Monaspace Krypton
(setq doom-big-font (font-spec :family "Monaspace Krypton" :size 24 :weight 'bold))


;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;my config
;; avg plugin
;; 安装 avy
;; 安装 avy
(use-package! avy
  :defer t
  :config
  ;; 自定义 avy 命令以允许跨窗口跳转
  (defun avy-goto-char-in-windows ()
    "Jump to char in visible windows."
    (interactive)
    (let ((avy-all-windows t))
      (avy-goto-char-timer))))

  ;; 绑定自定义命令到快捷键
  (map! :leader
        :desc "Avy go to char in windows"
        "j j" #'avy-goto-char-in-windows)


;; 定义函数来执行 ff-find-other-file
(defun my-cpp-switch-header-source ()
  "Switch between source and header file in C++ projects."
  (interactive)
  (ff-find-other-file nil t))

;; 设置键绑定，使用 leader m g a 调用 ff-find-other-file
(map! :leader
      :desc "Switch between header/source file" "m g a" #'my-cpp-switch-header-source)

;;使用spce m g A 打开窗口并切换头文件源文件
(defun switch-and-open-window ()
  "Switch between header/source file and open in a new window."
  (interactive)
  (progn
    (my-cpp-switch-header-source)
    (evil-window-split)
    (my-cpp-switch-header-source)))

(map! :leader
      :desc "Split and switch between header/source file"
      "m g A" #'switch-and-open-window)


;; 绑定 expand-region 快捷键
(map! :leader
      :desc "Expand region"
      "v" #'er/expand-region)

;; 设置选中区域的颜色为较深版本
(custom-set-faces
 '(region ((t (:background "#9766c7" :foreground unspecified)))))


