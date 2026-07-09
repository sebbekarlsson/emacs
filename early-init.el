;;; early-init.el --- Early init -*- lexical-binding: t; -*-
(setq package-enable-at-startup nil)
(setq gc-cons-threshold most-positive-fixnum)
(setq inhibit-startup-message t)
;; Silence async native-compilation warnings from third-party packages
;; (e.g. lsp-treemacs macros not known at compile time).
(setq native-comp-async-report-warnings-errors 'silent)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
